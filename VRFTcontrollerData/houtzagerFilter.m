%% codigo para gerar o filtro e controlador baseline do houtzager
clear all
close all


%% low pass filter

w=10; % ~1.6 Hz
xi=1;
tf_LPF=tf(w^2,[1 2*xi*w w^2])


%% notch filter A

w=3.8; % ~0.6 Hz Hz
xi1=0.01;
xi2=0.15;
tf_NFA=tf([1 2*xi1*w w^2],[1 2*xi2*w w^2])

%% notch filter B

w=8.2; % ~1.3 Hz Hz
xi1=0.01;
xi2=0.2;
tf_NFB=tf([1 2*xi1*w w^2],[1 2*xi2*w w^2])


%% Multiply filters and obtain [num,den]

Filter_tf=tf_LPF*tf_NFA*tf_NFB

[numFilter,denFilter]=tfdata(Filter_tf)
numFilter=cell2mat(numFilter)
denFilter=cell2mat(denFilter)

%%
save('C:\FAST\CertTest\VRFTcontrollerData\FilterHTZG','numFilter','denFilter','Filter_tf')





%% controlador houtzager

clear all

kp=0.0135;
ki=0.00453;
DTcontroller=0.05;


sys=pid(kp,ki,0,0,DTcontroller); % euler forward
sys_c=pid(kp,ki,0,0)
[numD,denD]=tfdata(sys);
[numDc,denDc]=tfdata(sys_c);

numD=-cell2mat(numD);
denD=cell2mat(denD);
DTcontroller=0.05;
C=tf(numD,denD,DTcontroller)

numDc=-cell2mat(numDc);
denDc=cell2mat(denDc);
Cc=tf(numD,denD)

p=cell2mat(tfdata(C))';
p2=[kp ki*DTcontroller-kp]';
        C_=[tf([1 0],[1 -1],DTcontroller);
            tf([1],[1 -1],DTcontroller)];
Cp=minreal(p'*C_)
Cp2=minreal(p2'*C_)

% td baseline (na verdade esse controlador não possui Td)
Td=tf([0 0.4437    0.4376]*1e-3, [1.0000   -1.9580    0.9589],0.05);

        savefolder='C:\FAST\CertTest\VRFTcontrollerData\';
        savefilename='ganhoHTZG';
    save(strcat(savefolder,savefilename),'C','numD','denD','Td','DTcontroller','p')



%% compara C e Cc







