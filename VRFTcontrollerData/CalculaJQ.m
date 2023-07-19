%% Calculo do erro de seguimento de referencia em resposta a distúrbio
% No caso de VRFT p seguimento de referencia, a referencia é constante
clear JQ IAE_jq

TIni=60/DT;  %Tempo inicial para plot, para cortar o transiente das cond iniciais
Tfim=90/DT;

if strcmp(VRFTWindChoose,'f1625')
    TIni=30/DT;  %Tempo inicial para plot, para cortar o transiente das cond iniciais
    Tfim=60/DT;
Ydref=12.1; % velocidade de rotação nominal
erroQref=rotspeed(TIni:Tfim)-Ydref;
JQ=(erroQref)'*(erroQref);

IAE_jq=sum(abs(rotspeed(TIni:Tfim)-Ydref));


end




