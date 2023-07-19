clear all
close all

loadfilenames={
    '02_up50_18',
    '02_up50_22',
    '02_down50_18',
    '02_down50_22'
%     '01_down100_22'
    }


load(cell2mat(loadfilenames(1)))
fh=figure(5);

TInicial=Time(1);  %Tempo inicial para plot, para cortar o transiente das cond iniciais
TFinal=Time(end);

hold on
% subplot(2,1,1)
hold on
plot(Time-Time(1),rotspeed,'LineWidth',2)  %'LSSTipVxa'
xlim([TInicial TFinal])
ylim('auto')
ylim('auto')
ylabel('velocidade do rotor (RPM)')
xlabel('Tempo (s)')
grid on


% subplot(2,1,2)
% hold on
% plot(Time-Time(1),heta_out(:,1)*180/pi,'LineWidth',2)
% xlim([TInicial TFinal])
% ylim('auto')
% ylabel('Pitch (Graus)')
% xlabel('Tempo (s)')
% grid on

%%
load(cell2mat(loadfilenames(2)))

fh=figure(5);

TInicial=Time(1);  %Tempo inicial para plot, para cortar o transiente das cond iniciais
TFinal=Time(end);

hold on
% subplot(2,1,1)
hold on
plot(Time-Time(1),rotspeed,'LineWidth',2)  %'LSSTipVxa'
xlim([0 250])
ylim('auto')
ylim('auto')
ylabel('velocidade do rotor (RPM)')
xlabel('Tempo (s)')
grid on


% subplot(2,1,2)
% hold on
% plot(Time-Time(1),heta_out(:,1)*180/pi,'LineWidth',2)
% xlim('auto')
% ylim('auto')
% ylabel('Pitch (Graus)')
% xlabel('Tempo (s)')
% grid on





%%
load(cell2mat(loadfilenames(3)))

fh=figure(5);

TInicial=Time(1);  %Tempo inicial para plot, para cortar o transiente das cond iniciais
TFinal=Time(end);

hold on
% subplot(2,1,1)
hold on
plot(Time-Time(1),rotspeed,'LineWidth',2)  %'LSSTipVxa'
% xlim([0 250])
ylim('auto')
ylim('auto')
ylabel('velocidade do rotor (RPM)')
xlabel('Tempo (s)')
grid on


load(cell2mat(loadfilenames(4)))

fh=figure(5);

TInicial=Time(1);  %Tempo inicial para plot, para cortar o transiente das cond iniciais
TFinal=Time(end);

hold on
% subplot(2,1,1)
hold on
plot(Time-Time(1),rotspeed,'LineWidth',2)  %'LSSTipVxa'
% xlim([0 250])
ylim('auto')
ylim('auto')
ylabel('velocidade do rotor (RPM)')
xlabel('Tempo (s)')
grid on


% 
% subplot(2,1,2)
% hold on
% plot(Time-Time(1),heta_out(:,1)*180/pi,'LineWidth',2)
% xlim('auto')
% ylim('auto')
% ylabel('Pitch (Graus)')
% xlabel('Tempo (s)')
% grid on

%%
% subplot(2,1,1)
legend({'exp. 1','exp. 2','exp. 3','exp. 4'})
xlim([0 300])
% subplot(2,1,2)
% legend('14 m/s','18 m/s','22 m/s')
% xlim('auto')