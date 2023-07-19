% Executa uma simulaçao genérica do FAST para obter dados para posterior
% VRFT
clear all
close all

%% Troca o Path do MATLAB
cd C:\FAST\CertTest

%% escolhe a config do controlador (openloop ou closedloop)

collectChoose='closedloop';
filterChoose='htzg'; % '', jonk, htzg
extra='';

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
input_fast='VRFT_pontops141822.fst' % perfil de vento com steps em 14, 18 e 22 ms
% 50 segundos de inicializaçao, 200 segundos para cada perfil de vento
Read_FAST_Input


%% Dados amplitude da onda quadrada e centralizacao:

% % % o vento muda em:
% % % 14: 0
% % % 18: 500
% % % 22: 1000 (até 1500)

%% Abre e executa o simulink

switch collectChoose
    case 'openloop'
        % aqui é o sinal de entrada 
        amp_square=0%-0.2*pi/180;        %1*pi/180;
center_square=0;             %0.5*pi/180;
square_period=100; %50 ou 100
        open_system('VRFT_dataCollect_slx_d')
        sim('VRFT_dataCollect_slx_d')
        
    case 'closedloop'
        % aqui é sinal de referencia
        amp_square=0.8;        %1*pi/180;
center_square=0;             %0.5*pi/180;
square_period=100; %50 ou 100
% TMax=400;
        load ganho5mw
        ControllerSampleTime= DTcontroller;
%         angleOpPoint=8.672*pi/180; % 14 m/s % tem seletor de angleoppoint
        open_system('VRFT_dataCollect_Baseline')
        sim('VRFT_dataCollect_Baseline')
end

  
%% Plot
plot_geral


%% save %C:\FAST\Fast7\CertTest\VRFTdataCollect\

% monta o nome do arquivo a ser salvo
if amp_square==0.8
    ampname='08CL';
elseif amp_square==0.08
    ampname='008CL';
else
    % manual
    ampname='manual';
end
periodname=num2str(square_period);

savefilename=strcat(ampname,'_',periodname,'_',filterChoose,extra);
% savefilename='08rpm_up100CL_jonk';

folder_savefilename=strcat('C:\FAST\CertTest\VRFTdataCollect\',savefilename,'.mat')
if ~exist(strcat(savefilename,'.mat'),'file')%||1
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