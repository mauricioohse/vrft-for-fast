%% script para analisar a oscilação com CL jonkman e o efeito dos filtros
clear all
close all

filenames={
    '008rpm_up100CL' % sem filtro
 '008rpm_up100CL_jonk'    %filtro jonkman
 '008rpm_up100CL_htzg'
}


load(cell2mat(filenames(1)))
quick_plot



for i=2:3
   
    load(cell2mat(filenames(i)))
    subplot(2,1,1)
    hold on
    plot(Time,rotspeed,'LineWidth', 2)
    hold on
end

legend(filenames, 'Interpreter', 'none')


xlim([240 250])
ylim('auto')

subplot(4,1,3)
xlim([240 250])
ylim('auto')
% ylim([12.09 12.121])

