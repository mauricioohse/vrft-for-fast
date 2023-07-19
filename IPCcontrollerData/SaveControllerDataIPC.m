% Save controller data
%inputs: saveFolder,saveController_namefile,chooseTd,chooseCspace,extra

if ~exist('overwritesave_flag_controllerDesign')
    overwritesave_flag_controllerDesign=0;
end

% Renomeia com _IPC
C_IPC=C;
numD_IPC=numD;
denD_IPC=denD;
Td_IPC=Td;
p_IPC=p;
Lz_IPC=Lz;

Td_IPC_p_char=pop_symbol(num2str(p_Td_IPC),'.');


controller_savefilename=strcat(saveController_namefile,chooseCspace_IPC,'_',choose_Td_IPC,Td_IPC_p_char,'_',ChooseLz,'_',ChooseForwardIPC,extra,'.mat');
folder_savefilename=strcat(saveFolder,controller_savefilename);
if ~exist(controller_savefilename,'file')||overwritesave_flag_controllerDesign
    disp(['workspace salvo com ',controller_savefilename])
    aux_overwritesave_flag_controllerDesign=overwritesave_flag_controllerDesign;
    save(folder_savefilename,'C_IPC','numD_IPC','denD_IPC','Td_IPC','DTcontroller','p_IPC','Lz_IPC')
    overwritesave_flag_controllerDesign=aux_overwritesave_flag_controllerDesign;
else 
    disp('Tentativa de salvar workspace em cima de nome já utilizado')
    disp(['NAO foi salvo com ',controller_savefilename])
end