% Codigo para rerodar os ensaios a disturbio de vento do CPC testando
% pontop
% 
%    'ganho5mwLPV_f1422'           
%    '02_down100_14_PI_Td2o_10_05_f1422'      
%    '02_down50_18_PI_Td2o_10_05_f1422'       
%    '02_down50_22_PI_Td2o_10_05_f1422'
% resolvi rerodar na mao lul




% Mas os controladores da tabela variando requisito vou rodar
% automaticamente

listacontroladores={
    'ganho5mw' %Esse farei manualmente
    'ganho5mw_Td2o_5_15'
    'ganho5mw_Td2o_5_30'
    '02_down50_18_PI_Td2o_10_05_'
    '02_down50_18_PI_Td2o_8_05_'
    '02_down50_18_PI_Td2o_5_05_'
    '02_down50_18_PI_Td2o_3_05_'
    '02_down50_18_PI_Td2o_1_05_'
    '02_down50_18_PI_Td2o_5_15_'
    '02_down50_18_PI_Td2o_5_30_'
    '02_down50_18_PI_Td2o_5_35_'
    '02_down50_18_PI_Td2o_5_45_'
    };

flag_auto=1
for i=1:length(listacontroladores)
    
    VRFTControllerChoose=listacontroladores{i};
    VRFTWindChoose='f1422';% 'stepshr' %f1422
    FILTERChoose='htzg'  % htzg, jonk, ''
    extra='auto3';
    overwritesave_flag_autoTest=1;
    exe_VRFT_discreto
    clear timeUntilFailureDataTable
    ran_names{i}=savefilename;
end
for i=1:length(listacontroladores)
    
    VRFTControllerChoose=listacontroladores{i};
    VRFTWindChoose='ctrl_step';% 'stepshr' %f1422
    FILTERChoose='htzg'  % htzg, jonk, ''
    extra='auto3';
    overwritesave_flag_autoTest=1;
    exe_VRFT_discreto
    clear timeUntilFailureDataTable
    ran_names_ctrlstep{i}=savefilename;
end

beep
beep
beep
clear flag_auto