clear all
close all




controllers={
    'noIPC'
%     'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o15__fwdIPC'
%     'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPC'
%     'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o4__fwdIPC'
%     'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o3__fwdIPC'
%     'OLsin_3p_2down_250_shadIPC_18_RessP_TdGwd_ts1o15__fwdIPC'
%     'OLsin_3p_2down_250_shadIPC_18_RessP_TdGwd_ts1o10__fwdIPC'
%     'OLsin_3p_2down_250_shadIPC_18_RessP_TdGwd_ts1o4__fwdIPC'
%     'OLsin_3p_2down_250_shadIPC_18_RessP_TdGwd_ts1o3__fwdIPC'
    };

% controllers={
%     'OLsin_3p_smol2DC_man_250_shadIPC_14_RessP2_TdGwd_ts2o10__fwdIPC'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPC'
%     'OLsin_3p_smol2DC_man_250_shadIPC_22_RessP2_TdGwd_ts2o10__fwdIPC'
%     }
% 
% controllers={
%     'OLsin_3p_smol2DC_man_250_shadIPC_22_RessP2_TdGwd_ts2o15__fwdIPC'
%     }

% controllers={
%     'noIPC'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o30__fwdIPC'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o15__fwdIPC'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPC'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o7__fwdIPC'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o5__fwdIPC'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o3__fwdIPC'
% }

controllers = { % efeito sinal de excitação + TDR diferentes ordens
%     'noIPC'
%     'OLsin_3p_smol2DC_2_man_250_shadIPC_18_RessP_TdGwd_ts1o10__nofwdIPC'  % apenas fundamental
%     'OLsin_3p_smol2DC_1_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__nofwdIPC' % fundamental + 2
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP32_TdGwd_ts3o10__nofwdIPC'  % fundamental + 2 + 3

% % aqui é mesmo sinal de excitaçao, mas mudando apenas RESSP
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP_TdGwd_ts1o10__nofwdIPC'      %RessP
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__nofwdIPC'     %RessP2
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP32_TdGwd_ts3o10__nofwdIPC'    %RessP32
%     
%     'OLsin_3p_smol2DC_2_man_250_shadIPC_18_RessP_TdGwd_ts1o5__fwdIPC'      %RessP
%     'OLsin_3p_smol2DC_1_man_250_shadIPC_18_RessP2_TdGwd_ts2o5__nofwdIPC'     %RessP2
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP32_TdGwd_ts3o5__nofwdIPC'    %RessP32
%     
%     
%     'OLsin_3p_smol2DC_2_man_250_shadIPC_18_RessP_TdGwd_ts1o5__fwdIPC'      %RessP
%     'OLsin_3p_smol2DC_1_man_250_shadIPC_18_RessP2_TdGwd_ts2o5__fwdIPC'     %RessP2
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP32_TdGwd_ts3o5__fwdIPC'    %RessP32
    
% mesmo TD + C, diferentes sinais de excitação - esse ficou top
%     'OLsin_3p_smol2DC_1_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPC'
%     'OLsin_3p_smol2DC_2_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPC'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPC'

'OLsin_3p_smol2DC_2_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__nofwdIPC'
'OLsin_3p_smol2DC_1_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__nofwdIPC'
'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__nofwdIPC'


}




cenariosVento={
%     'steady14_Shad'
    'steady18_Shad'
%     'steady22_Shad'
    }
flag_auto=1;
for i=1:length(controllers)
    for ii=1:length(cenariosVento)
        
        VRFTControllerChoose='08CL_100__18_PI_Td2o_10_05' %'08CL_100__18_PI_Td2o_10_05'
        IPCcontroller=controllers{i}%'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o3__fwdIPC'%'OL_100_sq2_IPC_18_RessP2_TdR2o088_IPC'%OL_100_sq2_IPC_18_RessP2_TdR1k2o088_IPC'%'OL_100_sq2_IPC_18_RessP_TdR1k088_IPC'%'OL_100_sq2_IPC_18_RessP_TdR088_IPC'% 'noIPC';  %'noIPC';  %'OL_100_sq_IPC_18_RessP_Td1_IPC'; %'IPCvini'
        VRFTWindChoose=cenariosVento{ii}%'stepshr' %f1422shr
        FILTERChoose='htzg'  % htzg, jonk, ''
        extra='long'
        overwritesave_flag_autoTest=1;
        
        exe_VRFT_IPC
        
        ran_names{i+3*(ii-1)}=savefilename;
    end
end

beep
beep
beep