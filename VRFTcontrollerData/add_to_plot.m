




if ~exist('used2_filenames')
    used2_filenames{1}=plot2_filename;
else
    used2_filenames{end+1}=plot2_filename;
end


fh=figure(1);

hold on
subplot(3,2,1)
hold on
plot(Time,rotspeed,'LineWidth',2)  %'LSSTipVxa'
xlim([TInicial TFinal])
ylim('auto')
ylim('auto')
legend(used2_filenames(1:end), 'Interpreter', 'none')
ylabel('velocidade do rotor (RPM)')
xlabel('Tempo (s)')
grid on


subplot(3,2,3)
hold on
plot(Time,heta_out(:,1)*180/pi,'LineWidth',2)
xlim([TInicial TFinal])
ylim('auto')
legend(used2_filenames(1:end), 'Interpreter', 'none')
ylabel('Pitch (Graus)')
xlabel('Tempo (s)')
grid on


if exist('TIni')
    subplot(3,2,6)
    hold on
    plot(Time(TIni:Tfim),erroSQ,'LineWidth',2)
    grid on
    xlim([TInicial TFinal])
    % ylim([12 24])
    ylabel('erroSQ')
    xlabel('Tempo (s)')
    legend(used2_filenames(1:end), 'Interpreter', 'none')
end

if exist('Td')
    
    [Tdstep,tout]=lsim(Td,ref-12.1);
    
    subplot(3,2,5)
    hold on
    plot(tout,Tdstep,'LineWidth',2)
    ylabel('referemce response on TD(RPM)')
    xlabel('Tempo (s)')
    xlim([TInicial TFinal])
    legend(used2_filenames(1:end), 'Interpreter', 'none')
    grid on
end




fh.Position = [1 41 1366 651];