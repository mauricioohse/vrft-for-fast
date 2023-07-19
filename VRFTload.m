%% Script para carregar dados VRFT.
clear all
% Uso - chamar esse script dando um valor a seguinte variavel
if ~exist('VRFTdataname')
    VRFTdataname='VRFTdataFew2_22.mat';
    disp('atencao: nao foi escolhido dataset para aplicaçao do VRFT - dados default selecionado')
end
% 'VRFTdata.mat'
% E escolher VRFTdataPontop=14, 18 ou 22 para escolher o ponto de operaçao
% (to do)

VRFTdataname
pause(.5)
load(VRFTdataname)




%% Chama script de VRFT 
VRFTex3_1



















%% Ediçao da data, pra salvar só o que precisa
% 
% save('VRFTdataFew2','rotspeed','heta_out','wind','Time')
% clear all
% load('VRFTdataFew2')
% 
% begin=751/0.05;
% final=1049/0.05;
% rotspeed=rotspeed(begin:final);
% heta_out=heta_out(begin:final);
% wind=wind(begin:final);
% Time=Time(begin:final);
% save('VRFTdataFew2_18')
% rotspeed=rotspeed(50/0.05:240




%% Plot data usada
% load('VRFTdataFew2_22')
% 
% close all
% figure(10)
% hold on
% %variaveis de interesse: Velocidade de rotacao do motor 'LSSTipVxa', angulo
% %das pás, derivada do angulo das pás, deflexao vertical da torre, vento
% 
% subplot(2,1,1)
% plot(Time,rotspeed)  %'LSSTipVxa'
% 
% ylim('auto')
% legend('Velocidade rotor LSStip')
% 
% 
% subplot(2,1,2)
% plot(Time,heta_out*180/pi) %pitch (em graus)
% 
% ylim('auto')
% legend('theta (graus)')
