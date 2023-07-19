% ex 3.6.2 - primeira parte.
% caso flexible VRFT - modo "automatico" de incluir os zeros da planta
% Nesse arquivo: Primeiro aplica-se o VRFT sem ser flexivel - mostrando que
% o método falha no caso da planta ter zeros NMP. Após, mostra-se o VRFT
% flexible para encontrar o zero e um controlador razoavel. Por fim,
% altera-se o Td desejado e aplica-se o VRFT não flexivel novamente para
% comparação.

clear all
close all
clc

%% primeiro: flexible VRFT - modo "automatico" de incluir os zeros da planta
a=0.6;
G=zpk([1.2 .4],[0 0.3 0.8],1,1);
H=zpk([],[],1,1); % ruido branco
Td=zpk([0 0],[0.6 0.6 0.6],0.064,1)
C_=[zpk([0 0],[1 0],1,1);zpk([0],[1 0],1,1);zpk([],[1 0],1,1);]
C0=zpk([0.4 0.6],[1 0],-0.7,1);


%% 1) VRFT "classico"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Obter a saída y(t) para um estimulo u(t)
u=1*ones(500,1);
u_extendido=1*ones(501,1);
y_extendido=lsim(G,u_extendido);
y=y_extendido(1:end-1);
% plot(y)

% 2. Obter r_, o sinal virtual onde Td*r_=y(t)
tf_avanco=tf(1,[1 0],1);
Td_inv=Td^-1*tf_avanco
r_extendido=lsim(Td_inv,[y_extendido]);
r_=r_extendido(2:end);
% Verifica y
y_teste=lsim(Td,r_);
testey=sum((y-y_teste).^2)

% 3. e_(t)=r_(t)-y(t); phi=C_e_
e_=r_-y;
phi=lsim(C_,e_);


%% 4. phi(t)= C_*(1-Td)/Td*y
Tz_phi=C_*(1-Td)/Td
% phi2=lsim(Tz_phi*tf_avanco,y);

% 5. filtrar o phi pihL=phi*L(z), L(z)=Td/(1-Td)
Lz=Td*(1-Td)
Lz_mat=[Lz 0 0; 0 Lz 0; 0 0 Lz];
phiL=lsim(Lz_mat,phi);
%% 6. obtem o parametro p=(phiL*phiL)^-1*phiL*u
% u=u(1:499);
uL=lsim(Lz,u);
pclassico=(phiL'*phiL)^-1*phiL'*uL

Cclassico=minreal(pclassico'*C_);
Tclassico=minreal(Cclassico*G/(1+Cclassico*G),1e-4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fim do VRFT "classico"
%% VRFT Flexivel - encontrar o zeros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pd=[-0.7 0.7 -0.168]'; % valor inicial de C0

% Experimento
N=1000;
u = idinput(1000,'prbs'); % 
y=lsim(G,u); % não adicionei ruído 
Fz1=zpk([],[0.885 0.0353+0.564584*1i 0.0353-0.564584*1i],0.0706,1);
Fz2=zpk([0],[0.885 0.0353+0.564584*1i 0.0353-0.564584*1i],0.0706,1);
Fz3=zpk([0 0],[0.885 0.0353+0.564584*1i 0.0353-0.564584*1i],0.0706,1);


Fz=[Fz1; Fz2; Fz3]; % verificar se é isso
Lz=Td*(1-Td);  
uL=lsim(Lz,u);
% ni=arg min J0 (n,pi-1)
% pi=arg min J0 (ni,p)

%% loop de calculo de n e p % nao consegui fazer dar certo inicializando 
% com n
% teste com ni tal que Tzn0=td
n=[0 0 1]';
nbuff=[n];pbuff=[pd];
p=pd;
for i=1:30

% Calculo de ni
aux=lsim(p'*C_,y);
w=lsim(Lz,u+aux);
Fzw=lsim(Fz,w);
aux1=(Fzw'*Fzw)^-1;  % verificar se está feito corretamente
aux2=(Fzw'*lsim(p'*C_*Lz,y));
n=aux1*aux2;
    
% Calculo de pi
v=lsim(Lz*(1-n'*Fz),y); % parece q o numero q está errado (ordem de n)
Cv=lsim(C_,v);
aux3=(Cv'*Cv)^-1;
Mz=n'*Fz;  % verificar
aux4=Cv'*lsim(Mz*Lz,u);
p=aux3*aux4;



% Guarda valores da iteração
nbuff=[nbuff n];
pbuff=[pbuff p];
end
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM VRFT flexivel
%% 3) VRFT com Td modificado pra incluir o zero NMP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Com o Flexible VRFT aplicado, é descoberto um zero NMP em z=1.2.
% ASsim, podemos adaptar a função Td desejada e aplicar o VRFT usual
% eq 3.61
Tdmod=zpk([0 1.2],[0.885 0.0353+0.564584*1i 0.0353-0.564584*1i],-0.3532,1)
% 1. Obter a saída y(t) para um estimulo u(t)
u=1*ones(500,1);
u_extendido=1*ones(501,1);
y_extendido=lsim(G,u_extendido);
y=y_extendido(1:end-1);
% plot(y)

% 2. Obter r_, o sinal virtual onde Td*r_=y(t)
tf_avanco=tf(1,[1 0],1);
Td_inv=Tdmod^-1*tf_avanco;
r_extendido=lsim(Td_inv,[y_extendido]);
r_=r_extendido(2:end);
% Verifica y
y_teste=lsim(Tdmod,r_);
testey=sum((y-y_teste).^2)

% 3. e_(t)=r_(t)-y(t); phi=C_e_
e_=r_-y;
phi=lsim(C_,e_);


%% 4. phi(t)= C_*(1-Td)/Td*y
Tz_phi=C_*(1-Tdmod)/Tdmod;
% phi2=lsim(Tz_phi*tf_avanco,y);

% 5. filtrar o phi pihL=phi*L(z), L(z)=Td/(1-Td)
Lz=Tdmod*(1-Tdmod);
Lz_mat=[Lz 0 0; 0 Lz 0; 0 0 Lz];
phiL=lsim(Lz_mat,phi);
%% 6. obtem o parametro p=(phiL*phiL)^-1*phiL*u
% u=u(1:499);
uL=lsim(Lz,u);
pclassicomod=(phiL'*phiL)^-1*phiL'*uL

Cclassicomod=minreal(pclassicomod'*C_);
Tclassicomod=minreal(Cclassicomod*G/(1+Cclassicomod*G),1e-4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fim do VRFT com Td modificado pra incluir o zero NMP


%% Comparação em laço fechado


C=minreal(p'*C_)
Tzp=C*G/(1+C*G);
Tzp=minreal(Tzp,1e-4)  % Pq o calculo de Tzp com o controlador encontrado 
% dessa forma deu diferente de calcular por T= n'*Fz? não há ruido
Tzn=minreal(n'*Fz,1e-4);

Cd=pclassico'*C_
Tclassico=Cd*G/(1+Cd*G);
Tclassico=minreal(Tclassico,1e-4)




% Jy=mean(lsim(Tzp-Td,u))^2
Yd=lsim(Td,u);
Y=lsim(Tzp,u);
Jy=(Y-Yd)'*(Y-Yd)/length(u)


%% Comparação de desempenho ao step
close all

figure()
hold on
subplot(3,1,1)
hold on
step(Td)
title('step em Td')
subplot(3,1,2)
step(Tzp)
title('step em Tzp (controlador VRFT flexible)')
subplot(3,1,3)
step(Tclassicomod)
title('step em Tclassicomod (controlador VRFT com Td modificado')









