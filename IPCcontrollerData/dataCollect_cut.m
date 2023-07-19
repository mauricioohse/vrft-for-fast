% Script para corte individual (versão especifica do
% VRFT_dataCollectIPC_tratamento
clear all
close all

experimentData='CLsin_2down_250_IPC'%'CL_2down_100_IPC_tst'%'CL_2down_100_IPC' % VRFTdataCollect.mat
savingName=strcat('C:\FAST\CertTest\VRFTdataCollectIPC\treated\',experimentData,'_')
overwrite_flag=0;

load(experimentData)
t_ini= 750/DT; t_fim=875/DT;

ExtractSimVarsByTimeIPC

%% save

vars_saveName={'DT','TipDxb1','heta_out_b1','heta_out_sOp_b1','heta_out','rotspeed_sOp','Time','TMax','rotspeed'};

savefilename=strcat(savingName,'18_cut','.mat')
if ~exist(savefilename,'file')%||1
    disp(['workspace salvo em ',savefilename])
    save(savefilename,vars_saveName{:})
    
else
    disp('Tentativa de salvar workspace em cima de nome já utilizado')
    disp(['NAO foi salvo em ',savefilename])
end

quick_plot_IPC
plot_spec