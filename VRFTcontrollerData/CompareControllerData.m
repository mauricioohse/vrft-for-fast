%% codigo para comparar controladores e Tds
clear all
nome_dados_controladores={};


arr_Ts={'16','8','4','2','1'};

% monta nomes PI
base1={'18PI_L_','18PID_L_'};
base2='up_';
j=1;
% base2='down';
for i=1:length(arr_Ts)
    for j=1:length(base1)
        base1str=cell2mat(base1(j));
        nome_dados_controladores(i,j)=strcat(base1str,base2,'Td',arr_Ts(i),'_');
    end
end
% nome_dados_controladores={
%     '18PI_L_up_Td1_',   '18PID_L_up_Td1_'
%     '18PI_L_up_Td3_',   '18PID_L_up_Td1_'
%     '18PI_L_up_Td4_',   '18PID_L_up_Td1_'
%     '18PI_L_up_Td5_',   '18PID_L_up_Td1_'
%     '18PI_L_up_Td6_',   '18PID_L_up_Td1_'
%     '18PI_L_up_Td7_',   '18PID_L_up_Td1_'}


tabela_controladores=tf();

for i=1:length(nome_dados_controladores)
    for j=1:length(base1)
        load(cell2mat(nome_dados_controladores(i,j)));
        tabela_controladores(i,j)=C;
    end
end

nome_dados_controladores
tabela_controladores