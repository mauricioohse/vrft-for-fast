%% script para gerar os controladores, simular no FAST, calcular JY e salvar tudo


clear all
close all
flag_auto=1;
tStart=tic;


% Todos os interessantes
arr_Tsauto={'2o_10_05','2o_8_05','2o_5_05','2o_3_05','2o_1_05','2o_5_15','2o_5_30','2o_5_35','2o_5_45'};
% arr_Tsauto={'2o_10_05'};
% arr_chooseData={'02_down50_14','02_down50_18','02_down50_22','02_down100_14','02_down100_18','02_down100_22',};
% arr_chooseDataauto={'02_down100_14','02_down50_18','02_down50_22'};
arr_chooseDataauto={'02_down50_18'};
arr_chooseCspaceauto={'PI'};


% arr_VRFTWindChooseauto={'f1422'};%,'ctrl_step'};
% arr_VRFTWindChooseauto={'f1422','ctrl_step','ctrl_step_14'};
arr_VRFTWindChooseauto={'f1422'};


%smol test: 08_up100BL_22_PI_Td2o_5_15
arr_Tsauto={'2o_10_05','2o_5_15',};
arr_chooseDataauto={'08CL_100__14','08CL_100__18'};
arr_chooseCspaceauto={'PI'};
arr_VRFTWindChooseauto={'f1422'};
arr_FILTERChoose={'htzg'};
ChooseLz=''; % '_LZspec_' or ''
chooseMeasureFilter='';

overwritesave_flag_autoTest=1;
overwritesave_flag_controllerDesign=1;

flag_auto_design=1;
extra='';

buff_IAE=[]; saved_names={}; buff_MaxTheta=[];
for i=1:length(arr_Tsauto)
    for j=1:length(arr_chooseDataauto)
        for k=1:length(arr_chooseCspaceauto)
            for kk=1:length(arr_VRFTWindChooseauto)
                for jj=1:length(arr_FILTERChoose)
                    chooseTs=cell2mat(arr_Tsauto(i));
                    chooseData=cell2mat(arr_chooseDataauto(j));
                    chooseCspace=cell2mat(arr_chooseCspaceauto(k));
                    disp([chooseTs,' ',chooseData])
                    
                    % constroi o controlador (e salva)
                    VRFTdesign_ex3_2
                    %                 zpk(C)
                    % Simula controlador em ação
                    VRFTControllerChoose=strcat(saveController_namefile,chooseCspace,'_','Td',chooseTs,ChooseLz);
                    VRFTWindChoose=cell2mat(arr_VRFTWindChooseauto(kk));
                    FILTERChoose=cell2mat(arr_FILTERChoose(jj));
                    
                    exe_VRFT_discreto
                    
                    saved_names{i,j,k,kk}=savefilename;
                    buff_IAE(i,j,k,kk)=IAE;
                    buff_MaxTheta(i,k,k,kk,jj)=maxThetaDiff;
                end
            end
        end
    end
end



%%
% disp(saved_names')
% disp(saved_names)
buff_IAE


%%
tFim=toc(tStart)
clear flag_auto_design overwritesave_flag_autoTest  flag_auto

%% save autorun

name__='run_BLhtzg';
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

if 1
   for i=1:length(saved_names)
       load(cell2mat(saved_names(i)))
       quick_plot
   end
end


beep
beep
beep