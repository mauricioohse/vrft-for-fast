%% script para gerar os controladores, simular no FAST, calcular JY e salvar tudo


clear all
close all
flag_auto=1;
tStart=tic;


arr_Tsauto={'2o_10_05','2o_5_15'};
arr_chooseDataauto={'ganhoHTZG'};


FILTERChoose='htzg'
arr_VRFTWindChooseauto={'f1422','ctrl_step'};%,'ctrl_step'};
% arr_VRFTWindChooseauto={'f1422','ctrl_step','ctrl_step_14','ctrl_step_22'};


%smol test:
% arr_Ts={'2o_4_3','2o_5_2'};
% arr_chooseData={'02_down50_18','02_down100_14'};
% arr_chooseCspace={'PI'};
% arr_VRFTWindChoose={'f1625','ctrl_step_14','ctrl_step_22'};



overwritesave_flag_autoTest=1;

flag_auto_design=1;
extra='';

saved_names={}; buff_C=[]; buff_JQ=[]; buff_IAEjq=[]; buff_IAEjq=[]; buff_JY=[]; buff_IAEjy=[]; buff_IAE=[];
for i=1:length(arr_Tsauto)
    for j=1:length(arr_chooseDataauto)
        for kk=1:length(arr_VRFTWindChooseauto)
            chooseTs=cell2mat(arr_Tsauto(i));
            chooseData=cell2mat(arr_chooseDataauto(j));
            disp([chooseTs,' ',chooseData])
            

            
            %       VRFTdesign_ex3_2_PID
            % Simula controlador em ação
            VRFTControllerChoose=strcat(chooseData,'_','Td',chooseTs);
            VRFTWindChoose=cell2mat(arr_VRFTWindChooseauto(kk));
            exe_VRFT_discreto
            
            %                 VRFTControllerChoose=strcat(saveController_namefile,chooseCspace,'_','Td',chooseTs,'_',extra);
            %                 VRFTWindChoose=VRFTWindChoose2;
            %                 exe_VRFT_discreto
            
            %                 autotest_buffSave
            %                 time_elapsed(i,j)=toc(tStart);
        end
    end
end



%%
disp(saved_names')
disp(saved_names)
% buff_JQ
% buff_JY

% [minJQ,index_minJQ]=min(buff_JQ)
% [minJY,index_minJY]=min(buff_JY)

% buff_IAEjq
% buff_IAEjy

% [minIAEjq,index_minIAEjq]=min(buff_IAEjq)
% [minIAEjy,index_minIAEjy]=min(buff_IAEjy)


%%
tFim=toc(tStart)
clear flag_auto_design overwritesave_flag_autoTest  flag_auto

%% save autorun

name__='run_all4';
overwriterunsavefile=0;

batchrun_filename=strcat('C:\FAST\CertTest\VRFTbatchrun\',name__,'.mat');
if ~exist(batchrun_filename,'file')||overwriterunsavefile
    clear overwriterunsavefile
    disp(['workspace salvo em ',batchrun_filename])
    save(batchrun_filename)
else 
    disp('Tentativa de salvar workspace em cima de nome já utilizado')
    disp(['NAO foi salvo em ',batchrun_filename])
end




%% Display relevant vars




beep
beep
beep