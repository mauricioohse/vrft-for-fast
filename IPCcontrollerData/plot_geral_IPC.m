% Funcao para plotagem das variaveis de interesse de uma simulaçao FAST

close all

%% Plota as saídas de interesse
figure(1)
hold on
%variaveis de interesse: Velocidade de rotacao do motor 'LSSTipVxa', angulo
%das pás, derivada do angulo das pás, deflexao vertical da torre, vento

subplot(3,2,1)
plot(Time,rotspeed)  %'LSSTipVxa'
xlim([1 TMax])
ylim('auto')
legend('Velocidade rotor LSStip')


subplot(3,2,2)
plot(Time,heta_out_3b*180/pi) %pitch (em graus)
xlim([1 TMax])
ylim('auto')
legend('theta (graus)')

subplot(3,2,4)
plot(Time(1:(length(Time)-1)),diff(heta_out*180/pi)/DT)  %diff(vetor)/step = derivada do vetor, tem n-1 componentes
xlim([1 TMax])
ylim('auto')
legend('derivada theta (graus)')

if exist('deflex')
subplot(3,2,3)
plot(Time,deflex) %deflexao vertical strmatch('YawBrTDxt',OutList) da torre
xlim([1 TMax])
ylim('auto')
legend('deflex tower (m)')
end 
subplot(3,3,8)
plot(Time,wind) % vento
xlim([1 TMax])
ylim('auto')
legend('Vento horizontal (m/s)')

subplot(3,3,7)
plot(Time,TipDxb1)  %diff(vetor)/step = derivada do vetor, tem n-1 componentes
xlim([1 TMax])
ylim('auto')
legend('blade tip deflex (m/s)')



if exist('IAE')
    subplot(3,3,9)
    plot(Time(tini_iae:tfim_iae),abs(rotspeed(tini_iae:tfim_iae)-ref(tini_iae:tfim_iae))) % deflexao pá
    xlim([1 TMax])
    ylim('auto')
    legend(' IAE crit (rpm)')
end
% subplot(3,3,9)
% plot(Time,q_out(:,16)) % deflexao pá
% xlim([1 TMax])
% ylim('auto')
% legend(' Deflexao blade1(m)')

% %% plota as variaveis de estado
% 
% figure(2)
% hold on
% % q_out = variaveis de estado
% % qd_out= derivada 
% state_order=[7 13 16 19 22];
% state_DOF=['DOF_TFA1' 'DOF_GeAz' 'DOF_BF(1,1)' 'DOF_BF(1,2)' 'DOF_BF(1,3)'];
% state_name=[{'Tower Bend'} {'Rotor Disp'} {'B1 fwise bend'} {'B2 fwise bend'} {'B2 fwise bend'}];
% state_dotname=[{'der Tower Bend'} {'der Rotor Disp'} {'der B1 fwise bend'} {'der B2 fwise bend'} {'der B2 fwise bend'}];
% % Deflex e RotDisp
% n=1;
% for m=[1 3]
% subplot(3,2,m)
% plot(Time,q_out(:,state_order(n)));
% legend(state_name(n));
% xlim([1 TMax])
% ylim('auto')
% n=n+1;
% end
% 
% % flapwise bend 1 a 3
% subplot(3,2,5)
% for n=3:5
% plot(Time,q_out(:,state_order(n)));
% legend(state_name(n));
% xlim([1 TMax])
% ylim('auto')
% end
% 
% % Derivadas
% 
% % Deflex e RotDisp
% n=1;
% for m=[2 4]
% subplot(3,2,m)
% plot(Time,qdot_out(:,state_order(n)));
% legend(state_name(n));
% xlim([1 TMax])
% ylim('auto')
% n=n+1;
% end
% 
% % flapwise bend 1 a 3
% subplot(3,2,6)
% for n=3:5
% plot(Time,qdot_out(:,state_order(n)));
% legend(state_name(n));
% xlim([1 TMax])
% ylim('auto')
% end
% 
