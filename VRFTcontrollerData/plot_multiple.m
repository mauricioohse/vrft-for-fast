% plot multiple plots for comparing FAST simulations
close all
clear all
% 
% filenames={'ganho18tcc',
%      '22PI_01up_Td4_',
%      '22PI_01up_Td2_',
%      '22PI_01up_Td1_',
%     };

% filenames={'ganho18tcc',
%     '14PI_01up_Td4_',
%     '14PI_01up_Td2_',
%     '14PI_01up_Td1_',
%     };

% filenames={'ganho18tcc',
%     '02_down_14_Td4_',
%     '02_down_14_Td2_',
%     '02_down_14_Td1_',
%     };
% 
% filenames={'ganho18tcc',
%     '02_down_22_Td2o_5_2_',
%     '02_down_18_Td2o_5_2_',
% %     '02_down_14_Td2o_5_2_',
%     };

% plotmulti_filenames={
%     'ganho5mw',  % BESTS JQ
%     '02_down_18_PI_Td2o_5_3_', % menção honrosa
% % %     '02_down_22_Td2o_5_3_' % menção honrosa
%     '02_down_18_PI_Td2o_4_3_',
% % %     '02_down_22_PI_Td2o_4_3_',
% % %     '02_down_18_PID_Td2o_4_3_',
%     '02_down_18_PI_Td2o_5_4_'
%     };

% plotmulti_filenames={
%     'ganho5mw',  % BESTS JY e JQ
%     '02_down50_18_PI_Td2o_5_15_',
%     '02_down50_18_PI_Td2o_4_3_'
%     };
% 
% plotmulti_filenames={
%     'ganho5mw',  % comp diff op
%     '02_down50_18_PI_Td2o_10_05_',
%     '02_down50_22_PI_Td2o_10_05_',
%     '02_down100_14_PI_Td2o_10_05_',
%     };

% filenames={'ganho5mw', % comparação entre VRFT e padrão pra mesmos
% % % requisitos
%     '02_down_18_PI_Td2o_10_05_',
%     'ganho5mwLPV_'
%     };

% filenames={'ganho5mw', % comp td2 Mp
%     '02_down_18_PI_Td2o_5_4_',
%     '02_down_18_PI_Td2o_5_3_',
%     '02_down_18_PI_Td2o_5_2_',
%     '02_down_18_PI_Td2o_5_15_',
%     };

% filenames={'ganho5mw', % comp td2 Ts
%     '02_down_18_PI_Td2o_8_3_',
%     '02_down_18_PI_Td2o_5_3_',
%     '02_down_18_PI_Td2o_4_3_',
%     '02_down_18_PI_Td2o_3_3_'
%     };

% filenames={'ganho5mw', % comp Td primeira ordem
%      '02_down_18_PI_Td16_'
%      '02_down_18_PI_Td8_'
%      '02_down_18_PI_Td5_'
%      '02_down_18_PI_Td4_'
%      '02_down_18_PI_Td2_'
%     };

plotmulti_filenames={ % comp 01_down100seg
    'ganho5mw'
    '02_down50_18_PI_Td2o_10_05_'
    '02_down50_22_PI_Td2o_10_05_'
    '02_down50_18_PI_Td2o_8_05_'
    '02_down50_22_PI_Td2o_8_05_'
    };
% 
plotmulti_filenames={ % comp TD baseline
    'ganho5mwLPV_'
    '02_down100_14_PI_Td2o_10_05_'
    '02_down50_18_PI_Td2o_10_05_'
    '02_down50_22_PI_Td2o_10_05_'
%     '02_down50_18_PI_Td2o_3_3_'
    };

% plotmulti_filenames={ % comp Mp baseline, Ts varia
%     'ganho5mw'
%     '02_down50_18_PI_Td2o_10_05_'
%     '02_down50_18_PI_Td2o_8_05_'
%     '02_down50_18_PI_Td2o_5_05_'
%     '02_down50_18_PI_Td2o_3_05_'
%     '02_down50_18_PI_Td2o_2_05_'
%     '02_down50_18_PI_Td2o_1_05_'
%     };

% plotmulti_filenames={ % comp Ts fixo, Mp varia
%     'ganho5mwLPV_'
%     '02_down50_18_PI_Td2o_5_15_'
%     '02_down50_18_PI_Td2o_5_25_'
%     '02_down50_18_PI_Td2o_5_30_'
%     '02_down50_18_PI_Td2o_5_35_'
%     '02_down50_18_PI_Td2o_5_45_'
%     };

plotmulti_filenames={ % comp PID Ts fixo, Mp varia 
    'ganho5mw'
    '02_down50_18_PI_Td2o_5_15_'
    '02_down50_18_PI_Td2o_5_25_'
    '02_down50_18_PI_Td2o_5_30_'
    '02_down50_18_PI_Td2o_5_35_'
    '02_down50_18_PI_Td2o_5_45_'
    '02_down50_18_PID_Td2o_5_15_'
    '02_down50_18_PID_Td2o_5_25_'
    '02_down50_18_PID_Td2o_5_30_'
    '02_down50_18_PID_Td2o_5_35_'
    '02_down50_18_PID_Td2o_5_45_'
    };


plotmulti_filenames={ % comp best Td para baseline
    'ganho5mwLPV_'
%     'ganho5mw_Td2o_5_30'
%     'ganho5mw_Td2o_5_15_'
    '02_down50_18_PI_Td2o_5_30_'
    '02_down50_18_PI_Td2o_5_15_'
    '02_down100_14_PI_Td2o_5_15_'
    '02_down100_14_PI_Td2o_5_30_'
    };

plotmulti_filenames={ % comp coletadados closedLoop step 008rpm
    'ganho5mwLPV_'
    '008_up100BL_14_PI_Td2o_10_05'
    '008_up100BL_18_PI_Td2o_10_05'
    '008_up100BL_22_PI_Td2o_10_05'
%     '008_up100BL_14_PI_Td2o_10_05'
%     '008_up100BL_18_PI_Td2o_10_05'
%     '008_up100BL_22_PI_Td2o_10_05'
    };

plotmulti_filenames={ % comp coletadados closedLoop step 08rpm
%     'ganho5mwLPV_'
    '08_up100BL_14_PI_Td2o_10_05'
    '08_up100BL_18_PI_Td2o_10_05'
    '08_up100BL_22_PI_Td2o_10_05'
    '02_down100_14_PI_Td2o_10_05_'
    '02_down50_18_PI_Td2o_10_05_'
    '02_down50_22_PI_Td2o_10_05_'
    };


plotmulti_filenames={ % comp coletadados closedLoop step 08rpm
    'ganho5mwLPV_'
    '08_up100BL_14_PI_Td2o_5_15'
    '08_up100BL_18_PI_Td2o_5_15'
    '08_up100BL_22_PI_Td2o_5_15'
    '08_up100BL_14_PI_Td2o_10_05'
    '08_up100BL_18_PI_Td2o_10_05'
    '08_up100BL_22_PI_Td2o_10_05'
%     '02_down100_14_PI_Td2o_5_15_'
%     '02_down50_18_PI_Td2o_5_15_'
%     '02_down50_22_PI_Td2o_5_15_'
    };
filtername='htzg';

disp(plotmulti_filenames)
%% reference step response
Cbuff=[]; Jybuff=[]; erroSQbuff=[]; IAEjybuff=[]; dThetamaxbuff=[];
for ii=1:length(plotmulti_filenames)
    plot2_filename=strcat(cell2mat(plotmulti_filenames(ii)),'ctrl_step',filtername);
    
%     clear Jy IAE_jy
    load(plot2_filename)
    
    
    TInicial=Time(55/DT);  %Tempo inicial para plot, para cortar o transiente das cond iniciais
    TFinal=Time(90/DT);
    
    Cbuff=[Cbuff;tf(numD,denD,DT)];
%     Jybuff=[Jybuff;Jy];
%     erroSQbuff=[erroSQbuff;erroSQref];
    if exist('IAE')
    IAEjybuff(ii)=IAE;
    else
        IAEjybuff(ii)=9999;
    end
%     dThetamaxbuff(ii)=maxThetaDiff;
    add_to_plot
end
zpk(Cbuff)

%% disturbance response
clear used_filenames

JQbuff=[]; IAEjqbuff=[]; dThetamaxbuffq=[];
for ii=1:length(plotmulti_filenames)
    plot2_filename=strcat(cell2mat(plotmulti_filenames(ii)),'f1422',filtername);
%     aux_name=cell2mat(plotmulti_filenames(ii));
%     if strcmp(aux_name(1:8),'ganho5mw')
%         plot2_filename=strcat(aux_name,'LPV_f1422')
%     end
%     clear JQ IAE_jq
    load(plot2_filename)
    
    TInicial=Time(30/DT);  %Tempo inicial para plot, para cortar o transiente das cond iniciais
%     TFinal=Time(end);
    TFinal=Time(79/DT);
% if exist('JQ')
%     JQbuff=[JQbuff;JQ];
% else 
%     JQbuff=[JQbuff; 999]; 
% end
    if exist('IAE')
    IAEjqbuff(ii)=IAE;
    else
        IAEjqbuff(ii)=9999;
    end
    
%     dThetamaxbuffq(ii)=maxThetaDiff;
    
    add_to_plot_dist
end

%%
% disp('      Jy      JQ')
% disp([Jybuff,JQbuff])
% erroSQbuff
disp('      IAEjq     IAEjy')
disp([IAEjqbuff',IAEjybuff'])

%%
% legenda_override={'baselineLPV','CL_14','CL_18','CL_22','OP_14','OP_18','OP_22'};
% subplot(3,2,1)
% legend(legenda_override,'Interpreter','none')
% subplot(3,2,2)
% legend(legenda_override,'Interpreter','none')





  
  