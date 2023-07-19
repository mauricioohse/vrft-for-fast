%% Codigo que analisa todas as simulações da pasta
% e obtem o melhor JQ, JY e o indice dela
clear all
close all


all_namefiles=dir('C:\Fast\CertTest\VRFTcontrollerData\simulacoes\*.mat');


for i=1:length(all_namefiles)
    
    load(all_namefiles(i).name)
    
    if exist('JQ')&&JQ~=0
        all_buffJQ(i)=JQ;
    else
        all_buffJQ(i)=9999;
    end
    
    if exist('Jy')&&Jy~=0
        all_buffJY(i)=Jy;
    else
        all_buffJY(i)=9999;
    end
    clearvars -except all_namefiles all_buffJQ all_buffJY
    
end

for i=1:length(all_buffJQ)
    if(all_buffJQ(i)==0)
        all_buffJQ(i)=99999;
    end
    if(all_buffJY(i)==0)
        all_buffJY(i)=99999;
    end
end

[minJQ,iJQ]=min(all_buffJQ)
[minJY,iJY]=min(all_buffJY)
