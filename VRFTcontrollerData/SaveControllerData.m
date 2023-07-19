% Save controller data
%inputs: saveFolder,saveController_namefile,chooseTd,chooseCspace,extra

if ~exist('overwritesave_flag_controllerDesign')
    overwritesave_flag_controllerDesign=0;
end


controller_savefilename=strcat(saveController_namefile,chooseCspace,'_','Td',chooseTs,ChooseLz,'_',ChooseForward,extra,'.mat');
folder_savefilename=strcat(saveFolder,controller_savefilename);
if ~exist(controller_savefilename,'file')||overwritesave_flag_controllerDesign
    disp(['workspace salvo em ',folder_savefilename])
    aux_overwritesave_flag_controllerDesign=overwritesave_flag_controllerDesign;
    save(folder_savefilename,'C','numD','denD','Td','DTcontroller','p','Lz')
    overwritesave_flag_controllerDesign=aux_overwritesave_flag_controllerDesign;
else 
    disp('Tentativa de salvar workspace em cima de nome já utilizado')
    disp(['NAO foi salvo em ',controller_savefilename])
end