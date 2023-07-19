% This script shall rerun all CPC tests and saves MLIFE vars for it
clear all
close all

% filenames_f1422={
%     'ganho5mw_Td2o_10_05LPV_f1422'
%     'ganho5mw_Td2o_5_15LPV_f1422'
%     'ganho5mw_Td2o_5_30LPV_f1422'
%     '02_down50_18_PI_Td2o_10_05_f1422'
%     '02_down50_18_PI_Td2o_8_05_f1422'
%     '02_down50_18_PI_Td2o_5_05_f1422'
%     '02_down50_18_PI_Td2o_3_05_f1422'
%     '02_down50_18_PI_Td2o_1_05_f1422'
%     '02_down50_18_PI_Td2o_5_15_f1422'
%     '02_down50_18_PI_Td2o_5_30_f1422'
%     '02_down50_18_PI_Td2o_5_35_f1422'
%     '02_down50_18_PI_Td2o_5_45_f1422'
%     };

% for generated controllers:
controllers_filenames={
    'ganho5mw_Td2o_10_05'
    'ganho5mw_Td2o_5_15'
    'ganho5mw_Td2o_5_30'
%     '02_down50_18_PI_Td2o_10_05_'
%     '02_down50_18_PI_Td2o_8_05_'
%     '02_down50_18_PI_Td2o_5_05_'
%     '02_down50_18_PI_Td2o_3_05_'
%     '02_down50_18_PI_Td2o_1_05_'
%     '02_down50_18_PI_Td2o_5_15_'
%     '02_down50_18_PI_Td2o_5_30_'
%     '02_down50_18_PI_Td2o_5_35_'
%     '02_down50_18_PI_Td2o_5_45_'
};





for i=1:length(controllers_filenames)
% input for simulation
    flag_auto=1;
    VRFTControllerChoose=controllers_filenames{i};%'ganhoHTZG'%'OLsin_2down_250_IPC_18_PI_Td2o_10_05';%'08CL_100__18_PI_Td2o_10_05' %08CL_100__14_PI_Td2o_5_15
    VRFTWindChoose='f1422';
    FILTERChoose='htzg'
    extra='auto';
    overwritesave_flag_autoTest=1;
    
    exe_VRFT_discreto
    
    saved_names{i}=savefilename;
end
    
    
    
    
    
    
    
    
    
    
    clear flag_auto