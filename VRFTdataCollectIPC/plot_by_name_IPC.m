%%
if ~exist('plot_by_name_IPC_auto_flag')||plot_by_name_IPC_auto_flag==0
clear all
close all

end

before_time=20;
after_time=100;

% para tempo stepshr em que é 18 m/s
before_time=-50;
after_time=80;

% para steady18
before_time=0;
after_time=40; % at 40 there is a step of 2 wind


filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
    '08CL_100__18_PI_Td2o_10_05f1422htzg.mat'
    'OL_100_sq_IPC_18_RessP_Td1_IPCf1422shrhtzg.mat'
    };


filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
    'OL_100_sq_IPC_18_RessP_Td1_IPCstepshrhtzg1.mat'
    '08CL_100__18_PI_Td2o_10_05stepshrhtzg.mat'
    };

filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
    'OL_100_sq2_IPC_18_Ress2P_Td1_IPCstepshrhtzg1.mat'
    '08CL_100__18_PI_Td2o_10_05stepshrhtzg.mat'
    };

filenames={ % comp entre controladores feitos pelo collect data com dif meas. filter
    % 'OL_100_sq2_IPC_18_Ress_Td1_IPCstepshrhtzg.mat'
    'OL_100_sq2_IPC_18_RessP_Td1_IPCstepshrhtzg.mat'
    % 'OL_100_sq2_IPC_18_RessPI_Td1_IPCstepshrhtzg.mat'
    '08CL_100__18_PI_Td2o_10_05stepshrhtzg.mat'
    };

filenames={ % diferença no polo para TdRI
    % 'OL_100_sq2_IPC_18_RessPI_TdRI08_IPCstepshrhtzg.mat'
    % 'OL_100_sq2_IPC_18_RessPI_TdRI09_IPCstepshrhtzg.mat'
    'OL_100_sq2_IPC_18_RessPI_TdRI095_IPCstepshrhtzg.mat'
    'OL_100_sq2_IPC_18_RessPI_TdRI096_IPCstepshrhtzg.mat'
    % 'OL_100_sq2_IPC_18_RessPI_TdRI098_IPCstepshrhtzg.mat'
    'noIPCstepshrhtzg'
    };

filenames={ % diferença no polo para TdR
    %     'OL_100_sq2_IPC_18_RessP_TdR07_IPCstepshrhtzg'
    %     'OL_100_sq2_IPC_18_RessP_TdR08_IPCstepshrhtzg'
    'OL_100_sq2_IPC_18_RessP_TdR09_IPCstepshrhtzg'
    'noIPCstepshrhtzg'
    };

% filenames={ % diferença no polo para TdRIz
% %     'OL_100_sq2_IPC_18_RessPI_TdRIz05_IPCstepshrhtzg'
% %     'OL_100_sq2_IPC_18_RessPI_TdRIz08_IPCstepshrhtzg'
%     'OL_100_sq2_IPC_18_RessPI_TdRIz09_IPCstepshrhtzg'
% %     'OL_100_sq2_IPC_18_RessPI_TdRIz093_IPCstepshrhtzg'
% 'noIPCstepshrhtzg'
% }
%
% filenames={ % diferença para VRFT feito sem shr, em TdRz
%      'OL_2down_100_noshrIPC_18_RessPI_TdRIz05_IPCstepshrhtzg'
%      'OL_2down_100_noshrIPC_18_RessPI_TdRIz08_IPCstepshrhtzg'
%      'OL_2down_100_noshrIPC_18_RessPI_TdRIz09_IPCstepshrhtzg'
% 'noIPCstepshrhtzg'
% }
% filenames={ % diferença para VRFT feito sem shr, em TdR
% %      'OL_2down_100_noshrIPC_18_RessP_TdR05_IPCstepshrhtzg'
% %      'OL_2down_100_noshrIPC_18_RessP_TdR07_IPCstepshrhtzg'
%      'OL_2down_100_noshrIPC_18_RessP_TdR08_IPCstepshrhtzg'
%      'OL_2down_100_noshrIPC_18_RessP_TdR09_IPCstepshrhtzg'
% 'noIPCstepshrhtzg'
% }


% filenames={ % dados em CL, em TdR
% %     'CL_2down_100_IPC_18_RessP_TdR05_IPC.matstepshrhtzg.mat'
% %     'CL_2down_100_IPC_18_RessP_TdR06_IPC.matstepshrhtzg.mat'
%     'CL_2down_100_IPC_18_RessP_TdR08_IPC.matstepshrhtzg.mat'
%     'CL_2down_100_IPC_18_RessP_TdR09_IPC.matstepshrhtzg.mat'
%     'noIPCstepshrhtzg'
% }

% filenames={ %testedControllers.mat
% %     'CL_2down_100_IPC_18_RessP_TdR05_IPC.matstepshrhtzgw18.mat'
% %     'CL_2down_100_IPC_18_RessP_TdR06_IPC.matstepshrhtzgw18.mat'
%     'CL_2down_100_IPC_18_RessP_TdR08_IPC.matstepshrhtzgw18.mat'
%     'CL_2down_100_IPC_18_RessP_TdR09_IPC.matstepshrhtzgw18.mat'
%     'noIPCstepshrhtzg'
% }

filenames={ %testedControllers.mat
    %     'OL_100_sq2_IPC_18_RessP_TdR05_IPC.matstepshrhtzgw18.mat'
    %     'OL_100_sq2_IPC_18_RessP_TdR06_IPC.matstepshrhtzgw18.mat'
    'OL_100_sq2_IPC_18_RessP_TdR08_IPC.matstepshrhtzgw18.mat'
    'OL_100_sq2_IPC_18_RessP_TdR088_IPCstepshrhtzg.mat'
    'OL_100_sq2_IPC_18_RessP_TdR09_IPC.matstepshrhtzgw18.mat'
    'noIPCstepshrhtzg'
    };

% filenames={ %testedControllers1
% %     'OL_100_sq2_IPC_18_RessPI_TdRI08_IPC.matstepshrhtzgw18.mat'
% %     'OL_100_sq2_IPC_18_RessPI_TdRI09_IPC.matstepshrhtzgw18.mat'
%     'OL_100_sq2_IPC_18_RessPI_TdRI095_IPC.matstepshrhtzgw18.mat'
%     'OL_100_sq2_IPC_18_RessPI_TdRI096_IPC.matstepshrhtzgw18.mat'
%     'noIPCstepshrhtzg'
% }

% filenames={ %testedControllers11
% %     'CL_2down_100_IPC_18_RessPI_TdRI09_IPC.matstepshrhtzgw18.mat'
%     'CL_2down_100_IPC_18_RessPI_TdRI095_IPC.matstepshrhtzgw18.mat'
%     'CL_2down_100_IPC_18_RessPI_TdRI096_IPC.matstepshrhtzgw18.mat'
%     'noIPCstepshrhtzg'
% }

% filenames={ %testedControllers111
% %     'CL_2down_100_IPC_18_RessPI_TdRIz08_IPC.matstepshrhtzgw18.mat'
% %     'CL_2down_100_IPC_18_RessPI_TdRIz09_IPC.matstepshrhtzgw18.mat'
%     'CL_2down_100_IPC_18_RessPI_TdRIz092_IPC.matstepshrhtzgw18.mat'
%     'noIPCstepshrhtzg'
% }

% filenames={ %testedControllers1111
% %     'OL_100_sq2_IPC_18_RessPI_TdRIz08_IPC.matstepshrhtzgw18.mat'
%     'OL_100_sq2_IPC_18_RessPI_TdRIz09_IPC.matstepshrhtzgw18.mat'
% %     'OL_100_sq2_IPC_18_RessPI_TdRIz092_IPC.matstepshrhtzgw18.mat'
%     'noIPCstepshrhtzg'
% }

%  filenames={ %comparação PI
% % 'CL_2down_100_IPC_18_TdPI_TdPI08_IPCstepshrhtzg'
% 'CL_2down_100_IPC_18_TdPI_TdPI09_IPCstepshrhtzg'
% 'noIPCstepshrhtzg' }

%  filenames={ %comparação CL vs OL
%     'OL_100_sq2_IPC_18_RessP_TdR09_IPC.matstepshrhtzgw18.mat'
%     'CL_2down_100_IPC_18_RessP_TdR09_IPC.matstepshrhtzgw18.mat'
%     'noIPCstepshrhtzg'}

% filenames={ %testedControllers11111 % a partir daqui a simulaçao é maior
%     % 18m/s de
% %     'OL_100_sq2_IPC_18_RessPI_TdRI08_IPC.matstepshrhtzgw18.mat'
%
%     'OL_100_sq2_IPC_18_RessP_TdRI09_IPC.matstepshrhtzgw18.mat'
% %     'OL_100_sq2_IPC_18_RessPI_TdRI092_IPC.matstepshrhtzgw18.mat'
%
%     'noIPCstepshrhtzg'}


filenames={ % teste stdy
    %     'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
    %     'OL_100_sq2_IPC_18_RessP_TdR1k088_IPCsteady18htzg'
    %     'OL_100_sq2_IPC_18_RessP2_TdR1z2o088_IPCsteady18htzg'
    %     'OL_100_sq2_IPC_18_RessP2_TdR2o088_IPCsteady18htzg'
    'CL_2down_100_IPC_18_RessP2_TdR2o088_IPCsteady18htzg'
    'noIPCsteady18htzg'
    };
filenames={ % teste de TdR2o %testedControllers111111
    %     'OL_100_sq2_IPC_18_RessP2_TdR2o08_IPC.matsteady18htzgw18.mat'
    %     'OL_100_sq2_IPC_18_RessP2_TdR2o083_IPC.matsteady18htzgw18.mat'
    %     'OL_100_sq2_IPC_18_RessP2_TdR2o086_IPC.matsteady18htzgw18.mat'
    'OL_100_sq2_IPC_18_RessP2_TdR2o088_IPC.matsteady18htzgw18.mat'
    %     'OL_100_sq2_IPC_18_RessP2_TdR2o09_IPC.matsteady18htzgw18.mat'
    'noIPCsteady18htzg'
    };

filenames={ % caso TdR3o
    %  'OL_100_sq2_IPC_18_RessP3_TdR3o088_IPCsteady18htzg'
    %  'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg_teste'
    'OL_100_sq2_IPC_18_RessP3_TdR3o088_IPCsteady18htzg'
    'noIPCsteady18htzg'
    };
filenames={ % caso TdR3o, comparação com TdR088
    'OL_100_sq2_IPC_18_RessP3_TdR3o088_IPCsteady18htzg'
    'noIPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
    };

filenames= { % caso coleta dados com senos
    'OLsin_2down_100_IPC_18_RessP_TdR088_IPCsteady18htzg'
    'noIPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
    };

filenames={ % caso coleta dados com seno por 250 seg
    'OLsin_2down_250_IPC_18_cut_RessP_TdR088_IPCsteady18htzg'
    'noIPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
    'CLsin_2down_250_IPC_18_cut_RessP_TdR1k088_IPCsteady18htzg'
    'CLsin_2down_250_IPC_18_cut_RessP_TdR088_IPCsteady18htzg'
    'CLsin_2down_100_IPC_18_RessP_TdR088_IPCsteady18htzg'
    };



filenames={ % Caso 3p com T=100 
    'noIPCsteady18htzg'
    'OL_3p_2down_100_IPC_18_RessP_TdR088_IPCsteady18htzg'
};% não consgeui funcionar em TdR2o =o

filenames={ % Caso senoide com pitch CPC no colect
%     'noIPCsteady18htzg'
%     'OLsin_3p_2down_250_IPC_18_RessP_TdR088_IPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP2_TdR2o088_IPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP2_TdR2o09_IPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP2_TdR2o0902_IPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP2_TdR2o0906_IPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP2_TdR2o091_IPCsteady18htzg'
    } %fine TDR, holy shit finalmente funcionou para tdr2o. Me parece que usar o mesmo angulo nas três pás no experimento foi ótimo!

filenames={ % Caso onda quadrada 3p no collect T=250
    'noIPCsteady18htzg'
'OL_3p_2down_250_IPC_18_RessP2_TdR2o09_IPCsteady18htzg'
}; % mostly bad but got one not unstable

filenames={ % Caso senoide small 3p no collect T=250
    'noIPCsteady18htzg'
    'OLsinSmall_3p_man_250_IPC_18_RessP_TdR088_IPCsteady18htzg'
'OLsinSmall_3p_man_250_IPC_18_RessP2_TdR2o0905_IPCsteady18htzg'
};

filenames={ % Caso senoide_14 3p no collect T=250
    'noIPCsteady18htzg'
'OLsin_3p_2down_250_IPC_14_RessP2_TdR2o09_IPCsteady18htzg'
};

filenames={ % Caso TdG, primeiros resultados
    'noIPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdG088_IPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP_TdG03_IPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP_TdG04_IPCsteady18htzg'
}; % Para zeta pequeno (<0.3) nao reduziu mt bem, mas para zeta = 0.4 teve resultado tao bom quanto o TdR

filenames={ % Caso TdGm09, ou seja, modulo dos polos da TdG sendo 0.9 (mas mesma freq.).
    'noIPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP_TdGm09_04_IPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
};

filenames={ % Caso TdG2o
    'noIPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP2_TdG2o01_IPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
};% todos os controladores gerados, mesmo variando os dados do ensaio e zeta
%apresentaram ganho mt pequeno, fazendo o controlador ser praticamente zero
% e com uns zeros altamente instavels (z+2)

filenames={ % Caso TdG2o_09m
    'noIPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
};% nao consegui nenhum controlador que nao instabilizasse totalmente


filenames={ % Caso TdG, primeiros resultados
    'noIPCsteady18htzg'
%     'OL_100_sq2_IPC_18_RessP_TdG088_IPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP_TdG03_IPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP_TdG04_IPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
}; % Para zeta pequeno (<0.3) nao reduziu mt bem, mas para zeta = 0.4 teve resultado tao bom quanto o TdR

filenames={ % Caso TdGts: reduziram fundamental
    'noIPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdGts10_IPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdGts8_IPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdGts5_IPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP_TdGts10_IPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP_TdGts5_IPCsteady18htzg'
    'OL_3p_2down_250_IPC_18_RessP_TdGts10_IPCsteady18htzg'
    'OL_3p_2down_250_IPC_18_RessP_TdGts5_IPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
}; % funcionou bem para ts=10. (zeta =0.34)
% range ts:[5,10], range zeta=[0.65;0.34]
% 3p ou 1p?  funfou pra ambos
% u ensaio sin ou step?funfou pra ambos
% controladores instaveis, mas funcionaram e nao instabilizam o sistema

filenames={ % Caso TdGts2o: reduziram fundamental e segunda harmonica? nenhum
    'noIPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP2_TdGts2o20_IPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP2_TdGts2o5_IPCsteady18htzg'
    'OL_3p_2down_250_IPC_18_RessP2_TdGts2o5_IPCsteady18htzg'
    'OL_3p_2down_250_IPC_18_RessP2_TdGts2o4_IPCsteady18htzg'
    'OLsin_2down_250_IPC_18_RessP2_TdGts2o4_IPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
}; % resumo: sempre deu um controlador quase nulo.
% range ts q funfou:
% 3p? nao funfou nem em sin nem em step
% 1p?  nope
% u ensaio sin? em sin3p todos os controladores ficaram com ação nula
% e step? mesma coisa que sin

filenames={ % Caso TdGwd_ts2o: reduziram fundamental e segunda harmonica? funcionou!
    'noIPCsteady18htzg'
%     'OLsin_3p_2down_250_IPC_18_RessP2_TdGwd_ts2o10_IPCsteady18htzg'
%     'OLsin_3p_2down_250_IPC_18_RessP2_TdGwd_ts2o5_IPCsteady18htzg'
%     'OLsin_2down_250_IPC_18_RessP2_TdGwd_ts2o10_IPCsteady18htzg'
    'OLsin_2down_250_IPC_18_RessP2_TdGwd_ts2o4_IPCsteady18htzg'
%     'OLsin_2down_250_IPC_18_RessP2_TdGwd_ts2o3_IPCsteady18htzg'
%   'CLsin_2down_250_IPC_18_cut_RessP2_TdGwd_ts2o5_IPCsteady18htzg'
%   'OL_100_sq2_IPC_18_RessP2_TdGwd_ts2o5_IPCsteady18htzg'
    'OLsin_3p_2down_250_IPC_18_RessP2_TdR2o09_IPCsteady18htzg'
    'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
}; % resumo: 
% range ts q funfou: [3; 10] , zeta [0.7249;0.34] - em 10 já nao é tao bom
% a reduçao da segunda fundamental.
% 3p? funcionou em sin!
% 1p?  workou em sin
% u ensaio sin? funcionou em todos os casos!
% e step? nao workou em step!
%nota: CLsin cut nao funciona nem OL_100_1p
% melhor resultado com ts=4

filenames={ % Caso TdGwd_ts3o: reduziram fundamental e segunda e terceira harmonica? 
    'noIPCsteady18htzg'
    % baseline 1p
    'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
    % 1p:
%     'OLsin_2down_250_IPC_18_RessP32_TdGwd_ts3o10_IPCsteady18htzg'
%     'OLsin_2down_250_IPC_18_RessP32_TdGwd_ts3o8_IPCsteady18htzg'
%     'OLsin_2down_250_IPC_18_RessP32_TdGwd_ts3o6_IPCsteady18htzg'  %best of all ts3o
    'OLsin_2down_250_IPC_18_RessP2_TdGwd_ts2o4_IPCsteady18htzg' % best of all ts2o
%     'OLsin_2down_250_IPC_18_RessP32_TdGwd_ts3o4_IPCsteady18htzg'
    % 3p:
%     'OLsin_3p_2down_250_IPC_18_RessP32_TdGwd_ts3o5_IPCsteady18htzg'
% %     'OLsin_3p_2down_250_IPC_18_RessP32_TdGwd_ts3o6_IPCsteady18htzg'
%     'OLsin_3p_2down_250_IPC_18_RessP32_TdGwd_ts3o7_IPCsteady18htzg'
%     'OLsin_3p_2down_250_IPC_18_RessP32_TdGwd_ts3o8_IPCsteady18htzg'
%     'OLsin_3p_2down_250_IPC_18_RessP32_TdGwd_ts3o10_IPCsteady18htzg'
%     'OLsin_3p_2down_250_IPC_18_RessP32_TdGwd_ts3o45_IPCsteady18htzg'

    % teste com sinal de entrada do experimento com terceira harm em vez da
    % quarta
%     'OLsin23om1_3p_2down_100_IPC_18_RessP32_TdGwd_ts3o9_IPCsteady18htzg'
%     'OLsin23om1_3p_2down_250_IPC_18_RessP32_TdGwd_ts3o9_IPCsteady18htzg'
%     'OLsin23om1_3p_2down_250_IPC_18_RessP32_TdGwd_ts3o10_IPCsteady18htzg'
%     'OLsin23om1_3p_2down_100_IPC_18_RessP32_TdGwd_ts3o6_IPCsteady18htzg'
% 'OLsin23om3_3p_0_2down_250_IPC_18_RessP2_TdGwd_ts2o8_IPCsteady18htzg'    


    }; % resumo: Não obtive sucesso em reduzir a terceira harmônica.
% melhor resultado com ts=6 e 8 para 1p


% teste terceira harmonica e diferentes ensaios
% t= 100, 250, 333
% OLsin23om3_3p_man_250_IPC
% OLsin23om2_3p_man_250_IPC

% filenames={ % Tentativa de matar terceira harmonica utilizando experimentos distintos
%     'noIPCsteady18htzg'
%     'OLsin23om2_3p_man_250_IPC_18_RessP2_TdGwd_ts2o8_IPCsteady18htzg'
% %     'OLsin23om2_3p_man_250_IPC_18_RessP2_TdGwd_ts2o7_IPCsteady18htzg'
% %     'OLsin23om2_3p_man_333_IPC_18_RessP32_TdGwd_ts3o8_IPCsteady18htzg'
% %     'OLsin23om2_3p_man_333_IPC_18_RessP32_TdGwd_ts3o6_IPCsteady18htzg'
% %     'OLsin23om2_3p_man_100_IPC_18_RessP32_TdGwd_ts3o6_IPCsteady18htzg'
% %     'OLsin23om2_3p_man_100_IPC_18_RessP32_TdGwd_ts3o8_IPCsteady18htzg'
%     'OLsin23om3_3p_man_333_IPC_18_RessP32_TdGwd_ts3o8_IPCsteady18htzg'
%     'OLsin23om3_3p_man_333_IPC_18_RessP32_TdGwd_ts3o6_IPCsteady18htzg' % esse eh top
% %     'OLsin23om3_3p_man_250_IPC_18_RessP2_TdGwd_ts2o11_IPCsteady18htzg'
%     'OLsin23om3_3p_man_250_IPC_18_RessP2_TdGwd_ts2o6_IPCsteady18htzg'
%     'OLsin23om3_3p_man_100_IPC_18_RessP32_TdGwd_ts3o10_IPCsteady18htzg'
%     'OLsin23om3_3p_n1_2down_250_IPC_18_RessP32_TdGwd_ts3o10_IPCsteady18htzg'
%     % baseline 1p
%     'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
% }; % testei alguns diferentes ensaios, periodo, ponto de operação, e nada matou
% % a terceira harmonica. segunda harmonica consegui as vezes.


filenames={ % comp do Twr Shadow
    'OLsin_2down_250_IPC_18_RessP2_TdGwd_ts2o4_IPCsteady18_Shadhtzg'
    'OLsin_2down_250_IPC_18_RessP2_TdGwd_ts2o4_IPCsteady18htzg'
'OLsin_2down_250_IPC_18_RessP32_TdGwd_ts3o6_IPCsteady18htzg'
'OLsin_2down_250_IPC_18_RessP32_TdGwd_ts3o6_IPCsteady18_Shadhtzg'
}; % aparentemente o que utilizei para ativar o shadow nao funcionou


filenames =  { % comparação fwd vs nofwd - adaptação do metodo VRFT
    'noIPCsteady18htzg'
    % baseline 1p
    'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
    
    % testando fwd
%    'OLsin_2down_250_IPC_18_RessP32_TdGwd_ts3o8__nofwdIPCsteady18_Shadhtzg'
%    'OLsin_2down_250_IPC_18_RessP32_TdGwd_ts3o6__nofwdIPCsteady18_Shadhtzg'
%    'OLsin_2down_250_IPC_18_RessP32_TdGwd_ts3o8_IPCsteady18_Shadhtzg'
%    'OLsin_2down_250_IPC_18_RessP32_TdGwd_ts3o6_IPCsteady18_Shadhtzg'
   'OLsin23om2_3p_man_250_IPC_18_RessP32_TdGwd_ts3o12__nofwdIPCsteady18_Shadhtzg'
};% os controladores encontrados mudaram - porém os resultados de não 
%conseguir reduzir a terceira harmonica se mantém.

filenames = { % mudança no twr shadow - TWRSHADOW e AeroDyn_Tower.dat.
'OLsin23om2_3p_man_250_IPC_18_RessP32_TdGwd_ts3o12__nofwdIPCsteady18_Shadhtzg'
'OLsin23om2_3p_man_250_IPC_18_RessP32_TdGwd_ts3o12__nofwdIPCsteady18htzg'
}; % tinha erro, jogar fora isso



filenames = { % Comparação shadow corrigida
    'OLsin23om2_3p_man_250_IPC_18_RessP32_TdGwd_ts3o12__nofwdIPCsteady18_Shadhtzg'
    'OLsin23om2_3p_man_250_IPC_18_RessP32_TdGwd_ts3o12__nofwdIPCsteady18htzg'
};

filenames = {  % testando se shadow na coleta traz probelmas
    'noIPC_ganho5mw_steady18_Shad'
%     'noIPCsteady18htzg'
 'OL_100_sq2_IPC_18_RessP_TdR088_IPCsteady18htzg'
% %    % teste shadow'OL_3p_2down_250_shadIPC_18'
% % %  'OL_3p_2down_250_shadIPC_18_RessP32_TdGwd_ts3o10__nofwdIPCsteady18htzg'
% % %  'OL_3p_2down_250_shadIPC_18_RessP32_TdGwd_ts3o8__nofwdIPCsteady18htzg'
% % %  'OL_3p_2down_250_shadIPC_18_RessP32_TdGwd_ts3o8__fwdIPCsteady18htzg'
% % %  'OL_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o8__fwdIPCsteady18htzg'
%  'OLsin_3p_2down_100_shadIPC_18_RessP2_TdGwd_ts2o8__fwdIPCsteady18htzg'
 'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o8__fwdIPCsteady18_Shadhtzg'
 'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o6__fwdIPCsteady18_Shadhtzg'
%  'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzg'
 'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o4__fwdIPCsteady18_Shadhtzg'
 'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o3__fwdIPCsteady18_Shadhtzg'
  
 }; % OL_3p aparentemente nao conseguiu reduzir nem primeira nem segunda harmônica
% OLsin_3p apresentou bons controladores. O melhor caso acontece com ts=4,
% e funciona bem para outros casos tbm entre 3 e 8. o ensaio
% OLsin_3p_2down_250_shadIPC_18 é um ensaio único q funcionou bem para CPC
% e IPC e será o resultado final mostrado na dissertação.


filenames = { % teste print Mlife
    'noIPCsteady18_Shadhtzg'
    'OLsin_3p_2down_250_shadIPC_18_RessP_TdGwd_ts1o3__fwdIPCsteady18_Shadhtzg'
    'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o4__fwdIPCsteady18_Shadhtzg'
};


filenames = { % vc nao vai gostar disso, mas decidi mudar o melhor experimento para ser mais coerente com o que faz sentido
    'noIPCsteady18_Shadhtzg'
    'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o15__fwdIPCsteady18_Shadhtzg'
    'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzg'
    'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o5__fwdIPCsteady18_Shadhtzg'
}; % agora esse é o melhor experimento. OLsin_3p_smol2DC_man_250_shadIPC_18
% possui uma componente DC (square) menor e gerou controladores bons, e faz
% mais sentido do que sair tanto do ponto de operação.


if exist('plot_by_name_IPC_auto_flag')&&plot_by_name_IPC_auto_flag==1
    filenames=filenames_auto_plot_by_name
end
flag_wind=1;

legenda=filenames;
    % legenda={
%     'L(z) completo'
%     'L(z) default'
% };
%%
fhandle=figure();

buffTUF=[];
buffC_IPC=[]; buffIAE=[]; buffThetaMaxRate=[];buff_avg_deflex=[];buff_TD_ipc=[];
for i=1:length(filenames)
    load(cell2mat(filenames(i)))
    
    subplot(3,1,1)
    plot(Time,rotspeed,'LineWidth',2)
    ylabel('rotspeed')
    hold on
    subplot(3,1,2)
    plot(Time,TipDxb1,'LineWidth',2) %TipDxb1
    hold on
    subplot(3,1,3)
    plot(Time,heta_out_3b(:,1)*180/pi,'LineWidth',2)
    hold on
    ylabel('heta_out')
    
    start_idx=(step_ctrl_time-before_time)/DT;
    end_idx=(step_ctrl_time+after_time)/DT;
    buff_avg_deflex(i)=mean(TipDxb1(start_idx:end_idx));
    buff_amplitude(i)=max(TipDxb1(start_idx:end_idx))-min(TipDxb1(start_idx:end_idx));
    buff_avg_rotspeeed(i)=mean(rotspeed(start_idx:end_idx));
    buffC_IPC=[buffC_IPC;tf(numD_IPC,denD_IPC,DT)];
    if exist('timeUntilFailureDataTable')
    buffTUF=[buffTUF; timeUntilFailureDataTable{4,4}];
    else
        buffTUF=[buffTUF;0];
    end
    if exist('Td_IPC')
        buff_TD_ipc=[buff_TD_ipc;Td_IPC]; end
    %    buffIAE(i)=IAE;
    %    buffThetaMaxRate(i)=maxThetaDiff;
    
    
end

subplot(3,1,1)
legend(legenda,'Interpreter','none')
grid on
xlim([step_ctrl_time-before_time step_ctrl_time+after_time])
ylabel('Velocidade de Rotação (RPM)')

subplot(3,1,2)
legend(legenda,'Interpreter','none')
grid on
xlim([step_ctrl_time-before_time step_ctrl_time+after_time])
ylabel('TipDxb1')

subplot(3,1,3)
legend(legenda,'Interpreter','none')
grid on
xlim([step_ctrl_time-before_time step_ctrl_time+after_time])
ylabel('auto')
ylabel('Pitch (graus)')


if flag_wind
   figure()
  for i=1:length(filenames)
    load(cell2mat(filenames(i)))
    
    plot(Time,wind,'LineWidth',2)
    hold on
  end

legend(legenda,'Interpreter','none')
grid on
xlim([step_ctrl_time-before_time step_ctrl_time+after_time])
ylabel('auto')
ylabel('wind') 
end



avg_deflex=buff_avg_deflex';
amplitude=buff_amplitude';
avg_rotspeed=buff_avg_rotspeeed';
%%
filenames
buff_TD_ipc=zpk(buff_TD_ipc)
buffC_IPC=zpk(buffC_IPC)
buffTUF
disp('avg_deflex  amplitude avg_rotspeed')
disp([avg_deflex , amplitude , avg_rotspeed])
% avg_deflex=buff_avg_deflex'
% amplitude=buff_amplitude'
% avg_rotspeed=buff_avg_rotspeeed'


%% spec by name
spec_by_name