%% script para gerar os controladores diretamente a partir dos Ts

clear all


arr_Ts={'16','10','8','4','3','2','1'};
arr_chooseData={'005_down','005_up'};
flag_auto_design=1;

for i=1:length(arr_Ts)
    for j=1:length(arr_chooseData)
        chooseTs=cell2mat(arr_Ts(i));
        chooseData=cell2mat(arr_chooseData(j));
        disp([chooseTs,chooseData]) 
        VRFTdesign_ex3_2
        VRFTdesign_ex3_2_PID
    end
end




clear flag_auto_design