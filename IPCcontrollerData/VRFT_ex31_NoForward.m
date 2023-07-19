%First, example 3.2 from book:
clear all
close all

scale=1.345006843182787e+02;

switch 3


    case 1 %ex 3.1

G= tf(0.5,[1 -0.9],1)

a= 0.6
Td= tf(1-a, [1 -a],1)
C_=[tf([1 0],[1 -1],1);
    tf([1],[1 -1],1);]

    case 2 % ex 3.2

G= zpk(0.5,[0.9 0.9],0.5,1)

a= 0.7
Td= tf(1-a, [1 -a],1)
C_=[tf([1 0],[1 -1],1);]
u=ones(1,500);


    case 3
G= zpk(0.5,[0.9 0.9],0.5,1)

a= 0.7
Td= tf(1-a, [1 -a],1)
C_=[tf([1 0],[1 -1],1);]
u=idinput(500,'PRBS',[0  0.05])'+ones(500,1)';

    case 4
G= zpk(0.5,[0.9 0.9],0.5,1)

a= 0.7
Td= tf(1-a, [1 -a],1)
C_=[tf([1 0],[1 -1],1);]
u=ones(1,500);
u(1,1:100)=u(1,1:100)*0;
u(1,201:300)=u(1,1:100)*0;
u(1,401:500)=u(1,1:100)*0;
end



y=lsim(G,u);





%% old way
Td_fast=(1/Td)*tf(1,[1 0],1);
r_longo=lsim(Td_fast,[y]);
r_=r_longo(2:end); % necessário cortar a primeira amostra devido ao avanço
y_teste=lsim(Td,r_);

% 2. e_(t)=r_(t)-y(t); phi=C_e_
e_=r_-y(1:end-1);
phi_old=lsim(C_,e_);
% 
Lz=Td*(1-Td);
e_f=lsim(Lz,e_);

phiL_old=lsim(C_,e_f);
uL_old=lsim(Lz,u);

p_old=(phi_old'*phi_old)^-1*phi_old'*u(1:end-1)'
pL_old=(phiL_old'*phiL_old)^-1*phiL_old'*uL_old(1:end-1)


% p_2=(phi_aux'*phi_aux)^-1*phi_aux'*utd(1:end-1);
%
% obtençao do controlador
% Cp=minreal(p'*C_);
% CL_old=zpk(minreal(pL_old'*C_));


%% new way
phi=lsim(C_*(1-Td),y)';

Lz=1-Td;

yL=lsim(Lz,y);
phiL=lsim(C_*(1-Td),yL)';


utd=lsim(Td,u)';
uL=lsim(Lz,utd)';
% uL=lsim(Lz,aux)';

p=(phi*phi')^-1*phi*u'
ptd=(phi*phi')^-1*phi*utd'
pL=(phiL*phiL')^-1*phiL*uL'
C=pL'*C_


%% comparações
figure()
plot(phi,'LineWidth',2)
hold on
plot(phi_old,'LineWidth',2)
plot(phiL,'LineWidth',2)
plot(phiL_old,'LineWidth',2)
legend('phi old (sem L)','phi(sem L)','phiL old','phiL')
grid
% xlim([0 100])
% plot(u)
figure()
plot(u,'LineWidth',2)
hold on
plot(uL_old,'*','LineWidth',2)
plot(uL,'LineWidth',2)
plot(utd,'LineWidth',2)
legend('u','uL old','uL','utd')
grid
% xlim([0 100])

%% Calculo de jy


C_old=pL_old'*C_
C_semLZ=p*C_;


Tz_old=C_old*G/(1+C_old*G);
Tz_semLZ=C_semLZ*G/(1+C_semLZ*G);

r=ones(500,1);


TzL=C*G/(1+C*G);
Yd=lsim(Td,r);
Y=lsim(TzL,r);
Jy_new=(Y-Yd)'*(Y-Yd)/length(r);


YL_old=lsim(Tz_old,r);
Y_semLZ=lsim(Tz_semLZ,r);


JyL_old=(YL_old-Yd)'*(YL_old-Yd)/length(r);
Jy_semLZ=(Y_semLZ-Yd)'*(Y_semLZ-Yd)/length(r);


%% Plots para comparação


p_all=0:0.0001:0.016;
Jyp=zeros(length(p_all),1);
Yd=lsim(Td,r);
for idx=1:length(p_all)
    C_all=p_all(idx)'*C_;
    Tz_all=C_all*G/(1+C_all*G);
    Y_all=lsim(Tz_all,r);
    Jy_current=(Y_all-Yd)'*(Y_all-Yd)/length(r);
    Jyp(idx)=Jy_current;
    
end


[Jy_min,I]=min(Jyp)
p_all(I)

%%
figure()
plot(p_all,Jyp*scale)
hold on
plot(p,Jy_semLZ*scale,'x','LineWidth',2)
plot(pL_old,JyL_old*scale,'x','LineWidth',2)
plot(pL,Jy_new*scale,'x','LineWidth',2)
plot(p_all(I),Jy_min*scale,'x','LineWidth',2)


ylim([0 50])
legend('Jy(p)','Jy semL','JyL old', 'JyL new','Jy min')
grid


%%
disp('           p  |  Jy')
disp(strcat('best :  ',num2str(p_all(I)),'| ',num2str(Jy_min*scale)))
disp(strcat('sem L:  ',num2str(p),'| ',num2str(Jy_semLZ*scale)))
disp(strcat('old  :  ',num2str(pL_old),'| ',num2str(JyL_old*scale)))
disp(strcat('new  :  ',num2str(pL),'| ',num2str(Jy_new*scale)))
