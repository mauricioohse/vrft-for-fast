%% Example 3.1 do livro Bazanella controle baseado em dados
% Dado uma função de transferencia G(z), encontrar um controlador que em
% laço fechado torne Td(z)=(1-a)/(z-a) usando VRFT
% clc 
% clear all
% Passos:
% 0. Descobrir C_, o vetor parametrizado C=p*C_ que contém o tipo de
% controlador necessário para transoformar G em Td
% 1. Obter a saída y(t) para um estimulo u(t)
% 2. Obter r_, o sinal virtual onde Td*r_=y(t)
% 3. e_(t)=r_(t)-y(t)
% 4. phi(t)= C_*(1-Td)/Td*y
% 5. p=(phi*phi)^-1*phi*u

% G(z)= 0.5/(z-0.9)   - openloop
% Reference model (queremos chegar nisso): Td(z)=(1-a)/(z-a)

% Controlador ideal: Cd=Td/(G(1-Td))=(1-a)(z-b2)/(b1*(z-1)) - tipo PI
% Escolhido a=0.6, Td=0.4/(z-0.6)
G=tf(0.5,[1 -0.9],1);
Cd=0.8*tf([1 -0.9],[1 -1],1);
Td_teste=Cd*G/(1+Cd*G);
step=0.05;
% Passo 0. Descobrir C_, o vetor parametrizado C=p*C_ que contém o tipo de
% controlador necessário para transoformar G em Td

% Se Cd é PI, então C_=[z/(z-1); 1/(z-1)  < com esse vetor, Ass. By [e
% satisfeita

% 1. Obter a saída y(t) para um estimulo u(t)
%sinal de entrada
u=heta_out;
% Gera y virtual a step 1
y=rotspeed;

% 2. Obter r_, o sinal virtual onde Td*r_=y(t)
% Obtendo r: Td*r=y - inversa da TF com adição de dinamica rapida p ser causal
Td=tf([0.01242],[1  -0.9876],step)
fast=.1;
Td_fast=(1/Td)*tf(1,[1 0],step);
r_longo=lsim(Td_fast,[y]);
r_=r_longo(2:end);
y_teste=lsim(Td,r_);
%  r_=[1.25 1.625]';
 
% 3. e_(t)=r_(t)-y(t); phi=C_e_
tf_z=tf(1,[1 0],step);
C_=[tf([1 0],[1 -1],step);
    tf([1],[1 -1],step)];

e_=r_-y(1:end-1);
phi=lsim(C_,e_);

% 4. phi(t)= C_*(1-Td)/Td*y
% não consegui esse passo, C_*(1-Td)/Td é impróprio (n causal)
% C_=[z/(z-1); 1/(z-1)]
u_aux=ones(2,1);
y_aux=lsim(G,u_aux);


Tz_phi=minreal(C_*(1-Td));
phi_aux=lsim(Tz_phi,y(2:3));


% phi=[1.25 0; 2.375 1.250]


% 5. p=(phi*phi)^-1*phi*u
phi=phi';
p=(phi*phi')^-1*phi*u(1:end-1)
u_Td=lsim(Td,u(2:end));
% p_2=(phi_aux'*phi_aux)^-1*phi_aux'*u_Td;
% u=u(1:2);
% phi=phi';
% sum1=0; sum2=0;
% for i=1:length(u)
%     sum1=phi(:,i)*phi(:,i)'+sum1; %qx1 x 1xq
%     sum2=phi(:,i)*u(i)+sum2;
% end
% p_teste=sum1^-1*sum2

% 7. Calculo do critério Jy
% Jy=mean[(Tzp-Td)r]
% Tzp: Laço com o controlador encontrado
% Td: Laco desejado
C=p'*C_
% Tzp=C*G/(1+C*G)

% Jy=mean(lsim(Tzp-Td,r_))^2
% Jy_teste=mean(lsim(Td_teste-Td,r_))^2


%% Convert controler to continuoes time and extract KP and KI values

Cc=d2c(C,'zoh');
Cc=minreal(Cc)

Kp18=0.07115
Ki18=0.0672


