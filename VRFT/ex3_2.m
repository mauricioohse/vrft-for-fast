%% Example 3.2 do livro Bazanella controle baseado em dados

% Continua com duvida em pq nao consegui calcular phi pelo passo 4




% G(z)=0.5 (z-0.5) / (z-0.9)^2
% Td=1-a/z-a
% C(z)=pz/(z-1)

% Passos:
% 0. Descobrir C_, o vetor parametrizado C=p*C_ que contém o tipo de
% controlador necessário para transoformar G em Td
% 1. Obter a saída y(t) para um estimulo u(t)
% 2. Obter r_, o sinal virtual onde Td*r_=y(t)
% 3. e_(t)=r_(t)-y(t)
% 4. phi(t)= C_*(1-Td)/Td*y
% 5. pihL=phi*L(z), |L(z)|^2=Td^2/(1-Td)^2
% 6. p=(phiL*phiL)^-1*phiL*u
% 7. Calculo do critério Jy=mean[(Tzp-Td)r]

% clc 
clear all

% 1. Obter a saída y(t) para um estimulo u(t)
G=tf([0.5 -0.25],[1 -1.8 0.81],1)
u=1*ones(500,1);
u_extendido=1*ones(501,1);
y_extendido=lsim(G,u_extendido);
y=y_extendido(1:end-1);
% plot(y)

% 2. Obter r_, o sinal virtual onde Td*r_=y(t)
a=0.7;
Td=tf([1-a],[1 -a],1);
tf_avanco=tf(1,[1 0],1);
Td_inv=Td^-1*tf_avanco;
r_extendido=lsim(Td_inv,[y_extendido]);
r_=r_extendido(2:end);
% Verifica y
y_teste=lsim(Td,r_);
teste=sum((y-y_teste).^2);

% 3. e_(t)=r_(t)-y(t); phi=C_e_
C_=tf([1 0],[1 -1],1);
e_=r_-y;
phi=lsim(C_,e_);

%% 4. phi(t)= C_*(1-Td)/Td*y
%C_= [z/z-1]

Tz_phi=C_*(1-Td)/Td;
% phi2=lsim(Tz_phi*tf_avanco,y);

u_aux=ones(500,1);
y_aux=lsim(G,u_aux);


phi_aux=lsim(C_,y_aux);



% 5. filtrar o phi pihL=phi*L(z), L(z)=Td^2/(1-Td)^2
% erro: tinha q ser o modulo ao quadrado
Lz=Td*(1-Td);
phiL=lsim(Lz,phi);

utd=lsim(Lz,u);
%% 6. obtem o parametro p=(phiL*phiL)^-1*phiL*u

p=(phi'*phi)^-1*phi'*u
p_2=(phi_aux'*phi_aux)^-1*phi_aux'*utd;




uL=lsim(Lz,u);
pL=(phiL'*phiL)^-1*phiL'*uL


pMR=0.0035;
%% 7. Calculo do critério Jy
% Jy=mean[(Tzp-Td)r]
% Tzp: Laço com o controlador encontrado
% Td: Laco desejado
C=p*C_;
Tzp=C*G/(1+C*G);
Tzp=minreal(Tzp,1e-4);

CMR=pMR*C_;
TzpMR=CMR*G/(1+CMR*G);

CLz=pL*C_;
TzpL=CLz*G/(1+CLz*G);

% C=p*C_
% Tzp=C*G/(1+C*G)
r=ones(500,1);
% JyMR=mean(lsim(TzpMR-Td,r))^2*length(r)
% Jy=mean(lsim(Tzp-Td,r))^2*length(r)
Yd=lsim(Td,r);
Y=lsim(Tzp,r);
Jy=(Y-Yd)'*(Y-Yd)/length(r);

Y=lsim(TzpMR,r);
JyMR=(Y-Yd)'*(Y-Yd)/length(r);

Y=lsim(TzpL,r);
JyLz=(Y-Yd)'*(Y-Yd)/length(r);


%% Plot Jy

% p_plot=0.002:0.0001:0.016;
% 
% for i=1:length(p_plot)
%     Cz=p_plot(i)*C_;
%     Tz=Cz*G/(1+Cz*G);
%     Y=lsim(Tz,r);
%     Jy_plot(i)=(Y-Yd)'*(Y-Yd)/length(r);
% end
% 
% figure()
% plot(p_plot,Jy_plot)
% 
% [minJy,ind]=min(Jy_plot)
% pmin=p_plot(ind)