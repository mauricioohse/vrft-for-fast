function add_to_quickPlot(nomecomposto,timeRange,j,listacomposto)
    load(nomecomposto)
    subplot(2,1,j)
    hold on
    plot(Time,rotspeed,'LineWidth',2)
    hold on
    xlim(timeRange)
    legend(listacomposto(:,j),'Interpreter','none')
    grid on
end