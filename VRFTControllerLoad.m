%% Script to load previously obtained controller values

% Choose which controller version is being used by the variable:
% VRFTControllerChoose= ['14', '18', '22']

% The controller values where obtained by VRFTload.m routine.


if ~exist('VRFTControllerChoose')
    VRFTControllerChoose='18'
    disp('Warning: no VRFTControllerData selected. Default 18 pontop selected')
    pause(1)
end


%% VRFT controller values found:
        
        Kp14=0.0401;
        Ki14=0.0401;
        Kp18=0.07115; % obtained with VRFTdataFew2_18 on ex3_1
        Ki18=0.0672;
        Kp22=0.07553;
        Ki22=0.096;

switch VRFTControllerChoose
    case '14'
        disp('pontop 14 choosen')
        Kp=Kp14;
        Ki=Ki14;
    case '18'
        disp('pontop 18 choosen')
        Kp=Kp18;
        Ki=Ki18;

    case '22'
        disp('pontop 22 choosen')
        Kp=Kp22;
        Ki=Ki22;
    case '18_ex3_1'
        Kp=0.004989; % obtained with VRFTdataFew2_18 on ex3_1 RETIRANDO PONTOP
        Ki=0.01945;
    case '18tcc'
         Ki=0.06;  % ganho LGR lin18
         Kp=Ki*1;
    case '18_ex3_2'
         Kp=0.02874;
         Ki=0.009917;
    case '18PID_ex3_1'
        num = [0.00345 0.8014 0.1991]; % VRFTdesign_ex3_1_PID retirando pontop
        den=[1 40 0];
%         num=[0.049 2.712 2.845]; % sem tirar pontop
%         den=[1 40 0];
    case '18PIDd_ex3_1' % discreto
% ATENÇAO: AQUI NAO TEM SINAL NEGATIVO NA ENTRADA DO CONTROLADOR NO
% SIMULINK PQ USA DIRETO DO VRFT
        numD=[ -0.0118    0.0033    0.0082];
        denD=[1    -1     0];
    case '18PId_ex3_1' % retirando pontop
        numD=[ -0.01968 0.01936];
        denD=[1    -1];
     case '18PId_ex3_1_t' % SEM RETIRAR PONTOP
        numD=[ -0.06737   0.06427];
        denD=[ 1 -1 ];
    case '18PId_.5_cOp' % data collect .5 centro 0 PI 18  'C:\FAST\Fast7\CertTest\VRFTdata\VRFTdatacollect_up_treated18'
        numD=[ -0.2645 0.2617];
        denD=[ 1 -1 ];
    case '22PI_-05_cOp' % com op 'C:\FAST\Fast7\CertTest\VRFTdata\VRFTdatacollect_down_treated_2_22'
        numD=[ -0.1165  0.1123];
        denD=[ 1 -1 ];
    case '22PID_-05_cOp'  % com op 'C:\FAST\Fast7\CertTest\VRFTdata\VRFTdatacollect_down_treated_2_22'
        numD=-[ -0.2965  0.4739 0.1817];
        denD=[ 1 -1 0];
    case '18PID_-05_cOp'  % com op 'C:\FAST\Fast7\CertTest\VRFTdata\VRFTdatacollect_down_treated_2_22'
        numD=[-0.07647 0.05574 0.01757];
        denD=[ 1 -1 0];
    case '18PI_-05_cOp_TdFast' % com op, Td super fast 'C:\FAST\Fast7\CertTest\VRFTdata\VRFTdatacollect_down_treated_2_18'
        numD=[-0.06138 0.09748];
        denD=[ 1 -1];
    case '18PI_-05_cOp_TdFast2' % polo .975 'C:\FAST\Fast7\CertTest\VRFTdata\VRFTdatacollect_down_treated_2_18')
        numD=[-0.03069 0.04874];
        denD=[ 1 -1];
    case '18PI_-05_sOp_TdFast3' % polo .98 'C:\FAST\Fast7\CertTest\VRFTdata\VRFTdatacollect_down_treated_2_18')
        numD=[-0.03205 0.03164];
        denD=[ 1 -1];
    case '18PI_-05_cOp_TdFast3' % polo .98 'C:\FAST\Fast7\CertTest\VRFTdata\VRFTdatacollect_down_treated_2_18')
        numD=[-0.02455  0.03899];
        denD=[ 1 -1];
    case '18PI_-05_sOp_Td1' % polo 0.9876 'C:\FAST\Fast7\CertTest\VRFTdata\VRFTdatacollect_down_treated_2_18')
        numD=[-0.01974  0.01948];
        denD=[ 1 -1];
    case '18PID_-05_sOp_Td3' % polo 0.98 'C:\FAST\Fast7\CertTest\VRFTdata\VRFTdatacollect_down_treated_2_18')
        numD=[-0.02021  0.007278  0.01252];
        denD=[ 1 -1 0];
    case '18PI_L_-05_sOp_TdFast3' % polo .98 ex3.2 'C:\FAST\Fast7\CertTest\VRFTdata\VRFTdatacollect_down_treated_2_18')
        numD=[-0.0357 0.03531];
        denD=[ 1 -1];
    case '18PI_L_-05_cOp_TdFast3' % polo .98 ex3.2 'C:\FAST\Fast7\CertTest\VRFTdata\VRFTdatacollect_down_treated_2_18')
        numD=[-0.03613 0.03573];
        denD=[ 1 -1];
    case '18PI_-05_cOp_TdFast3' % polo .98 ex3.2 'C:\FAST\Fast7\CertTest\VRFTdata\VRFTdatacollect_down_treated_2_18')
        numD=[-0.02455 0.03899];
        denD=[ 1 -1];
    otherwise
        disp('no valid controller OP choosen')
end


