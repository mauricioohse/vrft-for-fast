% Codigo para escolher a Td utilizada no VRFT design



[Ts,isAnumber]=str2num(chooseTs);

if isAnumber
    % is a number
        Ts=str2num(chooseTs);
        polo1=4/Ts;
        Td1c=tf(polo1,[1 polo1 ]);
        Td=c2d(Td1c,0.05,'zoh');
else
    % is not a number
    if (strcmp(chooseTs(1:2),'2o'))
        TD2o_arr=sscanf(chooseTs,'2o_%d_%d');
    else
        disp('CONTROLADOR FORMATADO ERRADO - ERRO')
    end
        Mp=TD2o_arr(2)/100;
        Ts=TD2o_arr(1);
        designTd_secondOrder
end





