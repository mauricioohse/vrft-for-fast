close all
clear all

plot_filenames={
    'ganho5mw'  % BESTS SO FAR
    'ganho5mw_Td2o_5_15'
    'ganho5mw_Td2o_5_30'
    '02_down50_18_PI_Td2o_5_15_' % menção honrosa
    '02_down50_18_PI_Td2o_5_30_'
    };


%% comparando todos

figure(1)



load_filename=strcat(cell2mat(plot_filenames(1)),'ctrl_step');
load(load_filename)
T_inicial=(30/0.05);
T_final=(60/0.05);


subplot(2,1,1)
hold on
plot(Time(T_inicial:T_final)-30,rotspeed(T_inicial:T_final),'b','LineWidth',2)
[Tdstep,tout]=lsim(Td,step_ref(T_inicial:T_final));
plot(tout,Tdstep+12.1,'b--','LineWidth',2)
xlim('auto')
grid on
subplot(2,1,2)
hold on
plot(Time(T_inicial:T_final)-30,heta_out(T_inicial:T_final)*180/pi,'LineWidth',2)
grid on

load_filename=strcat(cell2mat(plot_filenames(2)),'ctrl_step');
load(load_filename)
figure(1)
subplot(2,1,1)
hold on
plot(Time(T_inicial:T_final)-30,rotspeed(T_inicial:T_final),'r','LineWidth',2)
[Tdstep,tout]=lsim(Td,step_ref(T_inicial:T_final));
plot(tout,Tdstep+12.1,'r--','LineWidth',2)
xlim('auto')
subplot(2,1,2)
hold on
plot(Time(T_inicial:T_final)-30,heta_out(T_inicial:T_final)*180/pi,'r','LineWidth',2)

load_filename=strcat(cell2mat(plot_filenames(3)),'ctrl_step');
load(load_filename)
figure(1)
subplot(2,1,1)
hold on
plot(Time(T_inicial:T_final)-30,rotspeed(T_inicial:T_final),'g','LineWidth',2)
[Tdstep,tout]=lsim(Td,step_ref(T_inicial:T_final));
plot(tout,Tdstep+12.1,'g--','LineWidth',2)
xlim('auto')
subplot(2,1,2)
hold on
plot(Time(T_inicial:T_final)-30,heta_out(T_inicial:T_final)*180/pi,'g','LineWidth',2)


% load_filename=strcat(cell2mat(filenames(4)),'ctrl_step');
% load(load_filename)
% figure(1)
% subplot(2,1,1)
% hold on
% plot(Time(T_inicial:T_final)-30,rotspeed(T_inicial:T_final),'m','LineWidth',2)
% [Tdstep,tout]=lsim(Td,step_ref(T_inicial:T_final));
% plot(tout,Tdstep+12.1,'m--','LineWidth',2)

subplot(2,1,1)
xlim([0 30])
legend('C_b','Td C_b','C_1','Td C_1','C_2','Td C_2')
ylabel('Velocidade de rotação (RPM)')
xlabel('Tempo (s)')


subplot(2,1,2)
hold on
% plot(Time(T_inicial:T_final)-30,heta_out(T_inicial:T_final)*180/pi,'m','LineWidth',2)
legend('C_b','C_1','C_2')
ylabel('pitch (graus)')
xlabel('Tempo (s)')
xlim([0 30])

%% ao salto de vento
figure(8)

T_inicial=(30/0.05);
T_final=(70/0.05);

load_filename=strcat(cell2mat(plot_filenames(1)),'f1625');
load(load_filename)
subplot(3,1,1)
hold on
plot(Time(T_inicial:T_final)-30,rotspeed(T_inicial:T_final),'b','LineWidth',2)
xlim('auto')
grid on
subplot(3,1,2)
hold on
plot(Time(T_inicial:T_final)-30,heta_out(T_inicial:T_final)*180/pi,'LineWidth',2)
grid on


load_filename=strcat(cell2mat(plot_filenames(2)),'f1625');
load(load_filename)
figure(8)
subplot(3,1,1)
hold on
plot(Time(T_inicial:T_final)-30,rotspeed(T_inicial:T_final),'r','LineWidth',2)
xlim('auto')
grid on
subplot(3,1,2)
hold on
plot(Time(T_inicial:T_final)-30,heta_out(T_inicial:T_final)*180/pi,'r','LineWidth',2)
grid on


load_filename=strcat(cell2mat(plot_filenames(3)),'f1625');
load(load_filename)
figure(8)
subplot(3,1,1)
hold on
plot(Time(T_inicial:T_final)-30,rotspeed(T_inicial:T_final),'g','LineWidth',2)
xlim('auto')
grid on
subplot(3,1,2)
hold on
plot(Time(T_inicial:T_final)-30,heta_out(T_inicial:T_final)*180/pi,'g','LineWidth',2)
grid on

% load_filename=strcat(cell2mat(filenames(4)),'f1625');
% load(load_filename)
% figure(8)
% subplot(3,1,1)
% hold on
% plot(Time(T_inicial:T_final)-30,rotspeed(T_inicial:T_final),'m','LineWidth',2)
% xlim('auto')
% grid on
% subplot(3,1,2)
% hold on
% plot(Time(T_inicial:T_final)-30,heta_out(T_inicial:T_final)*180/pi,'m','LineWidth',2)
% grid on


subplot(3,1,3)
plot(Time(T_inicial:T_final)-30,wind(T_inicial:T_final),'b','LineWidth',2)
grid on
legend('distúrbio')
ylabel('Intensidade de vento (m/s)')
xlabel('Tempo (s)')

subplot(3,1,1)
xlim([0 40])
legend('C_b','C_1','C_2')
ylabel('Velocidade de rotação (RPM)')
xlabel('Tempo (s)')

subplot(3,1,2)
xlim([0 40])
legend('C_b','C_1','C_2')
ylabel('Pitch (graus)')
xlabel('Tempo (s)')

%% salto comparando com zoom

figure(9)

T_inicial=(30/0.05);
T_final=(70/0.05);

%%
load_filename=strcat(cell2mat(plot_filenames(2)),'f1625');
load(load_filename)
figure(9)
hold on
plot(Time(T_inicial:T_final)-30,rotspeed(T_inicial:T_final),'r','LineWidth',2)
xlim('auto')
grid on
%%

load_filename=strcat(cell2mat(plot_filenames(3)),'f1625');
load(load_filename)
figure(9)
hold on
plot(Time(T_inicial:T_final)-30,rotspeed(T_inicial:T_final),'g','LineWidth',2)
xlim('auto')
grid on


% load_filename=strcat(cell2mat(filenames(4)),'f1625');
% load(load_filename)
figure(9)
hold on
% plot(Time(T_inicial:T_final)-30,rotspeed(T_inicial:T_final),'m','LineWidth',2)
% xlim('auto')
grid on





xlim([0 40])
legend('C_1','C_2')
ylabel('Velocidade de rotação (RPM)')
xlabel('Tempo (s)')











