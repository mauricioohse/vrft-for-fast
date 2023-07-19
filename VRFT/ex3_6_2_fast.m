% ex 3.6.2 - primeira parte.
% caso flexible VRFT - modo "automatico" de incluir os zeros da planta
% Nesse arquivo: Primeiro aplica-se o VRFT sem ser flexivel - mostrando que
% o método falha no caso da planta ter zeros NMP. Após, mostra-se o VRFT
% flexible para encontrar o zero e um controlador razoavel. Por fim,
% altera-se o Td desejado e aplica-se o VRFT classico novamente para
% comparação.

clear all
close all
clc

% Aqui é só a formulação fast - VRFT flexivel p achar o zero, VRFT classico
% após achar o zero



%%
a=0.6;
G=zpk([1.2 .4],[0 0.3 0.8],1,1);
H=zpk([],[],1,1); % ruido branco
Td=zpk([0 0],[0.6 0.6 0.6],0.064,1)
C_=[zpk([0 0],[1 0],1,1);zpk([0],[1 0],1,1);zpk([],[1 0],1,1);] % usado sempre
C0=zpk([0.4 0.6],[1 0],-0.7,1);



%% 2) VRFT Flexivel - encontrar os zeros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pd=[-0.7 0.7 -0.168]'; % valor inicial de C0

% Experimento
N=1000;
u = ones(500,1); % usei o mesmo step em todos
y=lsim(G,u);

% Fz a partir da equação 3.60
Fz1=zpk([],[0.885 0.353+0.442031*1i 0.353-0.442031*1i],0.0706,1);
Fz2=zpk([0],[0.885 0.353+0.442031*1i 0.353-0.442031*1i],0.0706,1);
Fz3=zpk([0 0],[0.885 0.353+0.442031*1i 0.353-0.442031*1i],0.0706,1);

% Fz errado que antes funcionou ???
% Fz1=zpk([],[0.885 0.0353+0.564584*1i 0.0353-0.564584*1i],0.0706,1);
% Fz2=zpk([0],[0.885 0.0353+0.564584*1i 0.0353-0.564584*1i],0.0706,1);
% Fz3=zpk([0 0],[0.885 0.0353+0.564584*1i 0.0353-0.564584*1i],0.0706,1);


Fz=[Fz1; Fz2; Fz3]; % verificar se é isso
Lz=Td*(1-Td);  
uL=lsim(Lz,u);
% ni=arg min J0 (n,pi-1)
% pi=arg min J0 (ni,p)

%% loop de calculo de n e p % nao consegui fazer dar certo inicializando 
% com n
% teste com ni tal que Tzn0=td
n=[0 0 1]'; % atualmente esta começando com pd (que forma C0)
nbuff=[n];pbuff=[pd];
p=pd;
for i=1:50

    
    % eq 3.32 e 3.33
% Calculo de pi
v=lsim(Lz*(1-n'*Fz),y); % parece q o numero q está errado (ordem de n)
Cv=lsim(C_,v);
aux3=(Cv'*Cv)^-1;
Mz=n'*Fz;  % verificar
aux4=Cv'*lsim(Mz*Lz,u);
p=aux3*aux4;
    
% Calculo de ni
aux=lsim(p'*C_,y);
w=lsim(Lz,u+aux);
Fzw=lsim(Fz,w);
aux1=(Fzw'*Fzw)^-1;  % verificar se está feito corretamente
aux2=(Fzw'*lsim(p'*C_*Lz,y));
n=aux1*aux2;
    




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
Tdmod=zpk([0 -1.197],[0.6 0.6 0.6],-0.3242,1)
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
Lzmod=Tdmod*(1-Tdmod);
Lz_matmod=[Lzmod 0 0; 0 Lzmod 0; 0 0 Lzmod];
phiL=lsim(Lz_matmod,phi);
%% 6. obtem o parametro p=(phiL*phiL)^-1*phiL*u
% u=u(1:499);
uL=lsim(Lzmod,u);
pclassicomod=(phiL'*phiL)^-1*phiL'*uL

Cclassicomod=minreal(pclassicomod'*C_);
Tclassicomod=minreal(Cclassicomod*G/(1+Cclassicomod*G),1e-4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fim do VRFT com Td modificado pra incluir o zero NMP


%% Comparação em laço fechado


C=minreal(pbuff(:,end)'*C_)
Tzp=C*G/(1+C*G);
Tzp=minreal(Tzp,1e-4)  % Pq o calculo de Tzp com o controlador encontrado 
% dessa forma deu diferente de calcular por T= n'*Fz? 
Tzn=minreal(n'*Fz,1e-4);

% Cd=pclassico'*C_
% Tclassico=Cd*G/(1+Cd*G);
% Tclassico=minreal(Tclassico,1e-4)


% Jy=mean(lsim(Tzp-Td,u))^2
Yd=lsim(Td,u);
Y=lsim(Tzp,u);
Jy=(Y-Yd)'*(Y-Yd)/length(u)


% eq 3.24
% J0 - me parece que o termo (1-Tzn)*C/Tzn tem mais zeros q polos (mesmo
% problema do calculo de phi sem fazer os avanços?

% Tzn_Cy=lsim((1-Tzn)*C/Tzn,y);
% J0_sim=lsim(Lz,u+Tzn_Cy); % u = step
% J0= J0_sim*J0_sim'/length(J0_sim)
% yL= (1-Tzn)y(t) ?


% ~J0 - o que é o yL na equação 3.29?
%% Comparação de desempenho ao step
close all

figure()
hold on
subplot(3,1,1)
hold on
step(Td)
title('step em Td - comportamento desejado (porem impossivel pq znmp)')

subplot(3,1,2)
step(Tzp)
title('step em Tzp (controlador VRFT flexible)')

subplot(3,1,3)
step(Tclassicomod)
title('step em Tclassicomod (controlador VRFT com Td modificado)')









