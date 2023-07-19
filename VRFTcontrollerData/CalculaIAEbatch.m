clear all


% Todos os interessantes
arr_Tsauto={'2o_10_05','2o_8_05','2o_5_05','2o_3_05','2o_1_05','2o_5_15','2o_5_30','2o_5_35','2o_5_45'};
arr_chooseDataauto={'02_down50_18'};
arr_chooseCspaceauto={'PI'};
arr_VRFTWindChooseauto={'f1422'};

% arr_Tsauto={'2o_10_05'};
% arr_chooseData={'02_down50_14','02_down50_18','02_down50_22','02_down100_14','02_down100_18','02_down100_22',};
% arr_chooseDataauto={'02_down100_14','02_down50_18','02_down50_22'};
% arr_chooseCspaceauto={'PI'};
% arr_VRFTWindChooseauto={'ctrl_step_14','ctrl_step','ctrl_step_22'};

IAE_buff=[]; saved_names={};  maxThetaDiff_buff=[];
for i=1:length(arr_Tsauto)
    for j=1:length(arr_chooseDataauto)
        for k=1:length(arr_chooseCspaceauto)
            for kk=1:length(arr_VRFTWindChooseauto)
                chooseTs=cell2mat(arr_Tsauto(i));
                chooseData=cell2mat(arr_chooseDataauto(j));
                chooseCspace=cell2mat(arr_chooseCspaceauto(k));
                chooseWind=cell2mat(arr_VRFTWindChooseauto(kk));
%                 disp([chooseTs,' ',chooseData]);
                
                loadnamefile=strcat(chooseData,'_',chooseCspace,'_Td',chooseTs,'_',chooseWind);
                
                load(loadnamefile)
                
                if strcmp(chooseWind,'f1422')
                    clear step_ref
                end
                
                CalculaIAE
                IAE_buff(i,j,k,kk)=IAE;
                maxThetaDiff_buff(i,j,k,kk)=maxThetaDiff;
                saved_names{end+1}=loadnamefile;
                
                
            end
        end
    end
end

saved_names'
maxThetaDiff_buff