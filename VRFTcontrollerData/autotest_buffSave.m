% script para salvar as variaveis de uma run de forma organizada



saved_names(end+1)={savefilename};

if exist('JQ')
    buff_JQ(end+1)=JQ;
else
    buff_JQ(end+1)=9999;
end

if exist('IAE_jq')
    buff_IAEjq(end+1)=IAE_jq;
else
    buff_IAEjq(end+1)=9999;
end

if exist('Jy')
    buff_JY(end+1)=Jy;
else
    buff_JY(end+1)=9999;
end

if exist('IAE_jy')
    buff_IAEjy(end+1)=IAE_jy;
else
    buff_IAEjy(end+1)=9999;
end

if exist('IAE')
    buff_IAE(end+1)=IAE;
else
    buff_IAE(end+1)=9999;
    disp('Erro no buff IAE - deveria existir valor')
end

clear JQ IAE_jq Jy IAE_jy IAE

% buff_JQ(i,j)=JQ;
% buff_IAEjq(i,j)=IAE_jq;
% buff_JY(i,j)=Jy;
% buff_IAEjy(i,j)=IAE_jy;
% buff_IAE(end+1)=IAE;