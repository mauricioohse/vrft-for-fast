%% Identifying W(z)
% load 08_up100BL_14

u=heta_out-heta_out(1);
Ts=DT;


%% estimate Phi_u
% SYS = Phi_u/Phi_e = Phi_u/var(e)
% => Phi_u = SYS*var(e)
M = 10;
% SYS = arx([u,[1; 0*u(1:end-1)]],[M,1,M+1]);
SYS = arx([u, 0*u],[M,1,M+1]);

% Estimating error using Phi_u^-1
num = polydata(SYS);
den = [1 zeros(1,M)];
invPhi_u = tf(num,den,Ts);



%% estimating Phi_r
% Phi_r is a 12.1 constant step2
% Phi_r= 12.1*Ts*(z/(z-1))
Phi_r=(12.1*Ts)*tf([1 0],[1 -1],Ts);

W = Phi_r*invPhi_u;

% Initializing L(z) filter
L = Td*(1-Td)*W;
L=minreal(L);

Ldefault = minreal(Td*(1-Td));


%% se quiser plotar

% close all
% figure()
% % impulse(L)
% % legend L
% % figure()
% impulse(invPhi_u^-1)
% legend Phi_u