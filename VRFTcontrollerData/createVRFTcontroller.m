%% Codigo para execução de VRFT conforme ex 3.2 livro
% input: dados y e u, C_, Td
clear all
close all


extra='';


load_data_name='08CL_100__18'
load(load_data_name)

load FilterData


savefolder='C:\FAST\CertTest\VRFTcontrollerData\teste measure filter no collect data\';
savename=strcat(load_data_name,extra);


%% dados do experimento
y_base=rotspeed_sOp;
y=y_base;
y=lsim(Filter_tf,rotspeed_sOp,Time);
u=heta_out_sOp;


%% Cspace

% PI
C_=[tf([1 0],[1 -1],DT);
            tf([1],[1 -1],DT)];
C_base=C_;

% C_=C_*c2d(Filter_tf,DT);
%% Td
chooseTs='2o_10_05';
ChooseTd

%% Lz
Lz=Td*(1-Td);


%% Método VRFT
z_1=tf(1,[1 0],DT);
r_temp=lsim(Td^-1*z_1,[y; y(end)]);
r_=r_temp(2:end);
y_reconstruido=lsim(Td,r_);

erro_y=sum(abs(y-y_reconstruido));
if erro_y>1e-5
    disp('Erro de reconstrução de y por r_ no algoritmo VRFT')
end

e_=r_-y;



phi=lsim(C_,e_);


e_f=lsim(Lz,e_);
phiL=lsim(C_,e_f);
uL=lsim(Lz,u);

p_semL=(phi'*phi)^-1*phi'*u
p=(phiL'*phiL)^-1*phiL'*uL


u_reconstruido=lsim(p'*C_,e_);
erro_u=sum(abs(u-u_reconstruido))


C=minreal(zpk(p'*C_base))
p
%% plots

figure()
plot(y_base)
hold on
plot(y)
legend({'y_base','y filtrado'},'Interpreter','none')
erro_y_filtrado=sum(abs(y_base-y))

%% save

savefilename=strcat(savefolder,savename,'.mat');
if ~exist(savefilename,'file')
    disp(['workspace salvo em ',savefilename])
    save(savefilename,'C','p','p_semL','C_','y','u','e_','r_','Lz','erro_u','u_reconstruido','y_reconstruido','phi')
else 
    disp('Tentativa de salvar workspace em cima de nome já utilizado')
    disp(['NAO foi salvo em ',savefilename])
end