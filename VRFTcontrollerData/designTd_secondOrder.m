%% Script para calcular função de transferencia de segunda ordem
% a partir de overshoot e tempo de acomodação



%% Definir desempenho
if ~exist('Mp')
    Mp=0.05; % maximo overshoot, em %
    Ts=10;   % settling time, em (s)
    disp('NÃO FOI SELECIONADO MP e TS PARA TD DE SEGUNDA ORDEM - VALORES BASELINE SELECIONADOS')
end





%% Cap. 5 ogata

sigma=4/Ts;
Wd= -sigma*pi/(log(Mp));
Wn=sqrt(Wd^2+sigma^2);
xi=sigma/Wn;

% xi2=sqrt(log(Mp)^2/(pi^2+log(Mp)^2))

%% Constroi a Tf (no caso Dt=0.05)

Tdc=tf([Wn^2],[ 1 2*xi*Wn Wn^2]);
Td=c2d(Tdc,0.05);


%% Td ganho5mw (5mw pagina 22)
% Ts = 10, Mo=5
% figure()
% Wn=0.6;
% epsilon=0.7;
% Td5mw=tf([Wn^2],[ 1 2*epsilon*Wn Wn^2]);
% figure()
% step(Td5mw)

% testando um negocinho
% DT=0.05;
% p1=exp(DT*(-xi * Wn + Wn * sqrt(xi^2-1)))
% p2=exp(DT*(-xi * Wn - Wn * sqrt(xi^2-1)))
% 
% z=tf('z')
% 
% Tdz=(1-p1-p2+p1*p2)/(z^2-(p1+p2)*z+p1*p2)

