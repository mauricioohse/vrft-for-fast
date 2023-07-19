clear all
close all

loadfilenames={
    '02_down100_14',
    '02_down50_18',
    '02_down50_22'
    }
legenda_={'14 m/s','18 m/s','22 m/s'};
cores_={[1 0 1], [1 0 0], [0 0 1]};
% [0.4940 0.1840 0.5560],[0.8500 0.3250 0.0980] , [0 0.4470 0.7410]
linhas_={':','-.','-'};

fh2=figure(6);

for i=1:length(loadfilenames)
    hold on
    load(cell2mat(loadfilenames(i)))
    cor=cell2mat(cores_(i));
    linha=cell2mat(linhas_(i));
    subplot(2,1,1)
    plot(Time-Time(1),rotspeed,'Color',cor,'LineStyle',linha,'LineWidth',2) 
    hold on
    
    subplot(2,1,2)
    plot(Time-Time(1),heta_out*180/pi,'Color',cor,'LineStyle',linha,'LineWidth',2)
end
subplot(2,1,1)
grid on
xlim([0 300])
legend((legenda_))
ylabel('velocidade do rotor (RPM)')
xlabel('Tempo (s)')


subplot(2,1,2)
grid on
xlim([0 300])
ylim([6 22])
legend((legenda_))
ylabel('pitch (graus)')
xlabel('Tempo (s)')
