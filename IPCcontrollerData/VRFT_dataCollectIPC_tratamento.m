%% Funcao para separar os dados da simulaçao do exe_VRFT_dataCollect

% A simulaçao ocorre em 1050 segundos - 350 segundos em cada ponto de
% operaçao. Para evitar transientes, se coleta apenas 250 segundos (5
% periodos do pulso)
% Sao eles:
% 50-300 segundos : v=14 m/s
% 350-700 segundos : v=18 m/s
% 750-1050 segundos : v=22 m/s
clear all
close all

experimentData='OLsin_3p_smol2DC_2_man_250_shadIPC'%'OLsin23om3_3p_0_2down_250_IPC';%'OLsinSmall_3p_man_250_IPC'%'CL_2down_100_IPC_tst'%'CL_2down_100_IPC' % VRFTdataCollect.mat
savingName=strcat('C:\FAST\CertTest\VRFTdataCollectIPC\treated\',experimentData,'_') % 14, 18 e 22 vai ser adicionado ao fim, se nao existir
overwrite_flag=1;

figure_saveName=strcat('C:\FAST\CertTest\Figures\reuniao10_03\datacollect_auto\',experimentData);

vars_saveName={'DT','TipDxb1','heta_out_b1','heta_out_sOp_b1','heta_out','rotspeed_sOp','Time','TMax','rotspeed'};

%% adição dos filtros jonk e htzg
load FilterData
filter_jonk=Filter_tf;
load FilterHTZG
filter_HTZG=Filter_tf;
%% 50-300 segundos : v=14 m/s
load(experimentData)

t_ini= 198/DT; t_fim=499/DT;

%% 
ExtractSimVarsByTimeIPC
quick_plot_IPC
% saveas(gcf,strcat(figure_saveName,'14.png'))


savefilename=strcat(savingName,'14','.mat')
if ~exist(savefilename,'file')||overwrite_flag
    disp(['workspace salvo em ',savefilename])
    save(savefilename,vars_saveName{:})
    
else
    disp('Tentativa de salvar workspace em cima de nome já utilizado')
    disp(['NAO foi salvo em ',savefilename])
end

%% 370-700 segundos : v=18 m/s
load(experimentData)
t_ini= 698/DT; t_fim=999/DT;

ExtractSimVarsByTimeIPC

quick_plot_IPC
% saveas(gcf,strcat(figure_saveName,'18.png'))

savefilename=strcat(savingName,'18','.mat')
if ~exist(savefilename,'file')||overwrite_flag
    disp(['workspace salvo em ',savefilename])
    save(savefilename,vars_saveName{:})
    
else
    disp('Tentativa de salvar workspace em cima de nome já utilizado')
    disp(['NAO foi salvo em ',savefilename])
end

%% 750-1050 segundos : v=22 m/s
load(experimentData)
t_ini= 1198/DT; t_fim=1499/DT;

ExtractSimVarsByTimeIPC

quick_plot_IPC
% saveas(gcf,strcat(figure_saveName,'22.png'))

savefilename=strcat(savingName,'22','.mat')
if ~exist(savefilename,'file')||overwrite_flag
    disp(['workspace salvo em ',savefilename])
    save(savefilename,vars_saveName{:})
    
else
    disp('Tentativa de salvar workspace em cima de nome já utilizado')
    disp(['NAO foi salvo em ',savefilename])
end


overwrite_flag=0;