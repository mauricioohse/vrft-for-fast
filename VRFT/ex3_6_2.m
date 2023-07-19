% ex 3.6.2 - primeira parte.
% caso flexible VRFT - modo "automatico" de incluir os zeros da planta
% Nesse arquivo: Primeiro aplica-se o VRFT sem ser flexivel - mostrando que
% o método falha no caso da planta ter zeros NMP. Após, mostra-se o VRFT
% flexible para encontrar o zero e um controlador razoavel. Por fim,
% altera-se o Td desejado e aplica-se o VRFT classico novamente para
% comparação.

clear all
close all
% clc

% 1) primeira formulação do VRFT classico deu resultados diferentes do
% mostrado no livro, mas não vi erro da minha parte =( o controlador está
% diferente. Also, pq foi usado um experimento em loop fechado com um controlador e não um
% salto direto em G em malha aberta?
% - O controlador encontrado é totalmente instavel (mas isso é esperado) -
% mas se trocar o sinal de entrada encontra um controlador estavel :o

% 2) - No VRFT flexivel, parece que leva muito mais do que 30 iterações pro
%      ni e pi convergir. Possivelmente um erro no meu equacionamento?
% - Verificar se o Fz está correto T=n*Fz
% - Verificar o Mz (eq 3.33) - falamos disso na ultima vez mas só confirmar
% - O calculo de T por n deu diferente do laço com o controlador
%   T=CG/(1+CG). Isso é indicativo de um erro?
% - verificar J0 - parece ser mais um caso de função nao-causal


% 3) Acredito que como agora Td tem um zero NMP (z-1.2), não de pra
% calcular o r_ do jeito que eu tava calculando até agora (só observar q o
% r_ dá em magnitude 10^23). Acho que é obrigatorio obter então  phi(t)=
% C_*(1-Td)/Td*y, mas não consegui fazer assim 


%%
a=0.6;
G=zpk([1.2 .4],[0 0.3 0.8],1,1);
H=zpk([],[],1,1); % ruido branco
Td=zpk([0 0],[0.885 0.353+0.442031*1i 0.353-0.442031*1i],0.0706,1)
C_=[zpk([0 0],[1 0],1,1);zpk([0],[1 0],1,1);zpk([],[1 0],1,1);] % eq 3.57
C0=zpk([0.4 0.6],[1 0],-0.7,1);
Lz=Td*(1-Td)
% Lz=tf(1,1,1);

% Tdmod é o Td modificado apos aplicar VRFT flexivel uma vez e determinar o
% zero NMP (z=1.2)
%% 1) VRFT "classico"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Obter a saída y(t) para um estimulo u(t)
u=1*ones(50,1);
u_extendido=1*ones(51,1);
y_extendido=lsim(C0*G/(1+C0*G),u_extendido); % eq 3.58 <--------------------
% y_extendido=lsim(G,u_extendido);
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

e_f=lsim(Lz,e_);
phiL=lsim(C_,e_f);

%% 4. phi(t)= C_*(1-Td)/Td*y  - nao consegui fazer desse jeito
% Tz_phi=C_*(1-Td)/Td
% phi2=lsim(Tz_phi*tf_avanco,y);

% 5. filtrar o phi pihL=phi*L(z), L(z)=Td/(1-Td)
% Lz=Td*(1-Td)
% Lz_mat=[Lz 0 0; 0 Lz 0; 0 0 Lz];
% phiL=lsim(Lz_mat,phi);
%% 6. obtem o parametro p=(phiL*phiL)^-1*phiL*u
uL=lsim(Lz,u);
pclassico=(phiL'*phiL)^-1*phiL'*uL;
pclassico_semLz=(phi'*phi)^-1*phi'*u;

Cclassico=minreal(pclassico'*C_);
Cclassico_semLz=minreal(pclassico_semLz'*C_);
Tclassico=minreal(Cclassico*G/(1+Cclassico*G),1e-4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fim do VRFT "classico"
%% 2) VRFT Flexivel - encontrar os zeros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pd=[-0.7 0.7 -0.168]'; % valor inicial de C0

% Experimento
% u = idinput(1000,'prbs'); % usei o mesmo step em todos
% y=lsim(G,u);
y=lsim(C0*G/(1+C0*G),u); % eq 3.58 <--------------------


% Fz a partir da equação 3.60
Fz1=zpk([],[0.885 0.353+0.442031*1i 0.353-0.442031*1i],0.0706,1);
Fz2=zpk([0],[0.885 0.353+0.442031*1i 0.353-0.442031*1i],0.0706,1);
Fz3=zpk([0 0],[0.885 0.353+0.442031*1i 0.353-0.442031*1i],0.0706,1);



Fz=[Fz1; Fz2; Fz3]; % verificar se é isso
Lz=Td*(1-Td);  
uL=lsim(Lz,u);
% ni=arg min J0 (n,pi-1)
% pi=arg min J0 (ni,p)

%% loop de calculo de n e p % nao consegui fazer dar certo inicializando 
% com n
% teste com ni tal que Tzn0=td
n=[0 0 1]'; % esse n é o equivalente ao Td 
nbuff=[n];pbuff=[pd];
p=pd;
Lzn=Lz;
for i=1:100

%     u-p'*phi
%     lsqlin -> vai minizar o phi (C') e u (d)
%     Tdn=n'*Fz > tem que restringir que Td(1)=1
%     Substitui Td com z=1, e adiciona a restrição
%     Fz(1)'*n =1
        % phinovo = Fzw'     -> Lsqln - C
        % unovo   = CLz*y   -> d

        
        % Depois: olhar na tese o filtro da pag 62.

    % eq 3.32 e 3.33
% Calculo de ni
aux=lsim(p'*C_,y);
w=lsim(Lzn,u+aux);
Fzw=lsim(Fz,w);
aux1=(Fzw'*Fzw)^-1;  % verificar se está feito corretamente
aux2=(Fzw'*lsim(p'*C_*Lzn,y));
n=aux1*aux2;
Tdn=minreal(n'*Fz,1e-4);
Lzn=minreal(Tdn*(1-Tdn));


% Calculo de pi
v=lsim(Lzn*(1-n'*Fz),y); % parece q o numero q está errado (ordem de n)
Cv=lsim(C_,v);
aux3=(Cv'*Cv)^-1;
Mz=n'*Fz;  % verificar
aux4=Cv'*lsim(Mz*Lzn,u);
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
Tdmod=zpk([0 1.2],[0.885 0.353+0.442031*1i 0.353-0.442031*1i],-0.3532,1)
% 1. Obter a saída y(t) para um estimulo u(t)
u3=1*ones(500,1);
u_extendido3=1*ones(501,1);
y_extendido3=lsim(G,u_extendido3);
% y_extendido=lsim(C0*G/(1+C0*G),u_extendido); % eq 3.58 <--------------------
y3=y_extendido3(1:end-1);
% plot(y)

% 2. Obter r_, o sinal virtual onde Td*r_=y(t)
tf_avanco=tf(1,[1 0],1);
Td_inv3=Tdmod^-1*tf_avanco;
r_extendido3=lsim(Td_inv3,[y_extendido3]);
r_3=r_extendido3(2:end);
% Verifica y
y_teste3=lsim(Tdmod,r_3);
testey3=sum((y3-y_teste3).^2)

% 3. e_(t)=r_(t)-y(t); phi=C_e_
e_3=r_3-y3;
phi3=lsim(C_,e_3);


%% 4. phi(t)= C_*(1-Td)/Td*y
% Tz_phi=C_*(1-Tdmod)/Tdmod;
% phi2=lsim(Tz_phi*tf_avanco,y);

% 5. filtrar o phi pihL=phi*L(z), L(z)=Td/(1-Td)
Lzmod3=Tdmod*(1-Tdmod);
Lz_matmod=[Lzmod3 0 0; 0 Lzmod3 0; 0 0 Lzmod3];
phiL3=lsim(Lz_matmod,phi3);
%% 6. obtem o parametro p=(phiL*phiL)^-1*phiL*u
% u=u(1:499);
uL3=lsim(Lzmod3,u3);
pclassicomod=(phiL3'*phiL3)^-1*phiL3'*uL3

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

Cd=pclassico'*C_
Tclassico=Cd*G/(1+Cd*G);
Tclassico=minreal(Tclassico,1e-4)


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
subplot(4,1,1)
hold on
step(Td)
title('step em Td - comportamento desejado (porem impossivel pq znmp)')

subplot(4,1,2)
step(Tclassico)
title('step em Tzp (controlador VRFT classico, esperado instavel)')

subplot(4,1,3)
step(Tzp)
title('step em Tzp (controlador VRFT flexible)')

subplot(4,1,4)
step(Tclassicomod)
title('step em Tclassicomod (controlador VRFT com Td modificado)')









