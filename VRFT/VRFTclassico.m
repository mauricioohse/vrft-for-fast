%% Script para VRFT classico "one-shot", com filtro LZ

% Entradas: 
% G - planta
% Td - Comportamento desejado em malha fechada
% C_ = vetor da parametrização do controlado 


% Output:
% C - controlador obtido
% p - parametros do controlador
% Tzc - fç de transf. obtida em laço fechada com C
% Jyc

%% 1. Obter a saída y(t) para um estimulo u(t)
u=1*ones(500,1); % sinal de entrada, step
u_extendido=1*ones(501,1);
y_extendido=lsim(G,u_extendido);
y=y_extendido(1:end-1);


% 2. Obter r_, o sinal virtual onde Td*r_=y(t)
tf_avanco=tf(1,[1 0],1);
Td_inv=Td^-1*tf_avanco
r_extendido=lsim(Td_inv,[y_extendido]);
r_=r_extendido(2:end);
% Verifica y
% y_teste=lsim(Td,r_);
% teste=sum((y-y_teste).^2)

% 3. e_(t)=r_(t)-y(t); phi=C_e_
e_=r_-y;
phi=lsim(C_,e_);


%% 4. phi(t)= C_*(1-Td)/Td*y %não consegui encontrar phi dessa forma
% Tz_phi=C_*(1-Td)/Td;
% phi2=lsim(Tz_phi*tf_avanco,y);


%% 5. filtrar o phi pihL=phi*L(z), L(z)=Td^2/(1-Td)^2
phiL=[]; zetaL=[];
Lz=Td*(1-Td);   % filtro Lz
nphi=size(phi,2);
Lz_mat=Lz*diag(ones(nphi,1)); % matriz de fç de transferencia - 2 input 2 output
phiL=lsim(Lz_mat,phi);

uL=lsim(Lz,u);


%% 6. obtem o parametro p=(phiL*phiL)^-1*phiL*u
% p=(phi'*phi)^-1*phi'*u;
uL=lsim(Lz,u);
p=(phiL'*phiL)^-1*phiL'*uL;

%% 7. Calculo do critério Jy
% Jy=mean[(Tzp-Td)r]
% Tzp: Laço com o controlador encontrado
% Td: Laco desejado
C=minreal(p'*C_,1e-4);
Tzc=C*G/(1+C*G);
Tzc=minreal(Tzc,1e-4);

% calculo do criterio Jy
Yd=lsim(Td,u);
Y=lsim(Tzc,u);
Jyc=(Y-Yd)'*(Y-Yd)/length(u);


