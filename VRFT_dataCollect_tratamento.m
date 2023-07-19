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

experimentData='08CL_100_' % VRFTdataCollect.mat
savingName=strcat('C:\FAST\CertTest\VRFTdataCollect\treated\',experimentData,'_') % 14, 18 e 22 vai ser adicionado ao fim, se nao existir
overwrite_flag=1;

figure_saveName=strcat('C:\FAST\CertTest\Figures\reuniao10_03\datacollect_auto\',experimentData);

vars_saveName={'DT','heta_out','heta_out_sOp','rotspeed_sOp','rotspeed_sOp_HTZG','rotspeed_sOp_jonk','Time','TMax','rotspeed'};

%% adição dos filtros jonk e htzg
load FilterData
filter_jonk=Filter_tf;
load FilterHTZG
filter_HTZG=Filter_tf;
%% 50-300 segundos : v=14 m/s
load(experimentData)

t_ini= 198/DT; t_fim=499/DT;

%% 
ExtractSimVarsByTime
% quick_plot
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

ExtractSimVarsByTime

% quick_plot
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

ExtractSimVarsByTime

% quick_plot
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