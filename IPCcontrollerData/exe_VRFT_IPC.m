% Executa simulação no fast com IPC

%% Troca o Path do MATLAB
cd C:\FAST\CertTest


%% Controller setup
if ~exist('flag_auto')
    clear all
    close all   % CPC QUE USEI EM TODOS OS RESULTADOS: '08CL_100__18_PI_Td2o_10_05'
    VRFTControllerChoose='ganho5mw' %'08CL_100__18_PI_Td2o_10_05'
    IPCcontroller='noIPC'%'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o3__fwdIPC'%'OL_100_sq2_IPC_18_RessP2_TdR2o088_IPC'%OL_100_sq2_IPC_18_RessP2_TdR1k2o088_IPC'%'OL_100_sq2_IPC_18_RessP_TdR1k088_IPC'%'OL_100_sq2_IPC_18_RessP_TdR088_IPC'% 'noIPC';  %'noIPC';  %'OL_100_sq_IPC_18_RessP_Td1_IPC'; %'IPCvini'
    VRFTWindChoose='f1422shr'%'steady18_Shad' %'stepshr' %f1422shr
    FILTERChoose='htzg'  % htzg, jonk, ''
    extra='';
    overwritesave_flag_autoTest=1;
else
    close all
end

load(VRFTControllerChoose)
load(IPCcontroller)

% checa se é um dos controladores padroes
flag_ganho5mw=0; flag_ganhoHTZG=0;
if strcmp(VRFTControllerChoose(1:5),'ganho')
    ctrl_len=length(VRFTControllerChoose);
    switch ctrl_len
        case 8
            if strcmp(VRFTControllerChoose(1:8),'ganho5mw')
                flag_ganho5mw=1;
                %                 % ESCALONA O CONTROLADOR PRO PONTOP DE 15 GRAUS (18 MS)
                                numD=numD/2.2
                disp('ATENCAO ISSO EH TEMPORARIO')
                beep
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
    
    case 'f1422shr'
        input_fast='VRFT_f1422shr.fst'
        step_ctrl_time=130;
        if flag_ganho5mw&&1
%             VRFTWindChoose='LPV_f1422'
        end
        avgtip_op=1.929739204932934; % 18
        
        if flag_ganhoHTZG&&1
            VRFTWindChoose='htzg_f1422'
        end
    case 'stepshr'
        step_ctrl_time=100;
        input_fast='VRFT_stepshr.fst'
        avgtip_op=1.929739204932934; % 18
        %     avgtip_op=3.152649600568835; % 14 m/s
        
    case 'steady18' % this wind is 18 m/s until 100 seg, where it changes to 20 m/s in 1 second
        step_ctrl_time=60;
        input_fast='VRFT_steady18.fst'
        avgtip_op=1.929739204932934; % 18
        
    case 'steady18_Shad' % this wind is 18 m/s until 100 seg, where it changes to 20 m/s in 1 second
        % caso com shadow como descrito no slide
        step_ctrl_time=60;
        input_fast='VRFT_steady18_Shad.fst'
        avgtip_op=1.929739204932934; % 18
        
    case 'steady14_Shad' % this wind is 14 m/s until 100 seg, where it changes to 16 m/s in 1 second
        % caso com shadow como descrito no slide
        step_ctrl_time=60;
        input_fast='VRFT_steady14_Shad.fst'
        avgtip_op=1.929739204932934; % 18
        
    case 'steady22_Shad' % this wind is 14 m/s until 100 seg, where it changes to 16 m/s in 1 second
        % caso com shadow como descrito no slide
        step_ctrl_time=60;
        input_fast='VRFT_steady22_Shad.fst'
        avgtip_op=1.929739204932934; % 18
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
    
    case {'f1422shr','stepshr'}
        angleOpPoint=8.46*pi/180; % 14 m/s
        open_system('VRFT_IPC_dist')
        sim('VRFT_IPC_dist')
    case {'steady18','steady18_Shad','steady14_Shad','steady22_Shad'}
        angleOpPoint=14.73*pi/180; % 18 m/s
        open_system('VRFT_IPC_dist')
        sim('VRFT_IPC_dist')
        %         open_system('VRFT_IPC_dist_vini')
        %         sim('VRFT_IPC_dist_vini')
        
end
%

%% Se for simulação do caso ctrl_step, calcula Jy e JyTd16

CalculaIAE
IAE

ChecaTheta
%% Plot
if ~exist('flag_auto')
    plot_geral_IPC
    %     IAE
end

%% Calcula estatisticas do MLIFE

if strcmp(input_fast,'VRFT_f1422shr.fst')||strcmp(input_fast,'VRFT_steady18_Shad.fst')||strcmp(input_fast,'VRFT_steady22_Shad.fst')||strcmp(input_fast,'VRFT_steady14_Shad.fst') %apenas no caso desse vento
    cd C:\FAST\CertTest\MLIFE\CertTest
    
    if(strcmp(input_fast,'VRFT_steady18_Shad.fst'))
        mlife_settings='VRFT_steady18_Shad.mlif';
    end
    if(strcmp(input_fast,'VRFT_steady14_Shad.fst'))
        mlife_settings='VRFT_steady14_Shad.mlif';
    end
    if(strcmp(input_fast,'VRFT_steady22_Shad.fst'))
        mlife_settings='VRFT_steady22_Shad.mlif';
    end
    if(strcmp(input_fast,'VRFT_f1422shr.fst'))
        mlife_settings='VRFT_f1422shr.mlif';
    end
    [Fatigue, Statistics] = mlife(mlife_settings, 'C:\FAST\CertTest', strcat('.\MLIFEresultsIPC\',IPCcontroller,VRFTWindChoose,FILTERChoose,extra));
    
    
    
    cd C:\FAST\CertTest
end
%% save

if ~exist('overwritesave_flag_autoTest')
    overwritesave_flag_autoTest=0;
end

if ~exist('timeUntilFailureDataTable')
    timeUntilFailureDataTable=0;
    lifetimeDamageDataTable=0;
end

saved_vars={'heta_out','rotspeed','Time','wind','VRFTControllerChoose','VRFTWindChoose','DT','IAE','ITAE','maxThetaDiff','angleOpPoint','ref','TMax','numD','denD','Td','C','DTcontroller','maxThetaDiff','step_ctrl_time','FILTERChoose','rotspeed_filtered','Lz','IPCcontroller','TipDxb1','TipDxb2','TipDxb3','heta_out_3b','deflex','theta_cpc','theta_ipc','numD_IPC','denD_IPC','C_IPC','p_IPC','Td_IPC','timeUntilFailureDataTable','lifetimeDamageDataTable','IAE_TipDxb1'};



savefilename=strcat(IPCcontroller,VRFTWindChoose,FILTERChoose,extra,'.mat');
% savefilename='noIPC_ganho5mw_steady18_Shad'

folder_savefilename=strcat('C:\FAST\CertTest\IPCcontrollerData\simulacoes\',savefilename);

if ~exist('Lz')
    Lz=1;
end

if ~exist(savefilename,'file')||overwritesave_flag_autoTest
    disp(['workspace salvo em ',folder_savefilename])
    
    if ~exist('DTcontroller')
        DTcontroller=0.05;
    end
    
    
    save(folder_savefilename,saved_vars{:})
    
    
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
beep
