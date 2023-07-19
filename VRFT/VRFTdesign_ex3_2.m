%% Example 3.2 do livro Bazanella controle baseado em dados

% modo mais simples do VRFT. Necessário para executar:
% y - dados de saida do experimento
% u - dados de entrada do experimento
% C_ - espaço de possivels controladores
% Td - funçao em malha fechada do sistema desejado, discreto
% retorna: o controlador em espaço continuo Cc
if ~exist('flag_auto_design')
    clear all
%     close all
    chooseTs='2o_5_30';
    chooseData='OLsin_3p_smol2DC_man_250_shadIPC_18'%'02_down100_14'%'OLsin_3p_2down_250_shadIPC_18'%'OLsin_2down_250_IPC_18'%'02_down50_18'%'OLsin_2down_250_IPC_18'%'OLsin_2down_250_IPC_18';%'08CL_100__14';
%      chooseData='02_down50_18';
    overwritesave_flag_controllerDesign=1;
    ChooseLz=''; % '_LZspec_' or ''
    chooseMeasureFilter=''; % '',FilterData, FilterDataC_ 'jonk', 'htzg'
    extra=chooseMeasureFilter;
    ChooseForward='fwd';
%     extra='measureC_'
end



load_namefile=chooseData;
saveController_namefile=strcat(chooseData,'_'); % NAO COLOCAR .MAT




%% Load data
load(load_namefile)


if ~exist('flag_auto_design')
%     quick_plot
end
saveFolder='C:\FAST\CertTest\VRFTcontrollerData\';

if(~exist('heta_out_sOp'))
   disp('troca de variavel heta_out_sOp para heta_out_sOp_b1')
   heta_out_sOp=heta_out_sOp_b1;
end

DTcontroller=DT;
u=heta_out_sOp;



%% Variaveis de entrada:


if strcmp(chooseMeasureFilter,'')
    y=rotspeed_sOp;
elseif strcmp(chooseMeasureFilter,'FilterData')
    load(chooseMeasureFilter)
    y=lsim(Filter_tf,rotspeed_sOp,Time);
elseif strcmp(chooseMeasureFilter,'FilterDataC_')
    y=rotspeed_sOp;
    load FilterData
end

    plot(y)
    hold on

%% Escolha de C_


if ~exist('chooseCspace')
    chooseCspace='PI';
end
switch chooseCspace
    case 'PID'
        c1=tf(1,1,DTcontroller);
        c2=zpk([0],1,1,DTcontroller);
        c3=zpk(1,0,1,DTcontroller);
        C_=[c1;c2;c3;];
    case 'PI'
        C_=[tf([1 0],[1 -1],DTcontroller);
            tf([1],[1 -1],DTcontroller)];
    otherwise
        disp('NAO FOI SELECIONADO ESPAÇO DE CONTROLADORES VALIDO')
end
% Td=tf([0.01242],[1  -0.9876],step);
if strcmp(chooseMeasureFilter,'FilterDataC_')
 C_=C_*c2d(Filter_tf,0.05);
end



ChooseTd;

if strcmp(ChooseLz,'_LZspec_')
    vrft_spectr
    Lz=L;
else
    Lz=Td*(1-Td);
end


switch ChooseForward
    case 'fwd'
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




e_f=lsim(Lz,e_);
phiL=lsim(C_,e_f);
utd=lsim(Lz,u);
%% 4. obtem o parametro p=(phiL*phiL)^-1*phiL*u
% p=(phi'*phi)^-1*phi'*u(1:end-1);
p=(phiL'*phiL)^-1*phiL'*utd(1:end-1)

    case 'nofwd'
phi=lsim(C_*(1-Td),y)';

Lz=1-Td;

yL=lsim(Lz,y);
phiL=lsim(C_*(1-Td),yL)';


utd=lsim(Td,u)';
uL=lsim(Lz,utd)';
% uL=lsim(Lz,aux)';


p=(phiL*phiL')^-1*phiL*uL';

        
end



C=zpk(minreal(p'*C_))
% C=zpk(C)
[numD, denD]= tfdata(C, 'v');
%% Save controller


SaveControllerData

%% Convert controler to continuoes time and extract KP and KI values

% Cc=d2c(minreal(C),'zoh');
% Cc=minreal(Cc)

% CcL=d2c(minreal(CL),'zoh');
% CcL=minreal(CcL) VRFTdesign_IPC


