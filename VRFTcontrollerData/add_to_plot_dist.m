



if ~exist('used3_filenames')
    used3_filenames{1}=plot2_filename;
else
    used3_filenames{end+1}=plot2_filename;
end

fh=figure(1);

hold on
subplot(3,2,2)
hold on
plot(Time,rotspeed,'LineWidth',2)  %'LSSTipVxa'
xlim([TInicial TFinal])
ylim('auto')
ylim('auto')
legend(used3_filenames(1:end), 'Interpreter', 'none')
ylabel('velocidade do rotor (RPM)')
xlabel('Tempo (s)')
grid on



subplot(3,2,4)
hold on
plot(Time,heta_out(:,1)*180/pi,'LineWidth',2)
xlim([TInicial TFinal])
ylim('auto')
legend(used3_filenames(1:end), 'Interpreter', 'none')
ylabel('Pitch (Graus)')
xlabel('Tempo (s)')
grid on

%% Possivelmente colocar erro de seguimento ao disturbio em vez de erroSQ 
% subplot(3,2,6)
% hold on
% plot(Time,heta_out(:,1)*180/pi,'LineWidth',2)
% xlim([TInicial TFinal])
% ylim('auto')
% legend(used_filenames(1:end), 'Interpreter', 'none')
% ylabel('Pitch (Graus)')
% xlabel('Tempo (s)')
% grid on
