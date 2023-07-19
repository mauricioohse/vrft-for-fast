%% script para gerar os controladores, simular no FAST, calcular JY e salvar tudo


clear all
flag_auto=1;
tStart=tic;

arr_Ts={'16','10','8','4','3','2','1'};
% arr_Ts={'15','13'};
arr_chooseData={'005_down','005_up','01_up','01_up_22'};
% arr_chooseData={'01_up'};
flag_auto_design=1;
extra='autoJY';


for i=1:length(arr_Ts)
    for j=1:length(arr_chooseData)
        chooseTs=cell2mat(arr_Ts(i));
        chooseData=cell2mat(arr_chooseData(j));
        disp([chooseTs,chooseData]) 
        
        % constroi o controlador (e salva)
        VRFTdesign_ex3_2
%       VRFTdesign_ex3_2_PID
        % Simula controlador em ação
    	VRFTControllerChoose=strcat(saveController_namefile,'Td',chooseTs,'_',extra);
        VRFTWindChoose='gust';
        exe_VRFT_discreto
    
        saved_names(i,j)={savefilename};
        time_elapsed(i,j)=toc(tStart);
    end
end

saved_names

tFim=toc(tStart)
clear flag_auto_design
clear flag_auto

beep
beep
beep