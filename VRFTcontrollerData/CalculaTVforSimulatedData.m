clear all


filenames_f1422={
    'ganho5mw_Td2o_10_05LPV_f1422'
    'ganho5mw_Td2o_5_15LPV_f1422'
    'ganho5mw_Td2o_5_30LPV_f1422'
    '02_down50_18_PI_Td2o_10_05_f1422'
    '02_down50_18_PI_Td2o_8_05_f1422'
    '02_down50_18_PI_Td2o_5_05_f1422'
    '02_down50_18_PI_Td2o_3_05_f1422'
    '02_down50_18_PI_Td2o_1_05_f1422'
    '02_down50_18_PI_Td2o_5_15_f1422'
    '02_down50_18_PI_Td2o_5_30_f1422'
    '02_down50_18_PI_Td2o_5_35_f1422'
    '02_down50_18_PI_Td2o_5_45_f1422'
    };


filenames_ctrlstep={
    'ganho5mw_Td2o_10_05LPV_ctrl_step'
    'ganho5mw_Td2o_5_15LPV_ctrl_step'
    'ganho5mw_Td2o_5_30LPV_ctrl_step'
    '02_down50_18_PI_Td2o_10_05_ctrl_step'
    '02_down50_18_PI_Td2o_8_05_ctrl_step'
    '02_down50_18_PI_Td2o_5_05_ctrl_step'
    '02_down50_18_PI_Td2o_3_05_ctrl_step'
    '02_down50_18_PI_Td2o_1_05_ctrl_step'
    '02_down50_18_PI_Td2o_5_15_ctrl_step'
    '02_down50_18_PI_Td2o_5_30_ctrl_step'
    '02_down50_18_PI_Td2o_5_35_ctrl_step'
    '02_down50_18_PI_Td2o_5_45_ctrl_step'
    };

timeUntilFailureDataTable{4,4}=0;
TV_buff_ctrlstep=[];
TV_buff_f1422=[];  IAEd_buff=[]; IAE18_buff=[]; buff_TUF=[]; buff_DEL=[];
for i=1:length(filenames_f1422)
    %sadly i didnt put step_ctrl_time on the data, but it is =30 in both
    %cases
    step_ctrl_time=30;
    load(filenames_f1422{i})
    CalculaTV
    TV_buff_f1422(i)=TV;
    IAEd_buff(i)=IAE;
    buff_TUF(i)=timeUntilFailureDataTable{4,4};
    
    % for  control step
    load(filenames_ctrlstep{i})
    CalculaTV
    TV_buff_ctrlstep(i)=TV; %unused
    IAE18_buff(i)=IAE;
    
end

disp(filenames_f1422)
disp('IAE_18     ISTC')
disp([ IAE18_buff' TV_buff_f1422'])
IAEd_buff=IAEd_buff'



