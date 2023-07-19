% Parte final do ex 3.6.2, agora com adição de ruído
% Primeiro, por VRFT flexivel (sem adição de IV), para encontrar os zeros
% de G
clc
clear all
close all

%% Definições do sistema
a=0.6;
G=zpk([1.2 .4],[0 0.3 0.8],1,1);
H=zpk([],[],1,1); % ruido branco
Td=zpk([0 0],[0.885 0.0353+0.564584*1i 0.0353-0.564584*1i],0.0706,1)
C_=[zpk([0 0],[1 0],1,1);zpk([0],[1 0],1,1);zpk([],[1 0],1,1);] % usado sempre
C0=zpk([0.4 0.6],[1 0],-0.7,1);
sigma=sqrt(0.005);



%% VRFT Flexivel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pd=[-0.7 0.7 -0.168]'; % valor inicial de C0

% Experimento
N=1000;
u = idinput(1000,'prbs'); % 
e1=sigma*randn(length(u),1);
y=lsim(G,u)+e1; % não adicionei ruído 
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
nVRFTf=n;
pVRFTf=p;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM VRFT flexivel

%% VRFT Flexivel + IV
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Experimento - IV roda experimento duas vezes
N=1000;
u = idinput(1000,'prbs'); % 
e1=sigma*randn(length(u),1);
e2=sigma*randn(length(u),1);
y=lsim(G,u)+e1; % não adicionei ruído ainda
y2=lsim(G,u)+e2;
Lz=Td*(1-Td);  % verificar (sei q ta errado mas n sei fazer)
Cd_apriori=zpk(0.9,1,1-a,1);


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
n=[0 0 1]';
nbuffiv=[n];pbuffiv=[pd];
p=pd;
for i=1:60

% Calculo de pi
v=lsim(Lz*(1-n'*Fz),y); % parece q o numero q está errado (ordem de n)
viv=lsim(Lz*(1-n'*Fz),y2);
Cviv=lsim(C_,viv);
Cv=lsim(C_,v);
aux3=(Cviv'*Cv)^-1;
Mz=n'*Fz;  % verificar
aux4=Cviv'*lsim(Mz*Lz,u);
p=aux3*aux4;
    
% Calculo de ni
aux=lsim(p'*C_,y);
auxiv=lsim(p'*C_,y2);
w=lsim(Lz,u+aux);
wiv=lsim(Lz,u+auxiv);
Fzw=lsim(Fz,w);
Fzwiv=lsim(Fz,wiv);
aux1=(Fzwiv'*Fzw)^-1;  % verificar se está feito corretamente
aux2=(Fzwiv'*lsim(p'*C_*Lz,y));
n=aux1*aux2;
    




% Guarda valores da iteração
nbuffiv=[nbuffiv n];
pbuffiv=[pbuffiv p];
end
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM VRFT flexivel + IV

%% Comp




