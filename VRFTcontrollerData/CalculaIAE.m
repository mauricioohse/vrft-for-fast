%% Script para calcular crit�rio IAE

clear IAE

if ~exist('step_ctrl_time')
    disp('N�O H� TEMPO INICIAL P CALCULO DO IAE, VALOR t=60 PADR�O SELECIONADO')
     step_ctrl_time=30;
end


    tini_iae=step_ctrl_time/DT;
    tfim_iae=(step_ctrl_time+30)/DT;

    IAE=sum(abs(rotspeed(tini_iae:tfim_iae)-ref(tini_iae:tfim_iae)));
    ITAE=sum(abs(rotspeed(tini_iae:tfim_iae)-ref(tini_iae:tfim_iae))'*(Time(tini_iae:tfim_iae)-Time(tini_iae)));
    Jy=sum((rotspeed(tini_iae:tfim_iae)-ref(tini_iae:tfim_iae))'*(rotspeed(tini_iae:tfim_iae)-ref(tini_iae:tfim_iae)));
    
    if exist('TipDxb1')
    IAE_TipDxb1=sum(abs(TipDxb1(tini_iae:tfim_iae)-mean(TipDxb1(tini_iae:tfim_iae))));
    end
    %     maxTheta=max(diff


% if ~exist('step_ref') %strcmp(VRFTWindChoose,'f1625')||strcmp(VRFTWindChoose,'LPV_f1625')
%  % testes de dist�rbio
% 
%     tini_iae=step_ctrl_time/DT;
%     tfim_iae=(step_ctrl_time+30)/DT;
% %     step_ref=0*zeros(tfim_iae,1);
%     IAE=sum(abs(rotspeed(tini_iae:tfim_iae)-12.1));
% else % testes ctrl step -
%     tini_iae=step_ctrl_time/DT;
%     tfim_iae=(step_ctrl_time+30)/DT;
%     IAE=sum(abs(rotspeed(tini_iae:tfim_iae)-step_ref(tini_iae:tfim_iae)-12.1));
% %     settlingTime=stepinfo(Time(tini_iae:tfim_iae),rotspeed(tini_iae:tfim_iae),12.7,'SettlingTimeThreshold',0.05)
% end



