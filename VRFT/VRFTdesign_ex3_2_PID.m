%% Example 3.2 do livro Bazanella controle baseado em dados

% modo mais simples do VRFT. Necessário para executar:
% y - dados de saida do experimento
% u - dados de entrada do experimento
% C_ - espaço de possivels controladores
% Td - funçao em malha fechada do sistema desejado, discreto
% retorna: o controlador em espaço continuo Cc
if ~exist('flag_auto_design')
    clear all
    chooseTs='16';
    chooseData='005_up';
end
% load_namefile='VRFTdataCollect_005_1500_treated_18.mat';
% saveController_namefile='18PID_L_up_' % NAO COLOCAR .MAT


switch chooseData
    case '005_down'
        load_namefile='VRFTdataCollect_005_down_treated_18.mat';
        saveController_namefile='18PID_L_down_' % NAO COLOCAR .MAT
    case '005_up'
        load_namefile='VRFTdataCollect_005_up_treated_18.mat';
        saveController_namefile='18PID_L_up_' % NAO COLOCAR .MAT
end

extra='';

%% Load data
load(load_namefile)


if ~exist('flag_auto_design')
    quick_plot
end
saveFolder='C:\FAST\CertTest\VRFTcontrollerData\';


%% Variaveis de entrada:
DTcontroller=0.05;

u=heta_out_sOp;
y=rotspeed_sOp;
c1=tf(1,1,DTcontroller);
c2=zpk([0],1,1,DTcontroller);
c3=zpk(1,0,1,DTcontroller);
C_=[c1;c2;c3;];
% Td=tf([0.01242],[1  -0.9876],step);

ChooseTd;

%% 1. Obter r_, o sinal virtual onde Td*r_=y(t)
% Obtendo r: Td*r=y - inversa da TF com adição de dinamica rapida p ser causal
% fast=.1;
Td_fast=(1/Td)*tf(1,[1 0],DTcontroller);
r_longo=lsim(Td_fast,[y]);
r_=r_longo(2:end); % necessário cortar a primeira amostra devido ao avanço
y_teste=lsim(Td,r_);

% 2. e_(t)=r_(t)-y(t); phi=C_e_
e_=r_-y(1:end-1);
phi=lsim(C_,e_);

% 3. filtrar o phi pihL=phi*L(z), L(z)=Td^2/(1-Td)^2
Lz=Td*(1-Td);
e_f=lsim(Lz,e_);
phiL=lsim(C_,e_f);
utd=lsim(Lz,u);
%% 4. obtem o parametro p=(phiL*phiL)^-1*phiL*u
p=(phi'*phi)^-1*phi'*u(1:end-1);
pL=(phiL'*phiL)^-1*phiL'*utd(1:end-1);
% p_2=(phi_aux'*phi_aux)^-1*phi_aux'*utd(1:end-1);
% 
% obtençao do controlador 
Cp=minreal(p'*C_);
C=minreal(pL'*C_)

[numD, denD]= tfdata(C, 'v');
%% Save controller

SaveControllerData


%% Convert controler to continuoes time and extract KP and KI values

% Cc=d2c(minreal(C),'zoh');
% Cc=minreal(Cc)

% CcL=d2c(minreal(CL),'zoh');
% CcL=minreal(CcL)


