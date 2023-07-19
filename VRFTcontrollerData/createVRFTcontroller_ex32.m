%% Codigo para execução de VRFT conforme ex 3.2 livro
% input: dados y e u, C_, Td
clear all
close all

% load 08CL_100__18

savefolder='C:\FAST\CertTest\VRFTcontrollerData\teste measure filter no collect data';
savename='ex32_jonkEmY';


%% dados do experimento
G=tf([0.5 -0.25],[1 -1.8 0.81],1)
u=ones(500,1);
y=lsim(G,u);


%% Cspace

% PI
C_=[tf([1 0],[1 -1],1)];

%% Td
a=0.7;
Td=tf([1-a],[1 -a],1);

%% Lz
Lz=Td*(1-Td);


%% Método VRFT
z_1=tf(1,[1 0],1);
r_temp=lsim(Td^-1*z_1,[y; y(end)]);
r_=r_temp(2:end);
y_reconstruido=lsim(Td,r_);

erro_reconstrucao=sum(abs(y-y_reconstruido));
if erro_reconstrucao>1e-5
    disp('Erro de reconstrução de y por r_ no algoritmo VRFT')
end

e_=r_-y;

phi=lsim(C_,e_);

e_f=lsim(Lz,e_);
phiL=lsim(C_,e_f);
uL=lsim(Lz,u);

p=(phi'*phi)^-1*phi'*u
pL=(phiL'*phiL)^-1*phiL'*uL

u_reconstruido=lsim(p'*C_,e_);
erro_u=sum(abs(u-u_reconstruido));

plot(u) 
hold on
plot(u_reconstruido)


C=p'*C_

%% Save



savefilename=strcat(savefolder,savename,'.mat');
if ~exist(savefilename,'file')
    disp(['workspace salvo em ',savefilename])
    save(savefilename,'C','p','pL','C_','y','u','e_','r_','Lz','erro_u','u_reconstruido','y_reconstruido','phi')
else 
    disp('Tentativa de salvar workspace em cima de nome já utilizado')
    disp(['NAO foi salvo em ',savefilename])
end



