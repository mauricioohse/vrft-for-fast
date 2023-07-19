%% script para criar o filtro de medição do 5mw p.17 (28 pdf)
% é criado em espaço de estado e depois convertido p função de transf.
clear all
close all


Ts=0.05; % sample time
fc=0.25; % 1 quarto da frequencia das pás

alpha=exp(-2*pi*Ts*fc)

A=alpha;
B=1-alpha;
C=alpha;
D=1-alpha;

FilterSS=ss(A,B,C,D)
% [num,den]=ss2tf(A,B,C,D)
FilterZ=tf(FilterSS)

w0=2*pi*fc;
f1order=tf(w0,[1 w0])

options = bodeoptions;
options.FreqUnits = 'Hz'; % or 'rad/second', 'rpm', etc.

WMIN=0.01*2*pi;
WMAX=1*2*pi;
bode(FilterZ,{WMIN,WMAX},options)

figure()
bode(f1order,{WMIN,WMAX},options)


numFilterJonk = w0 ;
denFilterJonk = [1 w0];
Filter_tf_jonk=f1order

%%
saveFolder='C:\FAST\CertTest\VRFTcontrollerData\';
name='FilterDataJonk'
save(strcat(saveFolder,name),'numFilterJonk','denFilterJonk','Filter_tf_jonk')


