%% ex 3.6.1, 
clc 
clear all
close all
% Pq a estimativa IV + Lz aparenta ter bias? pq tava fazendo so com y1
% O calculo do filtro Lz ta correto para quanto phi tem dimensão maior q 1?

% 



 





%% Noisy case - Instrumental variable

% Mesmos passos anteriores, porem:
% phi=C_*e_ (igual a anterior)
% ksi: propriedades entre 3.43
% p= E[(ksi*phi')]^-1*E[ksi*u]


rng(3)
imax=50;
u = idinput(2000,'prbs'); % 
pbuff=[]; wbuff=[]; pLbuff=[]; wLbuff=[]; wLSbuff=[];
for i=1:imax


a=0.6;
% G=zpk([1.2 .4],[0 0.3 0.8],1,1);
G=zpk([],0.9,1,1);
H=zpk([],[],1,1); % ruido branco
Td=zpk([],a,1-a,1);
C_=[zpk(0,1,1,1);zpk([],1,1,1)]; % PI, eq 3.54


% Experimento - IV roda experimento duas vezes
% N=1000;

sigma=0.5;
e1=sigma*randn(length(u),1);
e2=sigma*randn(length(u),1);
y=lsim(G,u)+e1; 
y2=lsim(G,u)+e2;
Lz=Td*(1-Td);  
Cd_apriori=zpk(0.9,1,1-a,1);

% 2. Obter r_, o sinal virtual onde Td*r_=y(t)
% Obtendo r: Td*r=y - inversa da TF com adição de dinamica rapida p ser causal
Td_fast=(1/Td)*tf(1,[1 0],1);
r_longo=lsim(Td_fast,[y]);
r_=r_longo(2:end);
y_teste=lsim(Td,r_);


r_longo2=lsim(Td_fast,[y2]);
r_2=r_longo2(2:end);
y_teste2=lsim(Td,r_);


%% Filtro Lz

% 5. filtrar o phi pihL=phi*L(z), L(z)=Td/(1-Td)
% como phi tem duas colunas, acho q tem q aplicar o filtro separadamente em
% cada uma
% phiL=[]; zetaL=[];
Lz=Td*(1-Td);   % filtro Lz
% Lz_mat=[Lz 0; 0 Lz]; % matriz de fç de transferencia - 2 input 2 output
% phiL=lsim(Lz_mat,phi);
% zetaL=lsim(Lz_mat,zeta);
uL=lsim(Lz,u);



% 3. e_(t)=r_(t)-y(t); phi=C_e_
% Alt: phi=C_*(1-Td)/Td*y(t)
e_=r_-y(1:end-1);
e_f=lsim(Lz,e_);
phiL=lsim(C_,e_f);

e_2=r_2-y2(1:end-1);
e_f2=lsim(Lz,e_2);
zetaL=lsim(C_,e_f2);

% Como faz para obter phi sem a parte de adicionar atrasos e afins mesmo? n
% consegui
% phi1=lsim(C_*(1-Td)/Td,y);
% zeta=lsim(C_*(l-Td)/Td,y2);




%% 6. Calculo dos parametros
% p=(zeta'*phi)^-1*zeta'*u(1:end-1); % p por IV, sem Lz
% w=[p(1) p(2)/p(1)]';
% pLS=(phi'*phi)^-1*phi'*u(1:end-1); % p por LS sem Lz


% usados:
pLS_L=(phiL'*phiL)^-1*phiL'*uL(1:end-1); % por LS e Lz
pL=(zetaL'*phiL)^-1*zetaL'*uL(1:end-1); % p por IV e LZ
wL=[pL(1) pL(2)/pL(1)]';
wLS=[pLS_L(1) pLS_L(2)/pLS_L(1)]';

%% Compara Td com Tobtido
% Td;
% wd=[0.4 -0.9]';
% pd=[wd(1) wd(2)*wd(1)]';
% 
% C=p'*C_;
% Tzp=C*G/(1+C*G);
% Tzp=minreal(Tzp,1e-4);
% 
% C=pLS'*C_;
% TzpLS=C*G/(1+C*G);
% TzpLS=minreal(TzpLS,1e-4);
% 
% C=pL'*C_;
% TzpL=C*G/(1+C*G);
% TzpL=minreal(TzpL,1e-4);
% 
% C=pd'*C_;
% Tdd=C*G/(1+C*G);
% Tdd=minreal(Tdd,1e-4);
% 
% Td_comp=[ Td Tzp TzpL TzpLS Tdd];

%% Guarda variaveis loop
% pbuff=[pbuff p];    % p por IV, sem Lz
% wbuff=[wbuff w];    
pLbuff=[pLbuff pL]; % p por LS sem Lz
wLbuff=[wLbuff wL];     % p por IV (e LZ)
wLSbuff=[wLSbuff wLS];  % p por LS e LZ, mas sem IV
% esses dois ultimos que são comparados no final 
end

% pmean=[mean(pbuff(1,:));mean(pbuff(2,:))]
% wmean=[pmean(1) pmean(2)/pmean(1)]';
pLmean=[mean(pLbuff(1,:));mean(pLbuff(2,:))]

%% Plot das elipses
close all


figure()
hold on
plot(wLbuff(1,:),wLbuff(2,:),'*','LineWidth',2) % IV + Lz

n_fig = get(gcf,'Number')
P=[cov(wLbuff(1,:),wLbuff(2,:))];
elipses_mod(P^-1,'w1','w2',mean(wLbuff(1,:)),mean(wLbuff(2,:)),n_fig)

plot(wLSbuff(1,:),wLSbuff(2,:),'r*','LineWidth',2)

P=[cov(wLSbuff(1,:),wLSbuff(2,:))];
elipses_mod(P^-1,'w1','w2',mean(wLSbuff(1,:)),mean(wLSbuff(2,:)),n_fig)

legend('VRFT IV + Lz', '','','VRFT LS + Lz')


fprintf('\nSIGMA: %f',sigma)
% xlim([0.388 0.404])
% ylim([ -0.906 -0.892]) 
