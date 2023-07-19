%% Example 3.1 do livro Bazanella controle baseado em dados
clear all
close all
% modo mais simples do VRFT. Necessário para executar:
% y - dados de saida do experimento
% u - dados de entrada do experimento
% C_ - espaço de possivels controladores
% Td - funçao em malha fechada do sistema desejado, discreto

load('C:\FAST\Fast7\CertTest\VRFTdata\VRFTdatacollect_down_treated_2_18')
quick_plot
% retorna: o controlador em espaço continuo Cc

%% Variaveis de entrada:
DT=0.05;

% u=heta_out;
% y=rotspeed;
u=heta_out_sOp;
y=rotspeed_sOp;
C_=[tf([1 0],[1 -1],DT);
    tf([1],[1 -1],DT)];
% Td=tf([0.01242],[1  -0.9876],DT);
polo=0.98;
Td=tf([1-polo],[1  -polo],DT);


figure()
step(Td)
%% 1. Obter r_, o sinal virtual onde Td*r_=y(t)
% Obtendo r: Td*r=y - inversa da TF com adição de dinamica rapida p ser causal
Td_fast=(1/Td)*tf(1,[1 0],DT);
r_longo=lsim(Td_fast,[y]);
r_=r_longo(2:end); % necessário cortar a primeira amostra devido ao avanço
y_teste=lsim(Td,r_);

 
% 2. e_(t)=r_(t)-y(t); phi=C_e_
e_=r_-y(1:end-1);
phi=lsim(C_,e_);

% 3. p=(phi*phi)^-1*phi*u
phi=phi';
p=(phi*phi')^-1*phi*u(1:end-1);
u_Td=lsim(Td,u(2:end));

% obtençao do controlador 
C=minreal(p'*C_)




%% Convert controler to continuoes time and extract KP and KI values
% 
Cc=d2c(C,'zoh');
Cc=minreal(Cc)
% 
% Cd=c2d(Cc,step,'zoh');
% Cd=minreal(Cd)

%% Datas

% load('VRFTdataFew2_18.mat') % coletado antigo, sem retirar op

