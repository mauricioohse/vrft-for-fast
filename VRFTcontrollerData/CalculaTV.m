

% load 008_up100BL_18_PI_Td2o_5_15ctrl_step



t_ini_ensaio=step_ctrl_time/DT;
t_fim_ensaio=t_ini_ensaio+30/DT;
heta_ensaio=heta_out(t_ini_ensaio:t_fim_ensaio);
TV=0;
for i_TV=1:(length(heta_ensaio)-1)
    TV=TV+(heta_ensaio(i_TV+1)-heta_ensaio(i_TV))^2;
end
TV=TV*180/pi/DT;

% disp(TV)