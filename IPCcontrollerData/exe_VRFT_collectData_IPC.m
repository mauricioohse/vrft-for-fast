% Executa uma simulaçao genérica do FAST para obter dados para posterior
% VRFT
clear all
close all

%% Troca o Path do MATLAB
cd C:\FAST\CertTest

%% escolhe a config do controlador (openloop ou closedloop)

collectChoose='OLsin_3p_smol2DC_2'%'OLsin_3p_smol3DC';%'senoide_3p'%'OL_3p';
filterChoose=''; % '', jonk, htzg
extra='tst';

switch filterChoose
    case 'htzg'
        load FilterHTZG     % measure filter houtzager
    case 'jonk'
        load FilterData % filtro jonkman
    otherwise
        filterChoose=''
        denFilter=1;
        numFilter=1;
end

%% Wind files used
% input_fast='VRFT_pontops141822.fst' %no shr
% input_fast='VRFT_pontops141822shr.fst' % perfil de vento com steps em 14, 18 e 22 ms
input_fast='VRFT_pontops141822shrshad.fst' %with tower shadow
% 50 segundos de inicializaçao, 200 segundos para cada perfil de vento
Read_FAST_Input

if strcmp(input_fast,'VRFT_pontops141822shrshad.fst')
    extra='shad';
end
%% Default values:
white_noise_scale=0;

%% Abre e executa o simulink

switch collectChoose
    case 'openloop'
        % aqui é o sinal de entrada
        amp_square=-1*pi/180;        %1*pi/180;
        center_square=0;             %0.5*pi/180;
        square_period=100; %50 ou 100
        open_system('VRFT_dataCollect_IPCopenloop')
        sim('VRFT_dataCollect_IPCopenloop')
        
    case 'OL_3p'
        malha_str='OL_3p'
        % aqui é o sinal de entrada
        amp_square=-2*pi/180;        %1*pi/180;
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        open_system('VRFT_dataCollect_IPCopenloop3p')
        sim('VRFT_dataCollect_IPCopenloop3p')
        
    case 'closedloop'
        % no caso IPC, estamos dando um step na input (um disturbio de
        % entrada), e mantendo o CPC para controle de referencia em 12.1RPM
        amp_square=-2*pi/180;        %1*pi/180;
        center_square=0;             %0.5*pi/180;
        square_period=100; %50 ou 100
        % TMax=400;
        load ganhoHTZG    %         load ganho5mw
        ControllerSampleTime= DTcontroller;
        open_system('VRFT_dataCollect_IPCBaseline')
        sim('VRFT_dataCollect_IPCBaseline')
        
    case 'senoide'
        % aqui é o sinal de entrada
        amp_square=-2*pi/180
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str='OLsin'
        
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=amp_square/2;
        omega2=2*w;
        amp_omega2=amp_square/4;
        omega4=4*w;
        amp_omega4=amp_square/8;
        open_system('VRFT_dataCollect_IPCopenloop_sin')
        sim('VRFT_dataCollect_IPCopenloop_sin')
        
    case 'senoide_3p'
        % aqui é o sinal de entrada
        amp_square=-2*pi/180
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str='OLsin_3p'
        
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=amp_square/2;
        omega2=2*w;
        amp_omega2=amp_square/4;
        omega4=4*w;
        amp_omega4=amp_square/8;
        open_system('VRFT_dataCollect_IPCopenloop_sin3p')
        sim('VRFT_dataCollect_IPCopenloop_sin3p')
        
    case 'OLsin23om1_3p'
        % OLsin23o_3p = open loop, senoidal + onda quadrada,
        % com senoides de frequencia em 2 e 3 harmonica + fundamental,
        % usando CPC (3p) e modulo 1 (pesos randomicos)
        % aqui é o sinal de entrada
        amp_square=-2*pi/180
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str='OLsin23om1_3p'
        
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=amp_square/2;
        omega2=2*w;
        amp_omega2=amp_square/4;
        omega4=3*w;
        amp_omega4=amp_square/4;
        open_system('VRFT_dataCollect_IPCopenloop_sin3p')
        sim('VRFT_dataCollect_IPCopenloop_sin3p')
        
    case 'OLsin23om2_3p'
        % OLsin23o_3p = open loop, senoidal + onda quadrada,
        % com senoides de frequencia em 2 e 3 harmonica + fundamental,
        % usando CPC (3p) e modulo 2 (pesos randomicos)
        % aqui é o sinal de entrada
        amp_square=-1*pi/180
        center_square=0;             %0.5*pi/180;
        square_period=333; %50 ou 100
        malha_str=collectChoose
        
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=amp_square/4;
        omega2=2*w;
        amp_omega2=amp_square/4;
        omega4=3*w;
        amp_omega4=amp_square/4;
        open_system('VRFT_dataCollect_IPCopenloop_sin3p')
        sim('VRFT_dataCollect_IPCopenloop_sin3p')
        
    case 'OLsin23om3_3p'
        % OLsin23o_3p = open loop, senoidal + onda quadrada,
        % com senoides de frequencia em 2 e 3 harmonica + fundamental,
        % usando CPC (3p) e modulo 3 (pesos randomicos)
        % aqui é o sinal de entrada
        amp_square=-1*pi/180
        center_square=0;             %0.5*pi/180;
        square_period=100; %50 ou 100
        malha_str=collectChoose
        
        
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=amp_square/2;
        omega2=2*w;
        amp_omega2=amp_square/2;
        omega4=3*w;
        amp_omega4=amp_square/4;
        open_system('VRFT_dataCollect_IPCopenloop_sin3p')
        sim('VRFT_dataCollect_IPCopenloop_sin3p')
        
    case 'OLsin23om3_3p_n1'
        % OLsin23o_3p = open loop, senoidal + onda quadrada,
        % com senoides de frequencia em 2 e 3 harmonica + fundamental,
        % usando CPC (3p) e modulo 3 (pesos randomicos)
        % com white noise
        amp_square=-2*pi/180
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str=collectChoose
        
        
        white_noise_scale=0.05;
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=amp_square/2;
        omega2=2*w;
        amp_omega2=amp_square/2;
        omega4=3*w;
        amp_omega4=amp_square/4;
        open_system('VRFT_dataCollect_IPCopenloop_sin3p')
        sim('VRFT_dataCollect_IPCopenloop_sin3p')
        
      case 'OLsin23om3_3p_n2'
        % OLsin23o_3p = open loop, senoidal + onda quadrada,
        % com senoides de frequencia em 2 e 3 harmonica + fundamental,
        % usando CPC (3p) e modulo 3 (pesos randomicos)
        % com white noise
        amp_square=-2*pi/180
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str=collectChoose
        
        
        white_noise_scale=0.1;
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=amp_square/2;
        omega2=2*w;
        amp_omega2=amp_square/2;
        omega4=3*w;
        amp_omega4=amp_square/2;
        open_system('VRFT_dataCollect_IPCopenloop_sin3p')
        sim('VRFT_dataCollect_IPCopenloop_sin3p')

              case 'OLsin23om3_3p_0'
        % OLsin23o_3p = open loop, senoidal + onda quadrada,
        % com senoides de frequencia em 2 e 3 harmonica + fundamental,
        % usando CPC (3p) e modulo 3 (pesos randomicos)
        % zerando com a onda quadrada
        amp_square=-2*pi/180
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str=collectChoose
        
        
        white_noise_scale=0.1;
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=amp_square/2;
        omega2=2*w;
        amp_omega2=amp_square/2;
        omega4=3*w;
        amp_omega4=amp_square/2;
        open_system('VRFT_dataCollect_IPCopenloop_sin3p0')
        sim('VRFT_dataCollect_IPCopenloop_sin3p0')
        
       case 'OLsinSmall_3p'
        % aqui é o sinal de entrada
        amp_square=-1*pi/180
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str='OLsinSmall_3p'
        
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=amp_square/2;
        omega2=2*w;
        amp_omega2=amp_square/4;
        omega4=4*w;
        amp_omega4=amp_square/8;
        open_system('VRFT_dataCollect_IPCopenloop_sin3p')
        sim('VRFT_dataCollect_IPCopenloop_sin3p')     
        
    case 'senoide2'
        % aqui é o sinal de entrada
        amp_square=-2*pi/180
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str='OLsin2'; % nome para salvar
        
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=0;
        omega2=2*w;
        amp_omega2=amp_square;
        omega4=4*w;
        amp_omega4=0;
        open_system('VRFT_dataCollect_IPCopenloop_sin')
        sim('VRFT_dataCollect_IPCopenloop_sin')
        
        
    case 'senoideCL'
        % aqui é o sinal de entrada
        amp_square=-2*pi/180
        center_square=0;             %0.5*pi/180;
        square_period=100; %50 ou 100
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=amp_square/2;
        omega2=2*w;
        amp_omega2=amp_square/4;
        omega4=4*w;
        amp_omega4=amp_square/8;
        
        % nome para salvar:
        malha_str='CLsin'
        
        load ganhoHTZG    %         load ganho5mw
        ControllerSampleTime= DTcontroller;
        open_system('VRFT_dataCollect_IPCsenoideCL')
        sim('VRFT_dataCollect_IPCsenoideCL')
        
    case 'senoideCL2'
        % aqui é o sinal de entrada
        amp_square=-2*pi/180
        center_square=0;             %0.5*pi/180;
        square_period=100; %50 ou 100
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=0;
        omega2=2*w;
        amp_omega2=amp_square;
        omega4=4*w;
        amp_omega4=0;
        % nome para salvar:
        malha_str='CLsin2'
        
        load ganhoHTZG    %         load ganho5mw
        ControllerSampleTime= DTcontroller;
        open_system('VRFT_dataCollect_IPCsenoideCL')
        sim('VRFT_dataCollect_IPCsenoideCL')
    case 'OLsin_3p_noDC'
        amp_square=0
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str='OLsin_3p_noDC'
        
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=-2*pi/180/2;
        omega2=2*w;
        amp_omega2=-2*pi/180/4;
        omega4=4*w;
        amp_omega4=-2*pi/180/8;
        open_system('VRFT_dataCollect_IPCopenloop_sin3p')
        sim('VRFT_dataCollect_IPCopenloop_sin3p')
    case 'OLsin_3p_smolDC'
        amp_square=-2*pi/180/8
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str='OLsin_3p_smolDC'
        
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=-2*pi/180/2;
        omega2=2*w;
        amp_omega2=-2*pi/180/4;
        omega4=4*w;
        amp_omega4=-2*pi/180/8;
        open_system('VRFT_dataCollect_IPCopenloop_sin3p')
        sim('VRFT_dataCollect_IPCopenloop_sin3p')
    case 'OLsin_3p_smol2DC'
        amp_square=-2*pi/180/4
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str=collectChoose
        
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=-2*pi/180/2;
        omega2=2*w;
        amp_omega2=-2*pi/180/4;
        omega4=4*w;
        amp_omega4=-2*pi/180/8;
        open_system('VRFT_dataCollect_IPCopenloop_sin3p')
        sim('VRFT_dataCollect_IPCopenloop_sin3p')
    case 'OLsin_3p_smol3DC'
        amp_square=-2*pi/180/2
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str='OLsin_3p_smol3DC'
        
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=-2*pi/180/2;
        omega2=2*w;
        amp_omega2=-2*pi/180/4;
        omega4=4*w;
        amp_omega4=-2*pi/180/8;
        open_system('VRFT_dataCollect_IPCopenloop_sin3p')
        sim('VRFT_dataCollect_IPCopenloop_sin3p')
    case 'OLsin_3p_smol2DC_1' % caso melhor, mas sem terceira harmonica
        amp_square=-2*pi/180/4
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str=collectChoose
        
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=-2*pi/180/2;
        omega2=2*w;
        amp_omega2=-2*pi/180/4;
        omega4=4*w;
        amp_omega4=0
        open_system('VRFT_dataCollect_IPCopenloop_sin3p')
        sim('VRFT_dataCollect_IPCopenloop_sin3p')
    case 'OLsin_3p_smol2DC_2' % caso melhor, mas sem segunda e terceira harmonica
        amp_square=-2*pi/180/4
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str=collectChoose
        
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=-2*pi/180/2;
        omega2=2*w;
        amp_omega2=0
        omega4=4*w;
        amp_omega4=0
        open_system('VRFT_dataCollect_IPCopenloop_sin3p')
        sim('VRFT_dataCollect_IPCopenloop_sin3p')
case 'OLsin_3p_smol2DC_maroto' % caso maroto
        amp_square=-2*pi/180/4
        center_square=0;             %0.5*pi/180;
        square_period=250; %50 ou 100
        malha_str=collectChoose
        
        DTtd=0.05;
        w=12.1*2*pi/60; %12.1 rpm em rad
        omega1=w;
        amp_omega1=-2*pi/180/2;
        omega2=2*w;
        amp_omega2=-2*pi/180/4;
        omega4=3*w;
        amp_omega4=-2*pi/180/8;
        open_system('VRFT_dataCollect_IPCopenloop_sin3p')
        sim('VRFT_dataCollect_IPCopenloop_sin3p')
end


%% Plot
% quick_plot_IPC

%% save %C:\FAST\Fast7\CertTest\VRFTdataCollect\

% monta o nome do arquivo a ser salvo
if amp_square==-2*pi/180
    amp_str='2down';
elseif amp_square==0
    amp_str='0';
else
    amp_str='man';
end

switch collectChoose
    case 'openloop'
        malha_str='OL';
        
    case 'closedloop'
        malha_str='CL';
        
end

% caso no shr
if strcmp(input_fast,'VRFT_pontops141822.fst')
    extra='noshr';
end

%%
period_str=num2str(square_period);

savefilename=strcat(malha_str,'_',amp_str,'_',period_str,'_',filterChoose,extra,'IPC');
% savefilename='CL_2down_100_IPC_tst'; %OL_100_sq_IPC

folder_savefilename=strcat('C:\FAST\CertTest\VRFTdataCollectIPC\',savefilename,'.mat')
if ~exist(strcat(savefilename,'.mat'),'file')||1
    disp(['workspace salvo em ',folder_savefilename])
    save(folder_savefilename)
else
    disp('Tentativa de salvar workspace em cima de nome já utilizado')
    disp(['NAO foi salvo em ',savefilename])
end


beep
beep
beep
% Funcao pra tratar os dados: