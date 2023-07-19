% Ex 3.3: Mostrar q se for de fase nao minima (NMP) se Td nao conter o
% mesmo zero o controlador fica instavel

% nao cheguei no mesmo controlador =( mas acho que nao é tao importante
% esse exemplo de se chegar exatamente no mesmo


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
clc 
clear all

%% Inicial
% Gz= (1.1-z)(z-0.8)/(z-0.9)^3
G=zpk([ 1.1 0.8],[.9 .9 .9],-1,1)

% Referencia Td
Td=zpk([0 0],[ .5 .5 .5],0.125,1)

% controlador PID C=p*C_=p*[1 (z/z-1) (z-1)/z]
c1=tf(1,1,1);
c2=zpk([0],1,1,1);
c3=zpk(1,0,1,1);
C_=[c1;c2;c3;]

t=0:1:600;
u=0.5+0.5*square(2*pi*t/200);
u=u';
%% 1
y_extendido=lsim(G,u);
y=y_extendido(2:end);


%% 2
tf_avanco=tf(1,[1 0],1);
Td_inv=Td^-1*tf_avanco
r_extendido=lsim(Td_inv,[y_extendido]);
r_=r_extendido(2:end);
% Verifica y
y_teste=lsim(Td,r_);
teste=sum((y-y_teste).^2)


%% 3. e_(t)=r_(t)-y(t); phi=C_e_

e_=r_-y;
phi=lsim(C_,e_);

% filtro
Lz=Td*(1-Td);
e_f=lsim(Lz,e_);
phiL=lsim(C_,e_f);
uL=lsim(Lz,u(1:end-1));

%% 6. obtem o parametro p
p=(phiL'*phiL)^-1*phiL'*uL;

% phi=phi';
% sum1=0; sum2=0;
% for i=1:(length(u)-1)
%     sum1=phi(:,i)*phi(:,i)'+sum1; %qx1 x 1xq
%     sum2=phi(:,i)*u(i)+sum2;
% end
% p=sum1^-1*sum2

C=p'*C_


Cc=d2c(C,'tustin');
Cc=minreal(Cc)



%% 7. Calculo do critério Jy
% Jy=mean[(Tzp-Td)r]
% Tzp: Laço com o controlador encontrado
% Td: Laco desejado
Tzp=C*G/(1+C*G);
Tzp=minreal(Tzp);

Jy=mean(lsim(Tzp-Td,r_))^2;





