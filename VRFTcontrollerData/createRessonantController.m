% Controlador Vini
clear all

omega_121RPM=1.267;

Ac_R=[0 1 0
    -omega_121RPM^2 0 0
    0 0 0]


Bc_R=[0 
    1
    1]
Ka=[ -.11963 0.18288 -0.14462 0.07570 0.01285]

% Dc=[k2 kp_R]

save('C:\FAST\CertTest\IPCcontrollerData\IPCvini.mat')