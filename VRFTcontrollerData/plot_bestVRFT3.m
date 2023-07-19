close all
clear all
%% ideia: agrupar nesse codigo todos os resultados/tabelas e graficos caso eu troque para C14
% tabelas:
% tab 3: controladores com TD_10_05
% tab 4: IAEd e IAE141822 desses controladores
% tab 5: IAEd e IAE14 dos controladores VRFT variando requisito
% tab 6: IAEd e IAE14 dos melhores controladores: td_5_15 e td_5_30
% graficos tab 6







%% tab 3: controladores com TD_10_05

listacontroladores={
 'ganho5mw' % sem LPV pq é o baseline, no texto com f(beta)
 '02_down100_14_PI_Td2o_10_05_'
 '02_down50_18_PI_Td2o_10_05_'
 '02_down50_22_PI_Td2o_10_05_'
};


for i=1:length(listacontroladores)
   load(cell2mat(listacontroladores(i)))
   Cbuff(i)=C;
end

listacontroladores
disp('controladores com TD_10_05:')
zpk(Cbuff)

%% tab 4: IAEd e IAE141822 desses controladores e MLIFE! (rerodei 05/02/23 para pegar dados MLIFE)
listacontroladores{1}='ganho5mwLPV_';
listawind={'f1422htzg','ctrl_step_14','ctrl_step','ctrl_step_22'};
buffTUF=[];
for i=1:length(listacontroladores)
    for j=1:length(listawind)
        
        nomecomposto=strcat(cell2mat(listacontroladores(i)),cell2mat(listawind(j)));
        listacomposto{i,j}=nomecomposto;
        load(nomecomposto)
        if strcmp(listawind(j),'f1422htzg')
            buffTUF=[buffTUF; timeUntilFailureDataTable{4,4}];
        end
        buffIAE(i,j)=IAE;
    end
end
disp('TAB4: COMPARAÇÃO ENTRE CONTROLADORES TD_10_05')
listacontroladores=listacontroladores'
listawind=listawind'
buffIAE=buffIAE'
buffTUF

%% tab 5: IAEd e IAE14 dos controladores VRFT variando requisito e MLIFE!

listacontroladores_f1422={
    'ganho5mwLPV_f1422'
    'ganho5mw_Td2o_5_15f1422'
    'ganho5mw_Td2o_5_30f1422'
    '02_down50_18_PI_Td2o_10_05_f1422'
    '02_down50_18_PI_Td2o_8_05_f1422htzgauto2'
    '02_down50_18_PI_Td2o_5_05_f1422htzgauto2'
    '02_down50_18_PI_Td2o_3_05_f1422htzgauto2'
    '02_down50_18_PI_Td2o_1_05_f1422htzgauto2'
    '02_down50_18_PI_Td2o_5_15_f1422htzgauto2'
    '02_down50_18_PI_Td2o_5_30_f1422htzgauto2'
    '02_down50_18_PI_Td2o_5_35_f1422htzgauto2'
    '02_down50_18_PI_Td2o_5_45_f1422'
};

listacontroladores={
 'ganho5mwLPV_'
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
% % listacontroladores={
% %  '02_down100_14_PI_Td2o_5_05_'
% %  '02_down100_14_PI_Td2o_5_15_'
% %  '02_down100_14_PI_Td2o_5_30_'
% %  '02_down50_18_PI_Td2o_5_05_'
% %  '02_down50_18_PI_Td2o_5_15_'
% %  '02_down50_18_PI_Td2o_5_30_'
% % %  '02_down100_14_PI_Td2o_5_35_'
% % %  '02_down100_14_PI_Td2o_5_45_'
% % };
close all
listawind={'ctrl_step'};

clear buffIAE Cbuff buffTUF

% for ctrl step
for i=1:length(listacontroladores)
    for j=1:length(listawind)
        
        nomecomposto=strcat(cell2mat(listacontroladores(i)),cell2mat(listawind(j)));
        listacomposto{i,j}=nomecomposto;
        load(nomecomposto)
        buffIAE(i,j)=IAE;
        Cbuff(i,j)=C;
    end
end

% for f1422
buffTUF=[];j=2;
for i=1:length(listacontroladores_f1422)
        nomecomposto=listacontroladores_f1422{i};
        listacomposto{i,2}=nomecomposto;
        load(nomecomposto)
        buffIAE(i,j)=IAE;
        Cbuff(i,j)=C;
        buffTUF=[buffTUF; timeUntilFailureDataTable{4,4}];
end
pause(2)
disp('IAEd e IAE14 dos controladores VRFT variando requisito')
listacontroladores
zpk(Cbuff(:,1))
listawind
buffIAE
buffTUF=buffTUF*100/buffTUF(1)

%% tab 6: IAEd e IAE14 dos melhores controladores: td_5_15 e td_5_30
clear all
close all

listacontroladores={'ganho5mw_Td2o_5_15LPV_'
    'ganho5mw_Td2o_5_30LPV_'
    '02_down100_14_PI_Td2o_5_15_'
    '02_down100_14_PI_Td2o_5_30_'};

listawind={'f1422','ctrl_step_14'};

clear buffIAE Cbuff
for i=1:length(listacontroladores)
    for j=1:length(listawind)
        
        nomecomposto=strcat(cell2mat(listacontroladores(i)),cell2mat(listawind(j)));
        listacomposto{i,j}=nomecomposto;
        load(nomecomposto)
        buffIAE(i,j)=IAE;
        Cbuff(i,j)=C;
        add_to_quickPlot(nomecomposto,[25 TMax],j,listacomposto);
%         quick_plot
    end
end
pause(2)
disp('IAEd e IAE14 dos controladores VRFT variando requisito')
listacontroladores
zpk(Cbuff(:,1))
listawind
buffIAE


%% plots finais
clear all

plot_filenames={
    'ganho5mwLPV_'  % BESTS SO FAR
    'ganho5mw_Td2o_5_15LPV_'
%     'ganho5mw_Td2o_5_30'
%     '02_down50_18_PI_Td2o_5_15_' % menção honrosa
    '02_down100_14_PI_Td2o_5_15_'
    '02_down100_14_PI_Td2o_5_30_'
    };
legenda_={'C_{b}','C_{b1}','C_{5}','C_{6}'};
colors={[0 0 0], [.2 .2 .2], [.2 .2 .2], [.6 .6 .6]};
linestyles={':','-.','-','-'};


figure()
IAE_ctrlstep=[];
for i=1:length(plot_filenames)
load_filename=strcat(cell2mat(plot_filenames(i)),'ctrl_step_14');
load(load_filename)
T_inicial=(59/DT);
T_final=(90/DT);
IAE_ctrlstep(end+1)=IAE;

subplot(2,1,1)
plot(Time(T_inicial:T_final)-60,rotspeed(T_inicial:T_final),'Color',cell2mat(colors(i)),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
hold on
subplot(2,1,2)
hold on
plot(Time(T_inicial:T_final)-60,heta_out(T_inicial:T_final)*180/pi,'Color',cell2mat(colors(i)),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
end

% detalhes
subplot(2,1,1)
grid on
xlim([0 30])
legend(legenda_)
xlabel('tempo (s)')
ylabel('Velocidade de rotação (RPM)')

subplot(2,1,2)
grid on
xlim([0 30])
legend(legenda_)
xlabel('tempo (s)')
ylabel('pitch (graus)')

% Agora ao distúrbio
plot_filenames={
    'ganho5mw'  % BESTS SO FAR
    'ganho5mw_Td2o_5_15LPV_'
%     'ganho5mw_Td2o_5_30'
%     '02_down50_18_PI_Td2o_5_15_' % menção honrosa
    '02_down50_18_PI_Td2o_5_15_'
    '02_down50_18_PI_Td2o_5_30_'
    };
figure()
T_inicial=(30/0.05);
T_final=(70/0.05);
IAE_disturbio=[];
for i=1:length(plot_filenames)
load_filename=strcat(cell2mat(plot_filenames(i)),'f1422');
load(load_filename)

IAE_disturbio(end+1)=IAE;

subplot(3,1,1)
hold on
plot(Time(T_inicial:T_final)-30,rotspeed(T_inicial:T_final),'Color',cell2mat(colors(i)),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)

subplot(3,1,2)
hold on
plot(Time(T_inicial:T_final)-30,heta_out(T_inicial:T_final)*180/pi,'Color',cell2mat(colors(i)),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)


end
subplot(3,1,3)
plot(Time(T_inicial:T_final)-30,wind(T_inicial:T_final),'k','LineWidth',2)

% detalhes
subplot(3,1,1)
grid on
xlim([0 40])
legend(legenda_)
xlabel('tempo (s)')
ylabel('Velocidade de rotação (RPM)')

subplot(3,1,2)
grid on
xlim([0 40])
legend(legenda_)
xlabel('tempo (s)')
ylabel('pitch (graus)')

subplot(3,1,3)
grid on
xlim([0 40])
legend('Distúrbio')
xlabel('tempo (s)')
ylabel('Vento (m/s)')

% zoom 
figure()

T_inicial=(30/0.05);
T_final=(70/0.05);
for i=2:length(plot_filenames)
load_filename=strcat(cell2mat(plot_filenames(i)),'f1625');
load(load_filename)

hold on
plot(Time(T_inicial:T_final)-30,rotspeed(T_inicial:T_final),'Color',cell2mat(colors(i)),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)


end

grid on
legend(legenda_(2:length(plot_filenames)))
xlim([0 40])
xlabel('tempo (s)')
ylabel('Velocidade de rotação (RPM)')

%
IAE_ctrlstep=IAE_ctrlstep'
IAE_disturbio=IAE_disturbio'






%% Treat MLIFE stats

filenames_CPC_with_MLIFE={
    'ganho5mw_Td2o_10_05f1422htzgauto.mat'
    'ganho5mw_Td2o_5_15f1422htzgauto.mat'
    'ganho5mw_Td2o_5_30f1422htzgauto.mat'
    '02_down50_18_PI_Td2o_10_05_f1422htzgauto.mat'
    '02_down50_18_PI_Td2o_8_05_f1422htzgauto.mat'
    '02_down50_18_PI_Td2o_5_05_f1422htzgauto.mat'
    '02_down50_18_PI_Td2o_3_05_f1422htzgauto.mat'
    '02_down50_18_PI_Td2o_1_05_f1422htzgauto.mat'
    '02_down50_18_PI_Td2o_5_15_f1422htzgauto.mat'
    '02_down50_18_PI_Td2o_5_30_f1422htzgauto.mat'
    '02_down50_18_PI_Td2o_5_35_f1422htzgauto.mat'
    '02_down50_18_PI_Td2o_5_45_f1422htzgauto.mat'
    };

buffTUF=[];buffDEL=[];
for i=1:length(filenames_CPC_with_MLIFE)
   
    load(filenames_CPC_with_MLIFE{i})
        buffTUF=[buffTUF; timeUntilFailureDataTable{4,4}];
        buffDEL=[buffDEL; lifetimeDamageDataTable{4,4}];
    
end


buffTUF_inyears=buffTUF/60/60/24/365
buffDEL;













