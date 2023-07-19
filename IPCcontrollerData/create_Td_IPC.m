% codigo para gerar TD seguindo TCC do guilherme beal
% Td= (z*k1+z^2*k2)/(z-p)^3
% Td deve ter phase = 0 e magnitude 1 em z=exp(j*omega_projeto)
clear all
close all

DTtd=0.05;

polos=0.8;
w=1.26;
z=exp(j*w*DTtd);
Tdabs=abs(1/(z-polos)^3);
Tdang=angle(1/(z-polos)^3);
aux=Tdabs^-1*exp(-j*Tdang);
A=[real(z) real(z^2);
   imag(z) imag(z^2);];
b=[real(aux); imag(aux)];
k=A^-1*b;

k1=k(1);
k2=k(2);
% k1=0.9799
% k2=k1;

check_cmplx=(z*k1+z^2*k2)/(z-polos)^3
ang=angle(check_cmplx)
rho=abs(check_cmplx)

T1=zpk([0],[polos polos polos],1,DTtd);
T2=tf([ k2 k1],[1],DTtd);

Td=T1*T2
[mag,phase] = mag_phase(Td,z)
figure()
bode(Td,{10^-1 10^2});

%% testa Td na frequencia
t=0:DTtd:1000;
sinal=sin(w*t);
saida=lsim(Td,sinal,t);

figure()
plot(t,saida)


%%

% z=tf('z',DTtd);
% Td_teste= 0.189*z*(z-0.9895)*(z^2-1.972*z+0.9734)*(z^2-1.972*z+0.9734)*(z^2-1.972*z+0.9734)/(z-0.915)^9
% 
% figure()
% bode(Td_teste,{ 10^0 10^5})

if 0
    
    savename='Td1';
    filename=strcat('C:\FAST\CertTest\IPCcontrollerData\Tddata\',savename);
    VARIABLES={'Td','k1','k2'};
    save(filename,VARIABLES{:})
    
end



%% Caso ressPI: TD(z=1)=1 e TD(z=e^jwts)=1

clear all

DTtd=0.05;
p=0.8;
w=1.26;
z=exp(j*w*DTtd);
aux= (z-p)^3;

A=[ 1   1   1;
    1 real(z) real(z^2);
   0 imag(z) imag(z^2);];
b=[(1-p)^3;real(aux); imag(aux)];

k=A^-1*b


Td=tf([k(3) k(2) k(1)],1,DTtd)*zpk([],[p p p],1,DTtd);
zero(Td)
Td

[mag,phase] = mag_phase(Td,z)
[mag,phase] = mag_phase(Td,1)

figure()
bode(Td,{10^-1 10^2});

if 1
        savename='TdRessPI';
    filename=strcat('C:\FAST\CertTest\IPCcontrollerData\Tddata\',savename);
    VARIABLES={'Td'};
    save(filename,VARIABLES{:})
end






