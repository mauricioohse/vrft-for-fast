%% quickly plot current 
fh_quickplot=figure();

if ~exist('step_ctrl_time')
    step_ctrl_time=0;
end

xrange=[step_ctrl_time-1 TMax];

subplot(2,1,1)
plot(Time,rotspeed,'r','LineWidth',2);
legend('rotspeed')
grid on
hold on
xlim(xrange)

subplot(4,1,3)
plot(Time,heta_out*180/pi,'r','LineWidth',2);
grid on
ylim('auto')
hold on
legend('pitch')
xlim(xrange)


subplot(4,1,4)
plot(Time,wind,'b','LineWidth',2);
grid on
legend('vento')
xlim(xrange)

