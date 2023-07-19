close all
clear all

plot_filenames={
    'ganho5mw_Td2o_5_15LPV_'
    'ganho5mw_Td2o_5_30LPV_'  % BESTS SO FAR
%     'ganho5mw_Td2o_5_30'
%     '02_down50_18_PI_Td2o_5_15_' % menção honrosa
    '02_down50_18_PI_Td2o_5_15_'
    '02_down50_18_PI_Td2o_5_30_'
    };
legenda_={'C_{b1}','C_{b2}','C_{5}','C_{6}'};
colors={[0 0 0], [.2 .2 .2], [.2 .2 .2], [.6 .6 .6]};
linestyles={':','-.','-','-'};

%%
figure()
IAE_ctrlstep=[];
for i=1:length(plot_filenames)
load_filename_ctrlstep{i}=strcat(cell2mat(plot_filenames(i)),'ctrl_step');
load(load_filename_ctrlstep{i})
T_inicial=(59/DT);
T_final=(90/DT);
IAE_ctrlstep(end+1)=IAE;

subplot(2,1,1)
plot(Time(T_inicial:T_final)-59.9,rotspeed(T_inicial:T_final),'Color',cell2mat(colors(i)),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
hold on
subplot(2,1,2)
hold on
plot(Time(T_inicial:T_final)-59.9,heta_out(T_inicial:T_final)*180/pi,'Color',cell2mat(colors(i)),'LineStyle',cell2mat(linestyles(i)),'LineWidth',2)
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

%% Agora ao distúrbio
plot_filenames={
    'ganho5mw_Td2o_5_15LPV_'
    'ganho5mw_Td2o_5_30LPV_'
%     'ganho5mw_Td2o_5_30'
%     '02_down50_18_PI_Td2o_5_15_' % menção honrosa
    '02_down50_18_PI_Td2o_5_15_'
    '02_down50_18_PI_Td2o_5_30_'
    };
figure()
T_inicial=(30/0.05);
T_final=(60/0.05);
IAE_disturbio=[];load_filename_dist=[];
for i=1:length(plot_filenames)
load_filename_dist{i}=strcat(cell2mat(plot_filenames(i)),'f1422');
load(load_filename_dist{i})

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
xlim([0 30])
legend(legenda_)
xlabel('tempo (s)')
ylabel('Velocidade de rotação (RPM)')

subplot(3,1,2)
grid on
xlim([0 30])
legend(legenda_)
xlabel('tempo (s)')
ylabel('pitch (graus)')

subplot(3,1,3)
grid on
xlim([0 30])
legend('Distúrbio')
xlabel('tempo (s)')
ylabel('Vento (m/s)')

%% zoom 
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

%%
IAE_ctrlstep=IAE_ctrlstep'
IAE_disturbio=IAE_disturbio'


%% dados da tabela 6 comparaçao entre melhores controladores

nomes_controladores={'cb1','cb2','c5','c6'}
file_controladores={'ganho5mw_Td2o_5_15LPV_'
    'ganho5mw_Td2o_5_30LPV_'
    '02_down50_18_PI_Td2o_5_15_'
    '02_down50_18_PI_Td2o_5_30_'}

windnames={'f1422','ctrl_step'};

buffIAE2=[]; 
for j=1:length(windnames)
for i=1:length(file_controladores)
    
    nomecomposto=strcat(cell2mat(file_controladores(i)),cell2mat(windnames(j)));
    load(nomecomposto)
    buffIAE2(i,j)=IAE;
    buffC(i,j)=tf(numD,denD,DTcontroller);
    if 0
    quick_plot
    end
end
end

buffC
buffIAE2


%% Tabela 3: IAE para diferentes pontos de operação






