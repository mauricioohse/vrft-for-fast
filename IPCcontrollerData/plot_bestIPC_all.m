%% script para reunir todos os plots do IPC para o mestrado


%1) dados Ensaio unico de vento constante + shadow: vento em 14, 18 e 22: tabela
%2) comparando requisito do projeto IPC
%3) CPC gerado com mesmo ensaio
%4) ensaio em malha aberta IPC - em 14, 18 e 22
%5) ensaio excitado VRFT
%6) bodeplot modelo de referência + função de transferencia deles
%7) Comparação efeito pontop coleta de dados
%8) Plot do vento rajada coerente extrema CPC 
%9) Efeito tower shadow e cisalhamento + deflexão três pás
%10) dados com diferentes sinais de excitação
%11) Efeito dos diferentes sinais de excitação (dados + desempenho)
%12) baseline vs VRFT final: rajada de vento e shr com CPC + IPC -
%comparação final
%% 1) ensiao unico dados

filenames_steady14={
    'OLsin_3p_2down_250_shadIPC_14'
    'OLsin_3p_2down_250_shadIPC_18'
    'OLsin_3p_2down_250_shadIPC_22'
    };
legenda={'14 m/s','18 m/s','22 m/s'}
figure()
for i=1:length(filenames_steady14)
    load(cell2mat(filenames_steady14(i)))
    
    subplot(2,1,1)
    plot(Time-Time(1),rotspeed,'LineWidth',2)
    ylabel('rotspeed')
    hold on
    
    subplot(2,1,2)
    plot(Time-Time(1),heta_out*180/pi,'LineWidth',2)
    hold on
    ylabel('heta_out')
end


subplot(2,1,1)
legend(legenda,'Interpreter','none')
grid on
ylabel('Velocidade de Rotação (RPM)')
xlim([0 300])
subplot(2,1,2)
grid on
ylabel('Sinal de controle')
    xlim([0 300])

%% 2) Graficos steady 18 para ressP2 - efeito do requisito de projeto / modelo de referencia
clear all
close all
% for RESSP2
% filenames_steady14={ % this is older, now i use smol2
%     'noIPCsteady18_Shadhtzgauto'
%     'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o15__fwdIPCsteady18_Shadhtzgauto'
%     'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzgauto'
%     'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o4__fwdIPCsteady18_Shadhtzgauto'
%     'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o3__fwdIPCsteady18_Shadhtzgauto'
%     };
filenames_steady14={ %esse eh o oficial: ajustar quais pra plot/print
    'noIPCsteady18_Shadhtzgauto.mat'
% %     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o30__fwdIPCsteady18_Shadhtzgauto.mat'
% %     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o15__fwdIPCsteady18_Shadhtzgauto.mat'
    'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzgauto.mat' %
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o7__fwdIPCsteady18_Shadhtzgauto.mat'
    'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o5__fwdIPCsteady18_Shadhtzgauto.mat'
% %     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o3__fwdIPCsteady18_Shadhtzgauto.mat'     

    };
% for RESSP
% filenames_steady14={ %esse eh o oficial: ajustar quais pra plot/print
%     'noIPCsteady18_Shadhtzgauto.mat'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o30__fwdIPCsteady18_Shadhtzgauto.mat'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o15__fwdIPCsteady18_Shadhtzgauto.mat'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzgauto.mat'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o7__fwdIPCsteady18_Shadhtzgauto.mat'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o5__fwdIPCsteady18_Shadhtzgauto.mat'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o3__fwdIPCsteady18_Shadhtzgauto.mat'
%     };

legenda={'Sem IPC', 'C_{3\gamma}', 'C_{5\gamma}', 'C_{5\gamma}', 'C_{IPC4}'};
colors={[1 .5 .5], [1 0 1], [1 0 0], [0 0 1],[0 1 1],[0 1 1],[0 1 1],[0 1 1],[0 1 1]};
before_time=0;
after_time=30;

figure()
buffTUF=[];buffIAE_TiDxb1=[]; buffISTC=[];
buffC_IPC=[]; buffIAE=[]; buffThetaMaxRate=[];buff_avg_deflex=[];buff_TD_ipc=[];
for i=1:length(filenames_steady14)
    load(cell2mat(filenames_steady14(i)))
    
subplot(1,2,1) % fft deflex
    fs=1/DT;
    t_ini=70/DT;
    t_fim=100/DT;
    sinal=TipDxb1(t_ini:t_fim);
    nn=length(sinal);
    freq = (fs/2)*linspace(0,1,nn/2+1);
    
    x = fft(sinal,nn)/nn;
    amp = abs(x(1:nn/2+1));
    ang = angle(x(1:nn/2+1));
    
    amplitude = 20*log10(amp);
    
    % figure ,'color',[1 1 1]*0
    loglog(freq,amp,'Linewidth',2) %
    grid on
    hold on
    
    
    subplot(2,2,2)
    plot(Time(t_ini:t_fim)-Time(t_ini),TipDxb1(t_ini:t_fim),'LineWidth',2) %TipDxb1
    hold on
    subplot(2,2,4)
    plot(Time(t_ini:t_fim)-Time(t_ini),heta_out_3b(t_ini:t_fim,1)*180/pi,'LineWidth',2)
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
    buffIAE=[buffIAE;IAE];
    buffIAE_TiDxb1=[buffIAE_TiDxb1;IAE_TipDxb1];
    
    CalculaTV;
    buffISTC=[ buffISTC;TV ];
    %    buffIAE(i)=IAE;
    buffThetaMaxRate(i)=max(diff(heta_out_3b(t_ini:t_fim,1)*180/pi)/DT);
    
    
end

subplot(1,2,1)
legend(legenda)
grid on
xlim([0.0333 1])
ylabel('FFT deflexão (m)')
xlabel('Frequência [Hz]')

subplot(2,2,2)
grid on
xlim([0 30])
ylabel('Deflexão (m)')
xlabel('Tempo (s)')

subplot(2,2,4)
grid on
xlim([0 30])
ylabel('auto')
ylabel('Pitch (graus)')
xlabel('Tempo (s)')


% spectro
fh_spec=figure();


for idx_fae=1:length(filenames_steady14)
    load(filenames_steady14{idx_fae})
    
    
    fs=1/DT;
    sinal=TipDxb1(start_idx:end_idx);
    
    subplot(1,1,1)
    fft_add(fs,sinal);
    
%     subplot(2,1,2)
%     plot(Time,TipDxb1,'LineWidth',2)
%     hold on
end
subplot(1,1,1)
leg= legend(filenames_steady14);
set(leg, 'Interpreter', 'none')
grid on

% printa os dados
filenames_steady14
% buff_TD_ipc=zpk(buff_TD_ipc)
buffC_IPC=zpk(buffC_IPC)
buffTUF=buffTUF/buffTUF(1)*100
buffIAE_TiDxb1
% buffISTC
% disp('avg_deflex  amplitude avg_rotspeed')
% disp([avg_deflex , amplitude , avg_rotspeed])

% % conversão ts  - xi
% wf=1.26*0.05
% wd=wf
% ts=[30 15 10 7 5 4]
% xi=4./sqrt(wf^2.*ts.^2+16)


%% 3) CPC  ensaio unico
clear all
close all

filenames_steady14={
%     'ganho5mwLPV_f1422htzg'
%     'ganhoHTZGhtzg_f1422htzg'
'ganho5mw_Td2o_5_15LPV_f1422'
% 'ganho5mw_Td2o_5_30LPV_f1422'
% '02_down50_18_PI_Td2o_10_05_f1422'
'02_down50_18_PI_Td2o_5_15_f1422'
%     'OLsin_3p_2down_250_shadIPC_18_PI_Td2o_10_5_nofwdf1422htzg' %c18u
    'OLsin_3p_2down_250_shadIPC_18_PI_Td2o_5_15_nofwdf1422htzg' %c5u
%     'OLsin_3p_2down_250_shadIPC_18_PI_Td2o_5_30_nofwdf1422htzg'
    }
legenda={'C_{b1}','C_{5}','C_{5u}'};
colors={[1 .5 .5], [1 0 1], [1 0 0], [0 0 1]};
% colors={[0.9290 0.6940 0.1250], [0.4940 0.1840 0.5560],[0.8500 0.3250 0.0980] , [0 0.4470 0.7410]};
linestyles={'-.',':','-','-'};


% legenda={'cb1','cb2','c5','c6'};
before_time=0;
after_time=30;
step_ctrl_time=30;
timeUntilFailureDataTable{4,4}=0;
buffC=[]; buffIAE=[]; buffThetaMaxRate=[];buff_avg_deflex=[];buffTUF=[];buffISTC=[];
for i=1:length(filenames_steady14)
    load(cell2mat(filenames_steady14(i)))
    
    subplot(3,1,1)
    plot(Time-Time(1),rotspeed,'LineWidth',2)
    ylabel('rotspeed')
    hold on
    subplot(3,1,2)
    plot(Time-Time(1),heta_out*180/pi,'LineWidth',2) %TipDxb1
    hold on

    
    
    start_idx=(step_ctrl_time-before_time)/DT;
    end_idx=(step_ctrl_time+after_time)/DT;

    buffC=[buffC;tf(numD,denD,DT)];
    if exist('timeUntilFailureDataTable')
    buffTUF=[buffTUF; timeUntilFailureDataTable{4,4}];
    else
        buffTUF=[buffTUF;0];
    end
    
    buffIAE=[buffIAE;IAE];
    
    CalculaTV;
    buffISTC=[ buffISTC;TV ];
    %    buffIAE(i)=IAE;
    %    buffThetaMaxRate(i)=maxThetaDiff;
    
    
end
    subplot(3,1,3)
    plot(Time,wind,'LineWidth',2)
    hold on

subplot(3,1,1)
legend(legenda)
grid on
xlim([step_ctrl_time-before_time step_ctrl_time+after_time])
ylabel('Velocidade de Rotação (RPM)')

subplot(3,1,2)
legend(legenda)
grid on
xlim([step_ctrl_time-before_time step_ctrl_time+after_time])
ylabel('Pitch (graus)')

subplot(3,1,3)
legend('distúrbio')
grid on
xlim([step_ctrl_time-before_time step_ctrl_time+after_time])
ylabel('auto')
ylabel('Intensidade de vento (m/s)')

buffC=zpk(buffC)
buffTUF
buffIAE
buffISTC

%% 4) ensaio em malha aberta IPC - em 14, 18 e 22
clear all
close all

filenames_steady14={
    'noIPCsteady14_Shadhtzglong'
    'noIPCsteady18_Shadhtzglong'
    'noIPCsteady22_Shadhtzglong'
    }

% filenames={
%     'OL_3p_2down_250_shadIPC_14'
%     'OL_3p_2down_250_shadIPC_18'
%     'OL_3p_2down_250_shadIPC_22'
% }


legenda={'14 m/s','18 m/s','22 m/s',};
% colors={[1 .5 .5], [1 0 1], [1 0 0], [0 0 1]};
colors={[1 0 1], [1 0 0], [0 0 1]};
linestyles={'-.',':','-','-'};

figure()




for i=1:length(filenames_steady14)
    load(cell2mat(filenames_steady14(i)))
    t_ini=70/DT;
    t_fim=100/DT;

    subplot(2,1,2)
    plot(Time(t_ini:t_fim)-Time(t_ini),TipDxb1(t_ini:t_fim),'LineWidth',2)
    hold on
    
    
    t_ini=70/DT;
    t_fim=100/DT;
    fs=1/DT;
    sinal=TipDxb1(t_ini:t_fim);
    
    subplot(2,1,1)
    nn=length(sinal);
    freq = (fs/2)*linspace(0,1,nn/2+1);
    
    x = fft(sinal,nn)/nn;
    amp = abs(x(1:nn/2+1));
    ang = angle(x(1:nn/2+1));
    
    amplitude = 20*log10(amp);
    
    % figure ,'color',[1 1 1]*0
%      semilogx(freq,amp,'Linewidth',2) %
     loglog(freq,amp,'Linewidth',2) %
    grid on
    hold on
    
    
    %     plot(Time(t_ini:t_fim)-Time(t_ini),heta_out(t_ini:t_fim)*180/pi,'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
    %     hold on
    % Dados:
    % pitch pontop  14: 8.49
    %               18: 14.76
    %               22: 19.71
    %
    
end

subplot(2,1,2)
ylabel('Deflexão pá (m)')
xlabel('Tempo (s)')
grid on
xlim([0 30])

subplot(2,1,1)
ylabel(' FFT deflexão (m)')
xlabel('Frequencia [Hz]')
xlim([0.0333333 10])
grid on
legend(legenda)

%% 5) ensaio excitado VRFT (pontops)
clear all
close all

% filenames={ % older best
%     'OLsin_3p_2down_250_shadIPC_14'
%     'OLsin_3p_2down_250_shadIPC_18'
%     'OLsin_3p_2down_250_shadIPC_22'
% };
filenames_steady14={
    'OLsin_3p_smol2DC_man_250_shadIPC_14'
    'OLsin_3p_smol2DC_man_250_shadIPC_18'
    'OLsin_3p_smol2DC_man_250_shadIPC_22'
    }
DT=0.05;
    t_ini=50/DT;
    t_fim=300/DT;
legenda={'14 m/s','18 m/s','22 m/s',};
colors={[1 0 1], [1 0 0], [0 0 1]};
linestyles={'-','-','-','-'};

for i=1:length(filenames_steady14)
load(filenames_steady14{i})
subplot(3,1,1) % deflex pá
    plot(Time(t_ini:t_fim)-Time(t_ini),TipDxb1(t_ini:t_fim),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
    hold on

subplot(3,1,2)
    plot(Time(t_ini:t_fim)-Time(t_ini),heta_out(t_ini:t_fim)*180/pi,'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
    hold on
    
subplot(3,1,3)
    plot(Time(t_ini:t_fim)-Time(t_ini),rotspeed(t_ini:t_fim),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
    hold on
end


subplot(3,1,1)
ylabel('Deflexão pá (m)')
xlabel('Tempo (s)')
legend(legenda)
xlim([0 250])
grid on

subplot(3,1,2)
ylabel('Pitch (graus)')
xlabel('Tempo (s)')
xlim([0 250])
grid on

subplot(3,1,3)
ylabel('Velocidade de rotação (RPM)')
xlabel('Tempo (s)')
xlim([0 250])
grid on

% essa figura possui FFT do regime permanente e do disturbio
figure()

subplot(1,2,1) % fft deflex
    fs=1/DT;
    t_ini=50/DT;
    t_fim=175/DT;
    sinal=TipDxb1(t_ini:t_fim);
    nn=length(sinal);
    freq = (fs/2)*linspace(0,1,nn/2+1);
    
    x = fft(sinal,nn)/nn;
    amp = abs(x(1:nn/2+1));
    ang = angle(x(1:nn/2+1));
    
    amplitude = 20*log10(amp);
    
    % figure ,'color',[1 1 1]*0
    loglog(freq,amp,'Linewidth',2) %
    grid on
    hold on

subplot(1,2,2) % fft deflex
    fs=1/DT;
    t_ini=200/DT;
    t_fim=300/DT;
    sinal=TipDxb1(t_ini:t_fim);
    nn=length(sinal);
    freq = (fs/2)*linspace(0,1,nn/2+1);
    
    x = fft(sinal,nn)/nn;
    amp = abs(x(1:nn/2+1));
    ang = angle(x(1:nn/2+1));
    
    amplitude = 20*log10(amp);
    
    % figure ,'color',[1 1 1]*0
    loglog(freq,amp,'Linewidth',2) %
    grid on
    hold on



subplot(1,2,1)
ylabel('FFT deflexão ( m)')
xlabel('Frequencia [Hz]')
plot(ones(1,2)*0.2017,[1e-4 10],'LineWidth',2)
xlim([0.1 2])
ylim([1e-4 1e0])
legend('deflexão','0.2017 Hz')
title('(a)')
subplot(1,2,2)
plot(ones(1,2)*0.2017,[1e-4 10],'LineWidth',2)
xlim([0.1 2])
ylim([1e-4 1e0])
legend('deflexão','0.2017 Hz')
title('(b)')
xlabel('Frequencia [Hz]')

% teste max taxa de pitch
% load OLsin_3p_smol2DC_man_250_shadIPC_18
% figure()
% subplot(3,1,1)
% plot(Time(t_ini:t_fim)-Time(t_ini),heta_out(t_ini:t_fim)*180/pi,'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
% hold on
% legend('pitch')
% subplot(3,1,2)
% plot(Time(t_ini:(t_fim-1))-Time(t_ini),diff(heta_out(t_ini:t_fim)*180/pi)/DT,'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
% hold on
% legend('pitch/s')
% 
% subplot(3,1,3)
% plot(Time(t_ini:(t_fim-2))-Time(t_ini),diff(diff(heta_out(t_ini:t_fim)*180/pi)/DT)/DT,'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
% hold on
% legend('pitch/s^2')
% title('verificando taxa de pitch maxima')
%% 6) bodeplot modelo de referência

clear all
close all

filenames_steady14={ % AQUI SÓ ESTOU USANDO OS CONTROLADORES, NAO O ENSAIO COMO UM TODO
    'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o15__fwdIPC'
    'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPC'
    'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o4__fwdIPC'
    }


% colors={[1 .5 .5], [1 0 1], [1 0 0], [0 0 1]};
colors={[1 0 1], [1 0 0], [0 0 1]};
linestyles={'-.',':','-','-'};

figure()


buff_TdIPC=[];
for i=1:length(filenames_steady14)
    load(cell2mat(filenames_steady14(i)))

    bode(Td_IPC)
    hold on
    buff_TdIPC=[buff_TdIPC;Td_IPC];
end


grid on
xlabel('frequência ')
legend('\xi=0,9732 ','\xi=0,9878','\xi=0,9969')
buff_TdIPC= zpk(buff_TdIPC)
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
ylabel('Magnitude')
%ylabel('fase')


% aqui faço bodeplot de xis diferentes
figure()
% bode plot com xi 0.1, 0.5 e 0.9.
choose_Td_IPC='TdGwd_ts2o';
arr_p=[4 5 7 10 15 30];
% zeta=4/(wn*ts) ts=4/arr_xi(i)*wn
 
for i=1:6
    wd=12.1*2*pi/60;
    p_Td_IPC= arr_p(i); % sqrt(16/(wd^2*arr_z(i))-16/wd^2)  %sqrt((16/arr_z(i)^2-16)/wd^2)
    ChooseTd_IPC
    xi_buff(i)=zeta;
    hold on
    bode(Td)
    hold on
end

grid on
xlabel('frequência ')
legend('\xi=0,1','\xi=0,2','\xi=0,3', '\xi=0,4' ,'\xi=0,5','\xi=0,6' )
buff_TdIPC= zpk(buff_TdIPC)
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
ylabel('Magnitude')
title('')

%% 7) Comparação pontop coleta de dados
clear all
close all

filenames={
'noIPCsteady14_Shadhtzg','noIPCsteady18_Shadhtzg','noIPCsteady22_Shadhtzg',
'OLsin_3p_smol2DC_man_250_shadIPC_14_RessP2_TdGwd_ts2o10__fwdIPCsteady14_Shadhtzgauto.mat','OLsin_3p_smol2DC_man_250_shadIPC_14_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzgauto.mat','OLsin_3p_smol2DC_man_250_shadIPC_14_RessP2_TdGwd_ts2o10__fwdIPCsteady22_Shadhtzgauto.mat'
'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady14_Shadhtzgauto.mat','OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzgauto.mat','OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady22_Shadhtzgauto.mat'
'OLsin_3p_smol3DC_man_250_shadIPC_22_RessP2_TdGwd_ts2o10__fwdIPCsteady14_Shadhtzg.mat','OLsin_3p_smol3DC_man_250_shadIPC_22_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzg.mat','OLsin_3p_smol3DC_man_250_shadIPC_22_RessP2_TdGwd_ts2o10__fwdIPCsteady22_Shadhtzg.mat'
}
buff_IAEIPC=zeros(4,3); buff_TUF=zeros(4,3);controllers=tf(1,1,0.05);
for idx_controller=1:4
    for idx_wind=1:3
    load(filenames{idx_controller,idx_wind})
    
    buff_IAEIPC(idx_controller,idx_wind)=IAE_TipDxb1;
    buff_TUF(idx_controller,idx_wind)=timeUntilFailureDataTable{4,4};
    controllers(idx_controller)=C_IPC;
    CalculaTV
    buff_ISTC(idx_controller)=TV;
    end
end

disp('IAE pontop')
disp('      noIPC | ctrl 14 | ctrl 18 | ctrl 22')
disp(buff_IAEIPC')

disp('TUF pontop')
disp('      noIPC | ctrl 14 | ctrl 18 | ctrl 22')
disp(buff_TUF')
controllers=zpk(controllers)

% plot das figuras, separados por vento
    t_ini=60/DT;
    t_fim=90/DT;
legenda={'noIPC','14 m/s','18 m/s','22 m/s',};
colors={[1 0 1], [1 0 0], [0 0 1], [0 1 1]};
linestyles={'-','-','-','-'};


for i=1:4 % idx controller
    for ii=1:3 %idx wind
        figure(ii)
        
        load(filenames{i,ii})
        
        
        subplot(3,1,1) % deflex pá
        plot(Time(t_ini:t_fim)-Time(t_ini),TipDxb1(t_ini:t_fim),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
        hold on
        
        subplot(3,1,2)
        plot(Time(t_ini:t_fim)-Time(t_ini),heta_out_3b(t_ini:t_fim,1)*180/pi,'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
        hold on
        
        subplot(3,1,3) % fft deflex
        fs=1/DT;
        t_ini=50/DT;
        t_fim=80/DT;
        sinal=TipDxb1(t_ini:t_fim);
        nn=length(sinal);
        freq = (fs/2)*linspace(0,1,nn/2+1);
        
        x = fft(sinal,nn)/nn;
        amp = abs(x(1:nn/2+1));
        ang = angle(x(1:nn/2+1));
        
        amplitude = 20*log10(amp);
        % figure ,'color',[1 1 1]*0
        semilogx(freq,amplitude,'Linewidth',2) %
        grid on
        hold on
        
    end
end


subplot(3,1,1)
ylabel('Deflexão pá (m)')
xlabel('Tempo (s)')
legend(legenda)
xlim([0 30])
grid on

subplot(3,1,2)
ylabel('Pitch (graus)')
xlabel('Tempo (s)')
xlim([0 30])
grid on

subplot(3,1,3)
ylabel('fft deflex')
xlabel('Tempo (s)')
xlim([0 30])
grid on


% a partir daqui é o gráfico nos moldes 29 (fft + def + pitch)
filenames_steady14={
'noIPCsteady18_Shadhtzg',
'OLsin_3p_smol2DC_man_250_shadIPC_14_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzgauto.mat'
'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzgauto.mat'
'OLsin_3p_smol2DC_man_250_shadIPC_22_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzg.mat'
}
legenda={'Sem IPC', 'C_{14\gamma}', 'C_{18\gamma}', 'C_{22\gamma}'};
figure()
buffTUF=[];buffIAE_TiDxb1=[]; buffISTC=[];
buffC_IPC=[]; buffIAE=[]; buffThetaMaxRate=[];buff_avg_deflex=[];buff_TD_ipc=[];
for i=1:length(filenames_steady14)
    load(cell2mat(filenames_steady14(i)))
    
subplot(1,2,1) % fft deflex
    fs=1/DT;
    t_ini=70/DT;
    t_fim=100/DT;
    sinal=TipDxb1(t_ini:t_fim);
    nn=length(sinal);
    freq = (fs/2)*linspace(0,1,nn/2+1);
    
    x = fft(sinal,nn)/nn;
    amp = abs(x(1:nn/2+1));
    ang = angle(x(1:nn/2+1));
    
    amplitude = 20*log10(amp);
    
    % figure ,'color',[1 1 1]*0
    loglog(freq,amp,'Linewidth',2) %
    grid on
    hold on
    
    
    subplot(2,2,2)
    plot(Time(t_ini:t_fim)-Time(t_ini),TipDxb1(t_ini:t_fim),'LineWidth',2) %TipDxb1
    hold on
    subplot(2,2,4)
    plot(Time(t_ini:t_fim)-Time(t_ini),heta_out_3b(t_ini:t_fim,1)*180/pi,'LineWidth',2)
    hold on
    ylabel('heta_out')
    
    start_idx=t_ini;
    end_idx=t_fim;
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
    buffIAE=[buffIAE;IAE];
    buffIAE_TiDxb1=[buffIAE_TiDxb1;IAE_TipDxb1];
    
    CalculaTV;
    buffISTC=[ buffISTC;TV ];
    %    buffIAE(i)=IAE;
    %    buffThetaMaxRate(i)=maxThetaDiff;
    
    
end

subplot(1,2,1)
legend(legenda)
grid on
xlim([0.0333 1])
ylabel('FFT deflexão (m)')

subplot(2,2,2)
grid on
xlim([0 30])
ylabel('Deflexão (m)')

subplot(2,2,4)
grid on
xlim([0 30])
ylabel('auto')
ylabel('Pitch (graus)')


%% 8) Tudo do ensaio unico cpc
clear all
close all
% figura ensaio + tabela + figura comp

% figura ensaio
filename='OLsin_3p_2down_250_shadIPC_18'
i=3


DT=0.05;
    t_ini=50/DT;
    t_fim=300/DT;
legenda={'14 m/s','18 m/s','22 m/s',};
colors={[1 0 1], [1 0 0], [0 0 1]};
linestyles={'-','-','-','-'};


load(filename)


% subplot(3,1,1) % fft deflex
%     fs=1/DT;
%     t_ini=50/DT;
%     t_fim=300/DT;
%     sinal=TipDxb1(t_ini:t_fim);
%     nn=length(sinal);
%     freq = (fs/2)*linspace(0,1,nn/2+1);
%     
%     x = fft(sinal,nn)/nn;
%     amp = abs(x(1:nn/2+1));
%     ang = angle(x(1:nn/2+1));
    
%     amplitude = 20*log10(amp);
%     semilogx(freq,amplitude,'Linewidth',2) %

subplot(3,1,1) % deflex pá
    plot(Time(t_ini:t_fim)-Time(t_ini),rotspeed(t_ini:t_fim),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
    hold on
    
subplot(3,1,2) % deflex pá
    plot(Time(t_ini:t_fim)-Time(t_ini),TipDxb1(t_ini:t_fim),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
    hold on

subplot(3,1,3) % pitch
    plot(Time(t_ini:t_fim)-Time(t_ini),heta_out(t_ini:t_fim)*180/pi,'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
    hold on
    
maxpitchdados=max(diff(heta_out(t_ini:t_fim)*180/pi))/0.05

subplot(3,1,1)
grid on
ylabel('\Omega_r (RPM)')
xlabel('Tempo (s)')

subplot(3,1,2)
% legend(legenda)
grid on
ylabel('Deflexão (m)')
xlabel('Tempo (s)')
ylim([-1 5])

subplot(3,1,3)
% legend(legenda)
grid on
ylabel('auto')
ylabel('Pitch (graus)')
xlabel('Tempo (s)')

% tabela CPC
filenames={
    'ganho5mwLPV_f1422'
    '02_down50_18_PI_Td2o_10_05_f1422'
    '02_down50_18_PI_Td2o_5_15_f1422htzgauto2'
    '02_down50_18_PI_Td2o_5_30_f1422htzgauto2'
'OLsin_3p_2down_250_shadIPC_18_PI_Td2o_10_5_nofwdf1422htzg'
'OLsin_3p_2down_250_shadIPC_18_PI_Td2o_5_15_nofwdf1422htzg'
'OLsin_3p_2down_250_shadIPC_18_PI_Td2o_5_30_nofwdf1422htzg'
};

buffTUF=[]; buffIAE=[];
for i=1:length(filenames)
    load(filenames{i})
    
    buffIAE(i)=IAE;
    Cbuff(i)=C;
    buffTUF=[buffTUF; timeUntilFailureDataTable{4,4}];
end

buffIAE=buffIAE'
buffTUF=buffTUF*100/buffTUF(1)
% Figura CPC
% sepa nao precisa de figura - maybe no anexo?

% tabela IPC
filenames={
    'noIPCsteady18_Shadhtzgauto.mat' 
    'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o15__fwdIPCsteady18_Shadhtzgauto.mat'
    'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzgauto.mat'
    'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o5__fwdIPCsteady18_Shadhtzgauto.mat'
    'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o15__fwdIPCsteady18_Shadhtzg'
    'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzg'
    'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o5__fwdIPCsteady18_Shadhtzg'
    };

buffTUFIPC=[]; buffIAE_IPC=[];
for i=1:length(filenames)
    load(filenames{i})
    
    buffIAE_IPC(i)=IAE_TipDxb1;
%     Cbuff_IPC(i)=C_IPC;
    buffTUFIPC=[buffTUFIPC; timeUntilFailureDataTable{4,4}];
end

buffIAE_IPC=buffIAE_IPC'
buffTUFIPC=buffTUFIPC*100/buffTUFIPC(1)
% figura IPC
% sepa nao precisa de figura - maybe no anexo?


%% 8) Plot do vento rajada coerente extrema CPC 
clear all
close all

load 02_down50_18_PI_Td2o_5_35_f1422htzgauto2

t_ini=20/DT;
t_fim=60/DT;

plot(Time(t_ini:t_fim)-Time(t_ini)-3,wind(t_ini:t_fim),'LineWidth',2)
grid on
ylabel('Intensidade de vento (m/s)')
xlabel('Tempo (s)')
ylim([0 25])
xlim([0 30])


figure()
t_ini=20/DT;
t_fim=60/DT;

plot(Time(t_ini:t_fim)-Time(t_ini)-3,wind(t_ini:t_fim),'LineWidth',2,'color','b')
hold on
plot([0 30],14*ones(2),'LineWidth',2,'color','r','LineStyle', '-.')
plot([0 30],18*ones(2),'LineWidth',2,'color','r','LineStyle', '-.')
plot([0 30],22*ones(2),'LineWidth',2,'color','r','LineStyle', '-.')
grid on
ylabel('Velocidade de vento (m/s)')
xlabel('Tempo (s)')
legend('Distúrbio de vento médio','Cenários de vento médio constante')
ylim([0 25])
xlim([0 30])



%% 9) Efeito tower shadow e cisalhamento
% aqui é um ensaio em malha aberta mesmo para comparar o efeito do tower
% shadow

clear all
close all

filenames_steady14={
    'noIPCsteady18htzg'
    'noIPCsteady18_Shadhtzglong'
    }

% filenames={
%     'OL_3p_2down_250_shadIPC_14'
%     'OL_3p_2down_250_shadIPC_18'
%     'OL_3p_2down_250_shadIPC_22'
% }


legenda={'vento simétrico','vento assimétrico'};
% colors={[1 .5 .5], [1 0 1], [1 0 0], [0 0 1]};
colors={[1 0 1], [1 0 0], [0 0 1]};
linestyles={'-.',':','-','-'};

figure()




for i=1:length(filenames_steady14)
    load(cell2mat(filenames_steady14(i)))
    t_ini=70/DT;
    t_fim=100/DT;

    subplot(2,1,2)
    plot(Time(t_ini:t_fim)-Time(t_ini),TipDxb1(t_ini:t_fim),'LineWidth',2)
    hold on
    
    
    t_ini=70/DT;
    t_fim=100/DT;
    fs=1/DT;
    sinal=TipDxb1(t_ini:t_fim);
    
    subplot(2,1,1)
    nn=length(sinal);
    freq = (fs/2)*linspace(0,1,nn/2+1);
    
    x = fft(sinal,nn)/nn;
    amp = abs(x(1:nn/2+1));
    ang = angle(x(1:nn/2+1));
    
    amplitude = 20*log10(amp);
    
    % figure ,'color',[1 1 1]*0
    loglog(freq,amp,'Linewidth',2) %
    grid on
    hold on
    
    
    %     plot(Time(t_ini:t_fim)-Time(t_ini),heta_out(t_ini:t_fim)*180/pi,'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
    %     hold on
    % Dados:
    % pitch pontop  14: 8.49
    %               18: 14.76
    %               22: 19.71
    %
    
end

subplot(2,1,2)
ylabel('Deflexão (m)')
xlabel('Tempo (s)')
grid on
xlim([0 30])

subplot(2,1,1)
ylabel('FFT deflexão (m)')
xlabel('Frequencia [Hz]')
xlim([0.0333333 10])
ylim([1e-5 10])
grid on
legend(legenda)


figure()
    hold on
    plot(Time(t_ini:t_fim)-Time(t_ini),TipDxb1(t_ini:t_fim),'LineWidth',2)
    plot(Time(t_ini:t_fim)-Time(t_ini),TipDxb2(t_ini:t_fim),'LineWidth',2)
    plot(Time(t_ini:t_fim)-Time(t_ini),TipDxb3(t_ini:t_fim),'LineWidth',2)
ylabel('Deflexão (m)')
xlabel('Tempo (s)')
grid on
xlim([0 30])
grid on
legend('pá 1','pá 2','pá 3')

    

%% 10) dados com diferentes sinais de excitação - wtf parece q eu nao usei isso aqui no fim das contas, é tudo no 11)
clear all
close all

filenames_steady14={
    'OLsin_3p_smol2DC_2_man_250_shadIPC_18' % apenas fundamental
    'OLsin_3p_smol2DC_1_man_250_shadIPC_18' % fundamental + 2
    'OLsin_3p_smol2DC_man_250_shadIPC_18'   % fundamental + 2 + 3 
    }
DT=0.05;
    t_ini=50/DT;
    t_fim=300/DT;
legenda={'u_1','u_2','u_3',};
colors={[1 0 1], [1 0 0], [0 0 1]};
linestyles={'-','-','-','-'};

for i=1:length(filenames_steady14)
load(filenames_steady14{i})
subplot(3,1,1) % deflex pá
    plot(Time(t_ini:t_fim)-Time(t_ini),TipDxb1(t_ini:t_fim),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
    hold on

subplot(3,1,2)
    plot(Time(t_ini:t_fim)-Time(t_ini),heta_out(t_ini:t_fim)*180/pi,'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
    hold on
    
subplot(3,1,3)
    plot(Time(t_ini:t_fim)-Time(t_ini),rotspeed(t_ini:t_fim),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
    hold on
end


subplot(3,1,1)
ylabel('Deflexão pá (m)')
xlabel('Tempo (s)')
legend(legenda)
xlim([0 250])
grid on

subplot(3,1,2)
ylabel('Pitch (graus)')
xlabel('Tempo (s)')
xlim([0 250])
grid on

subplot(3,1,3)
ylabel('Velocidade de rotação (RPM)')
xlabel('Tempo (s)')
ylim([11.5 13])
xlim([0 250])
grid on

% essa figura possui FFT do regime permanente e do disturbio
figure()

for i=1:length(filenames_steady14)
    load(filenames_steady14{i})
subplot(1,2,1) % fft deflex
    fs=1/DT;
    t_ini=50/DT;
    t_fim=175/DT;
    sinal=TipDxb1(t_ini:t_fim);
    nn=length(sinal);
    freq = (fs/2)*linspace(0,1,nn/2+1);
    
    x = fft(sinal,nn)/nn;
    amp = abs(x(1:nn/2+1));
    ang = angle(x(1:nn/2+1));
    
    amplitude = 20*log10(amp);
    
    % figure ,'color',[1 1 1]*0
    loglog(freq,amplitude,'Linewidth',2) %
    grid on
    hold on

subplot(1,2,2) % fft deflex
    fs=1/DT;
    t_ini=200/DT;
    t_fim=300/DT;
    sinal=TipDxb1(t_ini:t_fim);
    nn=length(sinal);
    freq = (fs/2)*linspace(0,1,nn/2+1);
    
    x = fft(sinal,nn)/nn;
    amp = abs(x(1:nn/2+1));
    ang = angle(x(1:nn/2+1));
    
    amplitude = 20*log10(amp);
    
    % figure ,'color',[1 1 1]*0
    loglog(freq,amplitude,'Linewidth',2) %
    grid on
    hold on
end
subplot(1,2,1)
legend(legenda)
xlim([10e-2 1])
ylim([-90 0])
title('(a)')

subplot(1,2,2)
legend(legenda)
xlim([10e-2 1])
ylim([-90 0])
title('(b)')

%% 11) Efeito dos diferentes sinais de excitação
% primeira figura plota o desempenho dos controladores, segunda e terceira
% figura é referente aos dados coletados
clear all
close all

% filenames={ % obs: não funcionou sinal de excitação apenas fundamental
%     'noIPCsteady18_Shadhtzglong'
% %     'OLsin_3p_smol2DC_2_man_250_shadIPC_18_RessP_TdGwd_ts1o10__nofwdIPC'  % apenas fundamental
% %     'OLsin_3p_smol2DC_1_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__nofwdIPC' % fundamental + 2
% %     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP32_TdGwd_ts3o10__nofwdIPC'  % fundamental + 2 + 3
%      'OLsin_3p_smol2DC_1_man_250_shadIPC_18_RessP_TdGwd_ts1o10__nofwdIPCsteady18_Shadhtzg.mat'
% %     'OLsin_3p_smol2DC_1_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__nofwdIPCsteady18_Shadhtzglong.mat'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzg'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP32_TdGwd_ts3o10__nofwdIPCsteady18_Shadhtzglong.mat'
%     }
% 
% filenames={ % comparando todos com o mesmo sinal de excitaçao (mudando TDR/C)
% % %     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP_TdGwd_ts1o10__nofwdIPC'
% % %     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__nofwdIPC'
% % %     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP32_TdGwd_ts3o10__nofwdIPC'
% % %funcional: OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzgauto
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP_TdGwd_ts1o10__nofwdIPCsteady18_Shadhtzglong.mat'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzg.mat'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP32_TdGwd_ts3o10__fwdIPCsteady18_Shadhtzg.mat'
% % % % %     'OLsin_3p_smol2DC_2_man_250_shadIPC_18_RessP_TdGwd_ts1o5__fwdIPCsteady18_Shadhtzglong.mat'
% % % % %     'OLsin_3p_smol2DC_1_man_250_shadIPC_18_RessP2_TdGwd_ts2o5__nofwdIPCsteady18_Shadhtzglong.mat'
% % % % %     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP32_TdGwd_ts3o5__nofwdIPCsteady18_Shadhtzglong.mat'
% % %     'OLsin_3p_smol2DC_2_man_250_shadIPC_18_RessP_TdGwd_ts1o5__fwdIPCsteady18_Shadhtzglong.mat'
% % %     'OLsin_3p_smol2DC_1_man_250_shadIPC_18_RessP2_TdGwd_ts2o5__fwdIPCsteady18_Shadhtzglong.mat'
% % %     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP32_TdGwd_ts3o5__fwdIPCsteady18_Shadhtzglong.mat'
% }

 filenames={ % mudando apenas o sinal de excitação, mas mantendo ressp2
         'noIPCsteady18_Shadhtzglong'
    'OLsin_3p_smol2DC_1_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzglong.mat'
    'OLsin_3p_smol2DC_2_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzglong.mat'
%     'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzglong.mat'
    'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o10__fwdIPCsteady18_Shadhtzgauto'
}
DT=0.05;
        t_ini=50/DT;
        t_fim=80/DT;
        
buff_IAEIPC=zeros(4,3); buff_TUF=zeros(4,3);controllers=tf(1,1,0.05);
for idx_controller=1:length(filenames)
    for idx_wind=1:1
    load(filenames{idx_controller,idx_wind})
    
    buff_IAEIPC(idx_controller,idx_wind)=IAE_TipDxb1;
    buff_TUF(idx_controller,idx_wind)=timeUntilFailureDataTable{4,3};
    controllers(idx_controller)=C_IPC;
    CalculaTV
    buff_ISTC(idx_controller)=TV;
    maxTheta(idx_controller)=max(diff(heta_out_3b(t_ini:t_fim,1)*180/pi)/DT);
    end
end

disp('IAE pontop')
disp('      noIPC | ctrl 14 | ctrl 18 | ctrl 22')
disp(buff_IAEIPC')

disp('TUF pontop')
disp('      noIPC | ctrl 14 | ctrl 18 | ctrl 22')
disp(buff_TUF'/buff_TUF(1,1)*100)
controllers=zpk(controllers)
    t_ini=60/DT;
    t_fim=90/DT;
legenda={'C_b (Sem IPC)',' C_{u_1}',' C_{u_2}',' C_{u_3}'};
colors={[1 0 1], [1 0 0], [0 0 1], [0 1 1]};
linestyles={'-','-','-','-'};


for i=1:length(filenames) % idx controller
    for ii=1:1 %idx wind
        figure(ii)
        
        load(filenames{i,ii})
        
        subplot(1,2,1) % fft deflex
        fs=1/DT;
        t_ini=70/DT;
        t_fim=100/DT;
        sinal=TipDxb1(t_ini:t_fim);
        nn=length(sinal);
        freq = (fs/2)*linspace(0,1,nn/2+1);
        
        x = fft(sinal,nn)/nn;
        amp = abs(x(1:nn/2+1));
        ang = angle(x(1:nn/2+1));
        
        amplitude = 20*log10(amp);
        
    % figure ,'color',[1 1 1]*0
    loglog(freq,amp,'Linewidth',2) %
    grid on
    hold on
        subplot(2,2,2) % deflex pá
        plot(Time(t_ini:t_fim)-Time(t_ini),TipDxb1(t_ini:t_fim),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
        hold on
        
        subplot(2,2,4)
        plot(Time(t_ini:t_fim)-Time(t_ini),heta_out_3b(t_ini:t_fim,1)*180/pi,'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
        hold on
        
    end
end
    

subplot(1,2,1)
ylabel('FFT deflexão (m)')
xlabel('Frequência [Hz]')
legend(legenda)
xlim([0.1 1])
grid on

subplot(2,2,2)
ylabel('Deflexão pá (m)')
xlabel('Tempo (s)')
xlim([0 30])
grid on

subplot(2,2,4)
ylabel('Pitch (graus)')
xlabel('Tempo (s)')
xlim([0 30])
grid on


% parte dos dados - a figura 2 é a resposta no tempo dos dados, que nao é
% utilizada/importante, só a decomposição da deflexão que é.

figure()
 filenames_steady14={ % mudando apenas o sinal de excitação, mas mantendo ressp2
    'OLsin_3p_smol2DC_1_man_250_shadIPC_18'
    'OLsin_3p_smol2DC_2_man_250_shadIPC_18'
    'OLsin_3p_smol2DC_man_250_shadIPC_18'
}

DT=0.05;
    t_ini=50/DT;
    t_fim=300/DT;
legenda={'14 m/s','18 m/s','22 m/s',};
colors={[1 0 1], [1 0 0], [0 0 1]};
linestyles={'-','-','-','-'};

for i=1:length(filenames_steady14)
load(filenames_steady14{i})
subplot(3,1,1) % deflex pá
    plot(Time(t_ini:t_fim)-Time(t_ini),TipDxb1(t_ini:t_fim),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
    hold on

subplot(3,1,2)
    plot(Time(t_ini:t_fim)-Time(t_ini),heta_out(t_ini:t_fim)*180/pi,'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
    hold on
    
subplot(3,1,3)
    plot(Time(t_ini:t_fim)-Time(t_ini),rotspeed(t_ini:t_fim),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
    hold on
end


subplot(3,1,1)
ylabel('Deflexão pá (m)')
xlabel('Tempo (s)')
legend(legenda)
xlim([0 250])
grid on

subplot(3,1,2)
ylabel('Pitch (graus)')
xlabel('Tempo (s)')
xlim([0 250])
grid on

subplot(3,1,3)
ylabel('Velocidade de rotação (RPM)')
xlabel('Tempo (s)')
xlim([0 250])
grid on

% essa figura possui FFT do regime permanente e do disturbio
figure()
legenda_FFT={'u_c_1','u_c_2','u_c_3','0,2017 Hz'};
limite_x=[0.1 1];

for i=1:length(filenames_steady14)
    load(filenames_steady14{i})
subplot(1,2,1) % fft deflex
    fs=1/DT;
    t_ini=75/DT;
    t_fim=150/DT;
    sinal=TipDxb1(t_ini:t_fim);
    nn=length(sinal);
    freq = (fs/2)*linspace(0,1,nn/2+1);
    
    x = fft(sinal,nn)/nn;
    amp = abs(x(1:nn/2+1));
    ang = angle(x(1:nn/2+1));
    
    amplitude = 20*log10(amp);
    
    % figure ,'color',[1 1 1]*0
    loglog(freq,amp,'Linewidth',2) %
    grid on
    hold on

subplot(1,2,2) % fft deflex
    fs=1/DT;
    t_ini=200/DT;
    t_fim=300/DT;
    sinal=TipDxb1(t_ini:t_fim);
    nn=length(sinal);
    freq = (fs/2)*linspace(0,1,nn/2+1);
    
    x = fft(sinal,nn)/nn;
    amp = abs(x(1:nn/2+1));
    ang = angle(x(1:nn/2+1));
    
    amplitude = 20*log10(amp);
    
    % figure ,'color',[1 1 1]*0
    loglog(freq,amp,'Linewidth',2) %
    grid on
    hold on

end

subplot(1,2,1)
ylabel('FFT deflexão ( m)')
xlabel('Frequencia [Hz]')
plot(ones(1,2)*0.2017,[1e-4 10],'LineWidth',2)
xlim(limite_x)
ylim([1e-4 1e0])
legend(legenda_FFT)
title('(a)')
subplot(1,2,2)
plot(ones(1,2)*0.2017,[1e-4 10],'LineWidth',2)
xlim(limite_x)
ylim([1e-4 1e0])
legend(legenda_FFT)
title('(b)')
xlabel('Frequencia [Hz]')



%% 12) baseline vs VRFT final: rajada de vento e shr com CPC + IPC -
%comparação final
clear all
close all

filenames_steady14={
	'noIPCf1422shrhtzg'
	'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o5__fwdIPCf1422shrhtzg' %- CPC 10_05 + IPC ts=5 ensaios especificos
	'OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o5__fwdIPCf1422shrhtzg' %ensaio unico
    }
% ensaio unico: CPC: OLsin_3p_2down_250_shadIPC_18_PI_Td2o_5_15_nofwd
%				IPC: OLsin_3p_2down_250_shadIPC_18_RessP2_TdGwd_ts2o5__fwdIPC


legenda={'Sem IPC', 'C_{18}+ C_5_\gamma', 'C_{18u} + C_{5\gamma u}'};
figure()
buffTUF=[];buffIAE_TiDxb1=[]; buffISTC=[];
buffC_IPC=[]; buffIAE=[]; buffThetaMaxRate=[];buff_avg_deflex=[];buff_TD_ipc=[];
DT=0.05
    t_ini=130/DT;
    t_fim=200/DT;
for i=1:length(filenames_steady14)
    load(cell2mat(filenames_steady14(i)))
    
% subplot(1,2,1) % fft deflex
%     fs=1/DT;
%     sinal=TipDxb1(t_ini:t_fim);
%     nn=length(sinal);
%     freq = (fs/2)*linspace(0,1,nn/2+1);
%     
%     x = fft(sinal,nn)/nn;
%     amp = abs(x(1:nn/2+1));
%     ang = angle(x(1:nn/2+1));
%     
%     amplitude = 20*log10(amp);
%     
%     % figure ,'color',[1 1 1]*0
%     loglog(freq,amp,'Linewidth',2) %
%     grid on
%     hold on
    subplot(3,1,1)
    plot(Time(t_ini:t_fim)-Time(t_ini),rotspeed(t_ini:t_fim),'LineWidth',2) %TipDxb1
    hold on
    
    subplot(3,1,2)
    plot(Time(t_ini:t_fim)-Time(t_ini),TipDxb1(t_ini:t_fim),'LineWidth',2) %TipDxb1
    hold on
    subplot(3,1,3)
    plot(Time(t_ini:t_fim)-Time(t_ini),heta_out_3b(t_ini:t_fim,1)*180/pi,'LineWidth',2)
    hold on
    ylabel('heta_out')
    
    tini_iae=130/DT;
    tfim_iae=190/DT;
    CalculaIAE_after;
    start_idx=t_ini;
    end_idx=t_fim;
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
    buffIAE=[buffIAE;IAE];
    buffIAE_TiDxb1=[buffIAE_TiDxb1;IAE_TipDxb1];
    
    CalculaTV;
    buffISTC=[ buffISTC;TV ];
    %    buffIAE(i)=IAE;
       buffThetaMaxRate(i)=max(diff(heta_out_3b(t_ini:t_fim,1)*180/pi)/DT)/4;
    
    
end

subplot(3,1,1)
legend(legenda)
grid on
xlim([0 60])
ylabel('Velocidade de rotação (RPM)')

subplot(3,1,2)
grid on
xlim([0 60])
ylabel('Deflexão (m)')

subplot(3,1,3)
grid on
xlim([0 60])
ylabel('auto')
ylabel('Pitch (graus)')


% valores tabela
buffIAE
buffIAE_TiDxb1sc=buffIAE_TiDxb1/4
buffISTC
buffThetaMaxRate
buffTUF100=[100 132 115]




















