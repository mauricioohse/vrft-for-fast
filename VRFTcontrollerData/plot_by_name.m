%%
clear all
close all


filenames_base={ % comp coletadados closedLoop step 08rpm plot_by_name_IPC
    'ganho5mwLPV_'
    'ganhoHTZGLPV_'
    '008_up100BL_14_PI_Td2o_5_15'
    '08_up100BL_18_PI_Td2o_5_15'
    '08_up100BL_22_PI_Td2o_5_15'
%     '08_up100BL_14_PI_Td2o_10_05'
%     '08_up100BL_18_PI_Td2o_10_05'
%     '08_up100BL_22_PI_Td2o_10_05'
    };




%% Se quiser adicionar coisas no final
add1='ctrl_step';
add2='htzg';
filenames={};
for i=1:length(filenames_base)
    current_name=strcat(cell2mat(filenames_base(i)),add1,add2);
    filenames{i}=current_name;
end

%% othewise usar aqui

filenames={ % comp entre filtros no ensaio de step 0.5rpm
    'ganhoHTZGLPV_ctrl_step'
    'ganhoHTZGLPV_ctrl_stepjonk'
    'ganhoHTZGLPV_ctrl_stephtzg'
    };

filenames={ % comp entre filtros no ensaio de step 0.08rpm
    'ganhoHTZGLPV_ctrl_step18_008_'
    'ganhoHTZGLPV_ctrl_step18_008_jonk'
    'ganhoHTZGLPV_ctrl_step18_008_htzg'
    };

filenames={ % comp entre filtros no ensaio de disturbio
    'ganhoHTZGhtzg_f1422'
    'ganhoHTZGhtzg_f1422jonk'
    'ganhoHTZGhtzg_f1422htzg'
    };

filenames={ % comp entre filtros no ensaio de disturbio
    '08_up100BL_18_PI_Td2o_10_05f1422jonk'
    '08_up100BL_18_PI_Td2o_5_15f1422jonk'
    'ganhoHTZGhtzg_f1422jonk'
    };


filenames={ % comp entre filtros no ensaio de disturbio
    '08_up100BL_18_PI_Td2o_5_15f1422'
    '08_up100BL_18_PI_Td2o_5_15f1422jonk'
    '08_up100BL_18_PI_Td2o_5_15f1422htzg'
    };

filenames={ % comp entre filtros no ensaio de ctrl_step
    '08_up100BL_18_PI_Td2o_5_15ctrl_step'
    '08_up100BL_18_PI_Td2o_5_15ctrl_stepjonk'
    '08_up100BL_18_PI_Td2o_5_15ctrl_stephtzg'
    };

filenames={ % comp entre Lz e Lzmod
    '08_up100BL_14_PI_Td2o_5_15specf1422jonk'
    '08_up100BL_14_PI_Td2o_5_15f1422jonk'
    };

filenames={ % comp entre Lz e Lzmod
    '08_up100BL_14_PI_Td2o_5_15specctrl_stepjonk'
    '08_up100BL_14_PI_Td2o_5_15ctrl_stepjonk'
    };

filenames={ % comp entre Lz e Lzmod
    '08_up100BL_18_PI_Td2o_5_15specctrl_stepjonk'
    '08_up100BL_18_PI_Td2o_5_15ctrl_stepjonk'
    };

% filenames={ % comp entre Lz e Lzmod
%     '08_up100BL_18_PI_Td2o_5_15specf1422jonk'
%     '08_up100BL_18_PI_Td2o_5_15f1422jonk'
%     };


% filenames={ % comp entre filtros no ensaio de step 0.08rpm
%     'ganhoHTZGLPV_ctrl_step18_008_'
%     'ganhoHTZGLPV_ctrl_step18_008_jonk'
%     'ganhoHTZGLPV_ctrl_step18_008_htzg'
%     };

filenames={ % comp com LZspec (phi_r= z/z-1
    '08_up100BL_14_PI_Td2o_10_05_LZspec_f1422htzg'
    '08_up100BL_14_PI_Td2o_10_05f1422htzg'
    };

filenames={ % comp com LZspec (phi_r= z/z-1
    '08_up100BL_14_PI_Td2o_10_05_LZspec_ctrl_stephtzg'
    '08_up100BL_14_PI_Td2o_10_05ctrl_stephtzg'
    };

filenames={ % comp com LZspec (phi_r= z/z-1
    '08_up100BL_18_PI_Td2o_10_05_LZspec_ctrl_stephtzg'
    '08_up100BL_18_PI_Td2o_10_05ctrl_stephtzg'
    };


filenames={ % comp com LZspec (phi_r= z/z-1
    '08_up100BL_18_PI_Td2o_10_05_LZspec_f1422htzg'
    '08_up100BL_18_PI_Td2o_10_05f1422htzg'
    };


filenames={ % comp com LZspec (phi_r= z/z-1
    '08_up100BL_18_PI_Td2o_10_05_LZspec_f1422htzg'
    '08_up100BL_18_PI_Td2o_10_05f1422htzg'
    };

filenames={ % comp entre collect data com measure filter
    '08CL_100__18'
    '08CL_100_jonk_18'
    '08CL_100_htzg_18'
    };

filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
    '08CL_100__14_PI_Td2o_05_05f1422jonk.mat' 
    '08CL_100_jonk_14_PI_Td2o_10_05f1422jonk.mat' 
    '08CL_100_htzg_14_PI_Td2o_10_05f1422jonk.mat'
    };

filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
    '08CL_100__18_PI_Td2o_10_05f1422jonk.mat' 
    '08CL_100_jonk_18_PI_Td2o_10_05f1422jonk.mat' 
    '08CL_100_htzg_18_PI_Td2o_10_05f1422jonk.mat'
    };

filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
    '08CL_100__18_PI_Td2o_10_05f1422htzg.mat' 
    '08CL_100_jonk_18_PI_Td2o_10_05f1422htzg.mat' 
    '08CL_100_htzg_18_PI_Td2o_10_05f1422htzg.mat'
    };

filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
    '08CL_100__14_PI_Td2o_5_15f1422jonk.mat'
    '08CL_100_jonk_14_PI_Td2o_5_15f1422jonk.mat'
    '08CL_100_htzg_14_PI_Td2o_5_15f1422jonk.mat'
    };

filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
    '08CL_100__14_PI_Td2o_10_05ctrl_stepjonk.mat' 
    '08CL_100_jonk_14_PI_Td2o_10_05ctrl_stepjonk.mat' 
    '08CL_100_htzg_14_PI_Td2o_10_05ctrl_stepjonk.mat'
    };

filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
    '08CL_100__14_PI_Td2o_10_05_LZspec_ctrl_stepjonk.mat'
    '08CL_100__14_PI_Td2o_10_05ctrl_stepjonk'
    };

filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
'08CL_100__14_PI_Td2o_10_05_LZspec_f1422jonk'
'08CL_100__14_PI_Td2o_10_05f1422jonk'
}

filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
'08CL_100__14_PI_Td2o_5_15_LZspec_f1422jonk'
'08CL_100__14_PI_Td2o_5_15f1422jonk'
}

filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
'08CL_100__14_PI_Td2o_10_05_LZspec_f1422jonk'
'08CL_100__14_PI_Td2o_10_05f1422jonk'
}
filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
'08CL_100__14_PI_Td2o_5_15f1422htzg'
'08CL_100__14_PI_Td2o_10_05f1422htzg'
'ganhoHTZGhtzg_f1422htzg'
'ganho5mwLPV_f1422htzg'
}

filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
'08CL_100__18_PI_Td2o_5_15f1422htzg'
'08CL_100__18_PI_Td2o_10_05f1422htzg'
'ganhoHTZGhtzg_f1422htzg'
'ganho5mwLPV_f1422htzg'
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a partir daqui é com dados usados pro IPC tbm

filenames={ % comp primeiros testes usando mesmo ensaio IPC e CPC
%  'OLsin_2down_250_IPC_18_PI_Td2o_10_05stepshrhtzg'   
% 'OLsin_2down_250_IPC_18_PI_Td2o_10_05f1422htzg'
'08CL_100__18_PI_Td2o_10_05f1422htzg'
'08CL_100__18_PI_Td2o_10_05_nofwdf1422htzg' % caso no fwd, com dados cpc
'OLsin_2down_250_IPC_18_PI_Td2o_10_05_fwdf1422htzg'
'OLsin_2down_250_IPC_18_PI_Td2o_10_05_nofwdf1422htzg'
% 'OLsin_2down_250_IPC_18_PI_Td2o_05_15_nofwdf1422htzg' 
'ganhoHTZGhtzg_f1422htzg'
%  'ganho5mwLPV_f1422htzg'
}

filenames = { %comparação fwd com dados usados no artigo do CBA (OL)
'02_down50_18_PI_Td2o_10_05_fwdf1422htzg'
'02_down50_18_PI_Td2o_10_05_nofwdf1422htzg'
}
filenames = { %comparação fwd com dados usados no artigo do CBA (OL)
% requisitos agressivos
'02_down50_18_PI_Td2o_5_15_fwdf1422htzg'
'02_down50_18_PI_Td2o_5_15_nofwdf1422htzg'
}
filenames = { % comparação fwd com ensaio IPC
'OLsin_2down_250_IPC_18_PI_Td2o_10_05_fwdf1422htzg'
'OLsin_2down_250_IPC_18_PI_Td2o_10_5_nofwdf1422htzg'
}

% filenames = { % comparação fwd com ensaio IPC 
%     %requisitos mais agressivos
% 'OLsin_2down_250_IPC_18_PI_Td2o_5_15_fwdf1422htzg'
% 'OLsin_2down_250_IPC_18_PI_Td2o_5_15_nofwdf1422htzg'
% } 


filenames= { % tentativa de ensaio unico, versao final
    '02_down50_18_PI_Td2o_10_05_fwdf1422htzg'
    'OLsin_3p_2down_250_shadIPC_18_PI_Td2o_10_5_nofwdf1422htzg'
    'OLsin_3p_2down_250_shadIPC_18_PI_Td2o_5_15_nofwdf1422htzg'
    'OLsin_3p_2down_250_shadIPC_18_PI_Td2o_10_5_fwdf1422htzg'
    'OLsin_3p_2down_250_shadIPC_18_PI_Td2o_5_15_fwdf1422htzg'
} % fwd method didnt work, only nofwd for some reason. That said, seems nice otherwise.
% gerou controladores que resolveram o problema, although com nofowrd para
% 10_5 deu bem ruim. dito isso, parece um experimento razoavel para IPC e
% CPC. Seguir com ele.


legenda=filenames;

% legenda={
%     'L(z) completo'
%     'L(z) default'
% };
%% 
fhandle=figure();


buffC=[]; buffIAE=[]; buffThetaMaxRate=[];
for i=1:length(filenames)
   load(cell2mat(filenames(i)))
   
   subplot(2,1,1)
   plot(Time,rotspeed,'LineWidth',2)
   hold on
   subplot(2,1,2)
   plot(Time,heta_out*180/pi,'LineWidth',2)
   hold on
   
   
   buffC=[buffC;tf(numD,denD,DT)];
   buffIAE(i)=IAE;
   buffThetaMaxRate(i)=maxThetaDiff;
   
   if exist('lifetimeDamageDataTable')
       LUFname=cell2mat(lifetimeDamageDataTable(1,4));
       buffLFD(i)=cell2mat(lifetimeDamageDataTable(4,4));
       buffLUF(i)=cell2mat(timeUntilFailureDataTable(4,4));
   end
end

   subplot(2,1,1)
legend(legenda,'Interpreter','none')
grid on
xlim([step_ctrl_time step_ctrl_time+29])
ylabel('Velocidade de Rotação (RPM)')
   subplot(2,1,2)
legend(legenda,'Interpreter','none')
grid on
xlim([step_ctrl_time step_ctrl_time+29])
ylabel('Pitch (graus)')


% fhandle_deflex=figure();
% for i=1:length(filenames)
%    load(cell2mat(filenames(i)))
%    
%    if (~exist('deflex'))
%        deflex=TipDxb1;
%    end
%    
%    subplot(2,1,1)
%    hold on
%    plot(Time,deflex,'LineWidth',2)
%    hold on
%    subplot(2,1,2)
%    plot(Time,heta_out*180/pi,'LineWidth',2)
%    hold on
%    
%    
%    buffC=[buffC;tf(numD,denD,DT)];
%    buffIAE(i)=IAE;
%    buffThetaMaxRate(i)=maxThetaDiff;
%    
%    if exist('lifetimeDamageDataTable')
%        LUFname=cell2mat(lifetimeDamageDataTable(1,4));
%        buffLFD(i)=cell2mat(lifetimeDamageDataTable(4,4));
%        buffLUF(i)=cell2mat(timeUntilFailureDataTable(4,4));
%    end
% end
% 
% % não estou salvando a deflexão nos experimentos CPC, n faz sentido plotar
% % isso no momento
%    subplot(2,1,1)
% legend(legenda,'Interpreter','none')
% grid on
% % xlim([step_ctrl_time step_ctrl_time+29])
% ylabel('Deflexão da pá 1 (m)')
%    subplot(2,1,2)
% legend(legenda,'Interpreter','none')
% grid on
% xlim([step_ctrl_time step_ctrl_time+29])
% ylabel('Pitch (graus)')



filenames'
buffC=zpk(buffC)
buffIAE
buffThetaMaxRate

if exist('buffLFD')
    disp(LUFname)
    disp('lifetime damage')
    disp(buffLFD)
    disp('time until failure (y)')
    disp(buffLUF/(60*60*24*365))
end
