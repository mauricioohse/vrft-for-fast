clear all
close all

loadfilenames={
    '02_down100_14',
    '02_down50_18',
    '02_down50_22'
    }
legenda_={'14 m/s','18 m/s','22 m/s'};
cores_={[ 0 0 0], [0.2 0.2 0.2], [0.6 0.6 0.6]};
linhas_={':','-.','-'};

fh2=figure(6);

for i=1:length(loadfilenames)
    hold on
    load(cell2mat(loadfilenames(i)))
    cor=cell2mat(cores_(i));
    linha=cell2mat(linhas_(i));
    plot(Time-Time(1),rotspeed,'Color',cor,'LineStyle',linha,'LineWidth',2) 
end
grid on
xlim([0 300])
legend((legenda_))
ylabel('velocidade do rotor (RPM)')
xlabel('Tempo (s)')

