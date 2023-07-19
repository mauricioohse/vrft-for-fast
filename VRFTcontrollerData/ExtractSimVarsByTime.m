% needed input: t_ini:t_fim

heta_out=heta_out(t_ini:t_fim);
rotspeed=rotspeed(t_ini:t_fim);
heta_out_sOp=heta_out_sOp(t_ini:t_fim);
rotspeed_sOp=rotspeed_sOp(t_ini:t_fim);
Time=Time(t_ini:t_fim);
wind=wind(t_ini:t_fim);


rotspeed_sOp_jonk=lsim(filter_jonk,rotspeed_sOp,Time);
rotspeed_sOp_HTZG=lsim(filter_HTZG,rotspeed_sOp,Time);