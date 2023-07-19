%% calcula JY a partir da simulação feita
clear Jy IAE_jy


if ~exist('DTcontroller')
    DTcontroller=0.05;
end

        Ts=16;
        polo1=4/Ts;
        Td1c=tf(polo1,[1 polo1 ]);
        Td16=c2d(Td1c,DTcontroller,'zoh');
        
if ~exist('Td')
    Td=Td16;
end

%% Caso Td

TIni=30/DT;  %Tempo inicial para plot, para cortar o transiente das cond iniciais
Tfim=Time(end)/DT;


Yd=lsim(Td,step_ref(TIni:Tfim));
rotspeed_sOp=rotspeed(TIni:Tfim)-12.1;
heta_out_sOp=heta_out-14.92*pi/180;
erroSQ=rotspeed_sOp-Yd;
Jy=(erroSQ)'*(erroSQ);
IAE_jy=sum(abs(rotspeed_sOp-step_ref(TIni:Tfim)));

if ~exist('flag_auto_design')
    fh=figure();
    subplot(2,1,1)
    plot(Time(TIni:Tfim),erroSQ,'LineWidth',2)
    grid
    legend('erro Y-Yd')
    xlim([Time(TIni) Time(Tfim)])
    
    
    subplot(2,1,2)
    hold on
    plot(Time(TIni:Tfim),rotspeed_sOp,'LineWidth',2)
    plot(Time(TIni:Tfim),Yd,'LineWidth',2)
    legend('y','yd')
    grid
    xlim([Time(TIni) Time(Tfim)])
    
    fh.Position = [1 41 1366 651];
end
Jy
%% Caso Erro


Ydref=step_ref(TIni:Tfim);
erroref=rotspeed_sOp-Ydref;
erroSQref=(erroref)'*(erroref);



