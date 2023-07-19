% Executa uma simulaçao genérica do FAST para obter dados para posterior
% VRFT nos dados para produçao de controlador PI
% Escolhe o controlador usado pela variavel VRFTControllerChoose,
% o tipo de vento pelo VRFTWindChoose
% e o arquivo .mat vai ser salvo na concatenação dessas duas strings
% clear all

%% Troca o Path do MATLAB
cd C:\FAST\CertTest


%% Controller setup
if ~exist('flag_auto')
    clear all
    close all
    VRFTControllerChoose='OLsin_3p_2down_250_shadIPC_18_PI_Td2o_10_5_nofwd';%'OLsin_3p_2down_250_shadIPC_18_PI_Td2o_5_15_nofwd'%'ganhoHTZG'%'OLsin_2down_250_IPC_18_PI_Td2o_10_05';%'08CL_100__18_PI_Td2o_10_05' %08CL_100__14_PI_Td2o_5_15
    VRFTWindChoose='f1422'%'ctrl_step';% 'stepshr' %f1422
    FILTERChoose=''  % htzg, jonk, ''
    extra='';
    overwritesave_flag_autoTest=1;
else
    close all
end

load(VRFTControllerChoose)

% checa se é um dos controladores padroes 
flag_ganho5mw=0; flag_ganhoHTZG=0;
if strcmp(VRFTControllerChoose(1:5),'ganho')
    ctrl_len=length(VRFTControllerChoose);
    switch ctrl_len
        case 8
            if strcmp(VRFTControllerChoose(1:8),'ganho5mw')
                flag_ganho5mw=1;
            end
        case 9
            if strcmp(VRFTControllerChoose(1:9),'ganhoHTZG')
                flag_ganhoHTZG=1;
            end
    end
end

% Simulink controller sample time block
ControllerSampleTime=-1;
%% Turbine and Wind files used
switch VRFTWindChoose
    case 'gust'
        input_fast='VRFT_PID_gust.fst'
    case 'stair'
        input_fast='VRFT_PID_stair.fst'
    case 'ctrl_step8'
        input_fast='VRFT_18.fst'
        step_ctrl_amp=.8;
        step_ctrl_time=60;
        angleOpPoint=14.92*pi/180;
        if flag_ganho5mw
            VRFTControllerChoose=strcat(VRFTControllerChoose,'LPV_');
            GKaux=[0.42088      0.29697      0.22221];
            numD=numD*GKaux(2) % ajuste f(beta)
        end
    case 'ctrl_step'
        input_fast='VRFT_18.fst'
        step_ctrl_amp=.5;
        step_ctrl_time=60;
        angleOpPoint=14.92*pi/180;
        if flag_ganho5mw
            VRFTControllerChoose=strcat(VRFTControllerChoose,'LPV_');
            GKaux=[0.42088      0.29697      0.22221];
            numD=numD*GKaux(2) % ajuste f(beta)
        end
        
        if flag_ganhoHTZG
            VRFTControllerChoose=strcat(VRFTControllerChoose,'LPV_');
            GKaux=[1 1 1] + [8.672/(10)     14.92/(10)      19.85/(10)]; % ganhos do escalonamento para 14, 18 e 22m/s do houtzager
            numD=numD*GKaux(2) % ajuste f(beta)
        end
       
    case 'ctrl_step18_008_'
        
        input_fast='VRFT_18.fst'
        step_ctrl_amp=.08;
        step_ctrl_time=60;
        angleOpPoint=14.92*pi/180;
        if flag_ganho5mw&&1
            VRFTControllerChoose=strcat(VRFTControllerChoose,'LPV_');
            GKaux=[0.42088      0.29697      0.22221];
            numD=numD*GKaux(2) % ajuste f(beta)
        end
        
        if flag_ganhoHTZG&&1
            VRFTControllerChoose=strcat(VRFTControllerChoose,'LPV_');
            GKaux=[1 1 1] + [8.672/(10)     14.92/(10)      19.85/(10)]; % ganhos do escalonamento para 14, 18 e 22m/s do houtzager
            numD=numD*GKaux(2) % ajuste f(beta)
        end
        
    case 'ctrl_step13' % para ctrlstep maior
        input_fast='VRFT_18.fst'
        step_ctrl_amp=.13;
        step_ctrl_time=60;
    case 'ctrl_step_14'
        input_fast='VRFT_14.fst'
        step_ctrl_amp=.5;
        angleOpPoint=8.672*pi/180;
        step_ctrl_time=60;
        if flag_ganho5mw&&1
            VRFTControllerChoose=strcat(VRFTControllerChoose,'LPV_');
            GKaux=[0.42088      0.29697      0.22221];
            numD=numD*GKaux(1) % ajuste f(beta)
            disp('C ajustado f(beta)')
        end
    case 'ctrl_step_22'
        input_fast='VRFT_22.fst'
        step_ctrl_amp=.5;
        angleOpPoint=19.85*pi/180;
        step_ctrl_time=60;
        if flag_ganho5mw
            VRFTControllerChoose=strcat(VRFTControllerChoose,'LPV_');
            GKaux=[0.42088      0.29697      0.22221];
            numD=numD*GKaux(3) % ajuste f(beta)
        end
    case 'wind_step'
        input_fast='VRFT_18.fst'
    case 'teste'
        input_fast='VRFT_teste.fst'
        step_ctrl_amp=.08;
        angleOpPoint=14.92*pi/180; % 18 m/s
        step_ctrl_time=200;
    case 'f1625'
        step_ctrl_time=30;
        input_fast='VRFT_f1625.fst'
        if flag_ganho5mw&&1
            VRFTWindChoose='LPV_f1625'
        end
    case 'f1422'
    input_fast='VRFT_f1422.fst'
        step_ctrl_time=30;
        if flag_ganho5mw&&1
            VRFTWindChoose='LPV_f1422'
        end
        
        if flag_ganhoHTZG&&1
            VRFTWindChoose='htzg_f1422'
        end
    case 'gustBianchi'
        input_fast='VRFT_gustBianchi'
        
    case 'stepshr'
        step_ctrl_time=100;
        input_fast='VRFT_stepshr.fst'
end
Read_FAST_Input

%% carrega measure filter

switch FILTERChoose
    
    case 'jonk'
        load FilterData
%         extra='jonk'
    case 'htzg'
        load FilterHTZG
    otherwise
        % no filter:
            numFilter=1;
            denFilter=1;
            FILTERChoose=''
        
end
%% Abre e executa o simulink
switch VRFTWindChoose
    case {'gust', 'stair'}
        angleOpPoint=8.7*pi/180; % 14 m/s
        open_system('VRFT_discreto_d')
        sim('VRFT_discreto_d')
    case {'ctrl_step','ctrl_step13','ctrl_step_14','ctrl_step_22','ctrl_step8','teste','ctrl_step18_008_'}
        open_system('VRFT_discreto_ctrl_step')
        sim('VRFT_discreto_ctrl_step')
    case {'f1625'}
        angleOpPoint=12*pi/180; % 16 m/s
        open_system('VRFT_discreto_d')
        sim('VRFT_discreto_d')
    case {'f1422','stepshr'}
        angleOpPoint=8.672*pi/180; % 14 m/s
        open_system('VRFT_discreto_d')
        sim('VRFT_discreto_d')
    case 'LPV_f1625'
        angleOpPoint=12*pi/180; % 16 m/s
        open_system('VRFT_discreto_ganho5mw')
        sim('VRFT_discreto_ganho5mw')
    case {'LPV_f1422','gustBianchi'}
        angleOpPoint=8.672*pi/180; % 14 m/s
        open_system('VRFT_discreto_ganho5mw')
        sim('VRFT_discreto_ganho5mw')
    case {'htzg_f1422'}
                angleOpPoint=8.672*pi/180; % 14 m/s
        open_system('VRFT_discreto_ganhoHTZG')
        sim('VRFT_discreto_ganhoHTZG')
end
%

%% Se for simulação do caso ctrl_step, calcula Jy e JyTd16

CalculaIAE
IAE

ChecaTheta
%% Plot
if ~exist('flag_auto')
    plot_geral
%     IAE
end

%% Calcula estatisticas do MLIFE

if strcmp(input_fast,'VRFT_f1422.fst') %apenas no caso desse vento
cd C:\FAST\CertTest\MLIFE\CertTest

[Fatigue, Statistics] = mlife('VRFT_f1422.mlif', 'C:\FAST\CertTest', strcat('.\MLIFEresults\',VRFTControllerChoose,VRFTWindChoose,FILTERChoose,extra));


  
cd C:\FAST\CertTest
end
%% save

if ~exist('overwritesave_flag_autoTest')
    overwritesave_flag_autoTest=0;
end



savefilename=strcat(VRFTControllerChoose,VRFTWindChoose,FILTERChoose,extra,'.mat');
folder_savefilename=strcat('C:\FAST\CertTest\VRFTcontrollerData\simulacoes\new\',savefilename)

if ~exist('Lz')
    Lz=1;
end

if ~exist('theta_cpc')
    theta_cpc=heta_out;
end
if ~exist('theta_ipc')
    theta_ipc=theta_cpc*0;
end
if ~exist('heta_out_3b')
    heta_out_3b= theta_cpc*[1 1 1];
end


if ~exist(savefilename,'file')||overwritesave_flag_autoTest
    disp(['workspace salvo em ',folder_savefilename])

    if ~exist('DTcontroller')
        DTcontroller=0.05;
    end

    if strcmp(input_fast,'VRFT_f1422.fst')%||strcmp(input_fast,'VRFT_stepshr.fst')
        % aqui tem as variaveis do MLIFE
        save(folder_savefilename,'heta_out','rotspeed','Time','wind','VRFTControllerChoose','VRFTWindChoose','DT','IAE','angleOpPoint','ref','TMax','numD','denD','Td','C','DTcontroller','maxThetaDiff','step_ctrl_time','FILTERChoose','rotspeed_filtered','Lz','heta_out_3b','TipDxb1','TipDxb2','TipDxb3','theta_cpc','theta_ipc','timeUntilFailureDataTable','lifetimeDamageDataTable')     
        % 'timeUntilFailureDataTable','lifetimeDamageDataTable'
    else
    save(folder_savefilename,'heta_out','rotspeed','Time','wind','VRFTControllerChoose','VRFTWindChoose','DT','IAE','angleOpPoint','ref','TMax','numD','denD','Td','C','DTcontroller','maxThetaDiff','step_ctrl_time','FILTERChoose','rotspeed_filtered','Lz')     
    end
    
    clear step_ref; % isso aqui é uma bobagem imensa
else
    disp('Tentativa de salvar workspace em cima de nome já utilizado')
    disp(['NAO foi salvo em ',savefilename])
end









% savefilename='ganho18porVRFTsimples.mat'; %stair
% savefilename='ganho22porVRFTsimples_gust.mat'; %gust









%% Salvando arquivos utilizados passado

% input_fast='VRFT_PID.fst % FST de desenvolvimento

% input_fast='VRFT_PID_stair.fst % utilizado escada de vento, 12 a 22 em
% saltos de 2

% input_fast='VRFT_PID_gust.fst % bianchi Gust

