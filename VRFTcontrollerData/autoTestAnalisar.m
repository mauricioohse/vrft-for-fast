%% Script para analisar o IAE de varios testes simultaneos
clear all
close all


% arr_Ts={'2o_10_05','2o_8_05','2o_5_05','2o_4_05','2o_3_05','2o_2_05'}
% arr_chooseData={'02_down50_18','02_down50_22','02_down100_14'}
% % arr_Ts={'2o_10_05','2o_8_05'}
% % arr_chooseData={'02_down50_18','02_down50_22'}
% arr_chooseCspace={'PI'};



% all run
% arr_Ts_={'2o_10_05','2o_8_05','2o_5_05','2o_4_05','2o_3_05','2o_2_05','2o_5_05','2o_5_15','2o_5_25','2o_5_30','2o_5_35','2o_5_45','2o_4_3','2o_3_3'};
% arr_chooseData_={'02_down50_18','02_down50_22','02_down100_14'};
% arr_chooseCspace_={'PI'};
% arr_VRFTWindChooseanalise_={'f1625','ctrl_step','ctrl_step_14','ctrl_step_22'};

% baseline
% arr_Ts_={'2o_10_05'};
% arr_chooseData_={'02_down100_14','02_down50_18','02_down50_22'}%,'02_down50_22','02_down100_14'};
% arr_chooseCspace_={'PI'};
% arr_VRFTWindChooseanalise_={'f1422'};

% best over all pontops -
% arr_Ts_={'2o_10_05','2o_8_05','2o_5_05','2o_3_05','2o_1_05','2o_5_15','2o_5_30','2o_5_35','2o_5_45'};
% arr_chooseData_={'02_down50_18'}%,'02_down50_22','02_down100_14'};
% arr_chooseCspace_={'PI'};
% arr_VRFTWindChooseanalise_={'f1422','ctrl_step'};

% % baseline
arr_Ts_={'2o_10_05'};
arr_chooseData_={'02_down100_14','02_down50_18','02_down50_22'};
arr_chooseCspace_={'PI'};
arr_VRFTWindChooseanalise_={'f1422','ctrl_step_14','ctrl_step','ctrl_step_22'};



%smol test:
% arr_Ts={'2o_4_3','2o_5_2'};
% arr_chooseData={'02_down50_18','02_down100_14'};
% arr_chooseCspace={'PI'};
% arr_VRFTWindChoose={'f1625','ctrl_step_14','ctrl_step_22'};

arr_Tsauto={'2o_10_05','2o_5_15',};
arr_chooseData={'008_up100BL_14','008_up100BL_18','008_up100BL_22'};
arr_chooseCspace={'PI'};
arr_VRFTWindChooseanalise_={'f1422','ctrl_step'};



overwritesave_flag_autoTest=1;

flag_auto_design=1;

loadNameList={};
loadNameList1={};
loadNameList2={};


for j=1:length(arr_chooseData_)

        for i=1:length(arr_Ts_)
    for k=1:length(arr_chooseCspace_)
            
            chooseTs=cell2mat(arr_Ts_(i));
            chooseData=cell2mat(arr_chooseData_(j));
            chooseCspace=cell2mat(arr_chooseCspace_(k));
            
            instancename=strcat(chooseData,'_',chooseCspace,'_Td',chooseTs);
            loadNameList{end+1}=instancename;
            %             loadNameList1{end+1}=strcat(instancename,'_',VRFTWindChoose1);
            %             loadNameList2{end+1}=strcat(instancename,'_',VRFTWindChoose2);
            
        end
    end
end

% loadNameList{1}=[];

loadNameList1'



%% analise dos dados
completeLoadNameList_={};
buff_IAEanalise_=zeros(length(loadNameList),length(arr_VRFTWindChooseanalise_));
for iii=1:length(arr_VRFTWindChooseanalise_)
    for i_aux=1:length(loadNameList)
        
        nomebase_=cell2mat(loadNameList(i_aux));
        windchooseinstance_=cell2mat(arr_VRFTWindChooseanalise_(iii));
        completeLoadNameList_{end+1}=strcat(nomebase_,'_',windchooseinstance_);
        load(strcat(nomebase_,'_',windchooseinstance_))
        buff_C_(i_aux)=tf(numD,denD,DT);
        buff_IAEanalise_(i_aux,iii)=IAE;
        
        
    end
end

%% criterio de seleção (Teste)

% for i=1:size(buff_IAEanalise_,1)
%     buff_IAEanalise_(i,5)= buff_IAEanalise_(i,1)/1018 +buff_IAEanalise_(i,2)/9.5342+buff_IAEanalise_(i,3)/6.1957+buff_IAEanalise_(i,4)/5.9729;
% end
%%


[buff_IAEsorted_,idxjy_]= sort(buff_IAEanalise_);

zpk(buff_C_)
loadNameList'
(arr_VRFTWindChooseanalise_)
buff_IAEanalise_'
% buff_IAEsorted_
% idxjy_
%%
% disp([cell2mat(loadNameList1(idxjy))',buff_IAEjyaux1',cell2mat(loadNameList2(idxjy))',buff_IAEjqaux1'])


if 1
   for i=4:6%1:length(completeLoadNameList_)
       load(cell2mat(completeLoadNameList_(i)))
       quick_plot
   end
end


















