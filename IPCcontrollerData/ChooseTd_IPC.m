% Escolhe Td para VRFT IPC

if ~exist('choose_Td_IPC')
    choose_Td_IPC='TdGwd_ts2o';
    p_Td_IPC=15;
    disp( 'Não foi escolhida Td IPC: default Td n=1, p=0.8 carregada')
%     load(choose_Td_IPC)
end
DTtd=0.05;
w=12.1*2*pi/60; %12.1 rpm em rad

switch choose_Td_IPC
    case {'TdR'}
        
        
        
        z=exp(1i*w*DTtd);
        Tdabs=abs(1/(z-p_Td_IPC)^3);
        Tdang=angle(1/(z-p_Td_IPC)^3);
        aux=Tdabs^-1*exp(-1i*Tdang);
        A=[real(z) real(z^2);
            imag(z) imag(z^2);];
        b=[real(aux); imag(aux)];
        k=A^-1*b;
        
        k1=k(1);
        k2=k(2);
        
        
        
        
        T1=zpk([0],[p_Td_IPC p_Td_IPC p_Td_IPC],1,DTtd);
        T2=tf([ k2 k1],[1],DTtd);
        
        Td=T1*T2;
        
    case {'TdR1k'} % Td= (k+k2*z)/(z-p)^2
        
        z=exp(1i*w*DTtd);
        Tdabs=abs(1/(z-p_Td_IPC)^2);
        Tdang=angle(1/(z-p_Td_IPC)^2);
        aux=Tdabs^-1*exp(-1i*Tdang);
        A=[real(1) real(z);
            imag(1) imag(z);];
        b=[real(aux); imag(aux)];
        k=A^-1*b;
        
        k1=k(1);
        k2=k(2);
        
        
        
        
        T1=zpk([],[p_Td_IPC p_Td_IPC],1,DTtd);
        T2=tf([ k2 k1],[1],DTtd);
        Td=T1*T2;
        
    case {'TdR2o'} % caso de duas harmonicas (1.26 e 2.52)
        % Td= k*z^i/(z-p)^4, i=0 a 3
        
        
        z=exp(1i*w*DTtd);
        z2=exp(1i*2*w*DTtd);
        
        
        aux=((z-p_Td_IPC)^4);
        aux2=((z2-p_Td_IPC)^4);
        A=[real(1) real(z) real(z^2) real(z^3);
            imag(1) imag(z) imag(z^2) imag(z^3);
            real(1) real((z2)) real((z2)^2) real((z2)^3);
            imag(1) imag((z2)) imag((z2)^2) imag((z2)^3);];
        b=[real(aux); imag(aux); real(aux2); imag(aux2)];
        k=A\b;
        
        T1=zpk([],[p_Td_IPC*ones(1,4)],1,DTtd);
        T2=tf([k(4) k(3) k(2) k(1)],[1],DTtd);
        Td=T1*T2;
        
    case 'TdR3o' % caso harmonica de terceira ordem
        
        z=exp(1i*w*DTtd);
        z2=exp(1i*2*w*DTtd);
        
        
        aux=((z-p_Td_IPC)^4);
        aux2=((z2-p_Td_IPC)^4);
        A=[real(1) real(z) real(z^2) real(z^3);
            imag(1) imag(z) imag(z^2) imag(z^3);
            real(1) real((z2)) real((z2)^2) real((z2)^3);
            imag(1) imag((z2)) imag((z2)^2) imag((z2)^3);];
        b=[real(aux); imag(aux); real(aux2); imag(aux2)];
        k=A^-1*b;
        
        T1=zpk([],[p_Td_IPC*ones(1,4)],1,DTtd);
        T2=tf([k(4) k(3) k(2) k(1)],[1],DTtd);
        Td=T1*T2;
    case 'TdR32o' % caso harmonica 2 e 3 ordem
        
        z=exp(1i*w*DTtd);
        z2=exp(1i*2*w*DTtd);
        z3=exp(1i*3*w*DTtd);
        
        
        aux=((z-p_Td_IPC)^6);
        aux2=((z2-p_Td_IPC)^6);
        aux3=((z3-p_Td_IPC)^6);
        A=[real(1) real(z) real(z^2) real(z^3) real((z)^4) real((z)^5);
            imag(1) imag(z) imag(z^2) imag(z^3) imag((z)^4) imag((z)^5);
            real(1) real((z2)) real((z2)^2) real((z2)^3) real((z2)^4) real((z2)^5);
            imag(1) imag((z2)) imag((z2)^2) imag((z2)^3) imag((z2)^4) imag((z2)^5);
            real(1) real((z3)) real((z3)^2) real((z3)^3) real((z3)^4) real((z3)^5);
            imag(1) imag((z3)) imag((z3)^2) imag((z3)^3) imag((z3)^4) imag((z3)^5);];
        b=[real(aux); imag(aux); real(aux2); imag(aux2); real(aux3); imag(aux3)];
%         k=A^-1*b;
        k=A\b;
        
        T1=zpk([],[p_Td_IPC*ones(1,6)],1,DTtd);
        T2=tf([k(6) k(5) k(4) k(3) k(2) k(1)],[1],DTtd);
        Td=T1*T2;
    case 'TdR53o' % caso harmonicas em 5 e 3
        
        z=exp(1i*w*DTtd);
        z2=exp(1i*3*w*DTtd);
        z3=exp(1i*5*w*DTtd);
        
        
        aux=((z-p_Td_IPC)^6);
        aux2=((z2-p_Td_IPC)^6);
        aux3=((z3-p_Td_IPC)^6);
        A=[real(1) real(z) real(z^2) real(z^3) real((z)^4) real((z)^5);
            imag(1) imag(z) imag(z^2) imag(z^3) imag((z)^4) imag((z)^5);
            real(1) real((z2)) real((z2)^2) real((z2)^3) real((z2)^4) real((z2)^5);
            imag(1) imag((z2)) imag((z2)^2) imag((z2)^3) imag((z2)^4) imag((z2)^5);
            real(1) real((z3)) real((z3)^2) real((z3)^3) real((z3)^4) real((z3)^5);
            imag(1) imag((z3)) imag((z3)^2) imag((z3)^3) imag((z3)^4) imag((z3)^5);];
        b=[real(aux); imag(aux); real(aux2); imag(aux2); real(aux3); imag(aux3)];
        k=A^-1*b;
        
        T1=zpk([],[p_Td_IPC*ones(1,6)],1,DTtd);
        T2=tf([k(6) k(5) k(4) k(3) k(2) k(1)],[1],DTtd);
        Td=T1*T2;       
        
    case {'TdR1z2o'} % caso de duas harmonicas (1.26 e 2.52)
        % e com zero em zero
        % Td= k*z^i/(z-p)^4, i=0 a 3
        
        
        z=exp(1i*w*DTtd);
        z2=exp(1i*3*w*DTtd);
        
        
        aux=((z-p_Td_IPC)^5);
        aux2=((z2-p_Td_IPC)^5);
        A=[real(z) real(z^2) real(z^3) real(z^4);
            imag(z) imag(z^2) imag(z^3) imag(z^4);
            real(z2) real((z2^2)) real((z2)^3) real((z2)^4);
            imag(z2) imag((z2^2)) imag((z2)^3) imag((z2)^4);];
        b=[real(aux); imag(aux); real(aux2); imag(aux2)];
        k=A^-1*b;
        
        T1=zpk([],[p_Td_IPC*ones(1,5)],1,DTtd);
        T2=tf([k(4) k(3) k(2) k(1) 0],[1],DTtd);
        Td=T1*T2;
        
        
    case 'TdRI'
        
        
        
        z=exp(1i*w*DTtd);
        aux= (z-p_Td_IPC)^3;
        
        A=[ 1   1   1;
            1 real(z) real(z^2);
            0 imag(z) imag(z^2);];
        b=[(1-p_Td_IPC)^3;real(aux); imag(aux)];
        
        k=A^-1*b;
        
        
        Td=tf([k(3) k(2) k(1)],1,DTtd)*zpk([],[p_Td_IPC p_Td_IPC p_Td_IPC],1,DTtd);
        
    case 'TdRIz'
        
        
        
        z=exp(1i*w*DTtd);
        aux= (z-p_Td_IPC)^4;
        
        A=[ 1   1   1;
            real(z) real(z^2) real(z^3);
            imag(z) imag(z^2) imag(z^3);];
        b=[(1-p_Td_IPC)^4;real(aux); imag(aux)];
        
        k=A^-1*b;
        
        
        Td=tf([k(3) k(2) k(1) 0],1,DTtd)*zpk([],[p_Td_IPC p_Td_IPC p_Td_IPC p_Td_IPC],1,DTtd);
    case 'TdPI'
        % Td(z=1)=1, Td= (k)/(z-p)
        k=(1-p_Td_IPC);
        Td=tf([k],1,DTtd)*zpk([],[p_Td_IPC],1,DTtd);
        
    case 'Td1'
        load(choose_Td_IPC)
        
    case 'TdV2o'
        %tbd
        
                % Td= k*z^i/(z-p)^4, i=0 a 3
%         G_toy =
%  
%    0.0011353 (z+0.9108)
%   -----------------------
%   (z^2 - 1.702z + 0.7558)

        z=exp(1i*w*DTtd);
        z2=exp(1i*2*w*DTtd);
        
        
        aux=(((z^2 - 1.702*z + 0.7558))^2);
        aux2=(((z2^2 - 1.702*z2 + 0.7558))^2);
        A=[real(1) real(z) real(z^2) real(z^3);
            imag(1) imag(z) imag(z^2) imag(z^3);
            real(1) real((z2)) real((z2)^2) real((z2)^3);
            imag(1) imag((z2)) imag((z2)^2) imag((z2)^3);];
        b=[real(aux); imag(aux); real(aux2); imag(aux2)];
        k=A\b;
        
        T1=tf(1,[1  -1.702  0.7558],DTtd)*tf(1,[1  -1.702  0.7558],DTtd);
        T2=tf([k(4) k(3) k(2) k(1)],[1],DTtd);
        Td=T1*T2;
    case 'TdG'
        % caso em que a Td de  den 2a ordem possui polo complx. frequencia wn = 1.26
        % e zeta = 0.2, ganho 1
        zeta=p_Td_IPC;
        z=exp(1i*w*DTtd);
        s=exp(1i*w);
        
        polo=-w*(zeta+1i*sqrt(1-zeta^2));
        poles_Tds=zpk([],[polo conj(polo)],1);
        poles_Tds_to_d=c2d(poles_Tds,0.05);
        [num_aux,den_aux]=tfdata(poles_Tds_to_d);
        Tdz_poles=tf(1,den_aux,DTtd);
       
        [mag,phase]=mag_phase(Tdz_poles,z);
        poles_at_w=mag*exp(1i*phase*pi/180);
        
        aux=poles_at_w^-1;
        A=[real(1) real(z);
            imag(1) imag(z);];
        b=[real(aux); imag(aux)];
        k=A\b;
        
        k1=k(1);
        k2=k(2);
        
        
        
        
        T1=Tdz_poles;%zpk([],[poles_at_w conj(poles_at_w)],1);
        T2=tf([ k2 k1],[1],0.05);
        Td=T1*T2;
        
    case 'TdGm09_'
        % caso em que a Td de  den 2a ordem possui polo complx. frequencia wn = 1.26
        % e zeta = 0.2, e polos com modulo 0.9
        zeta=p_Td_IPC;
        z=exp(1i*w*DTtd);
        s=exp(1i*w);
        
        polo=-w*(zeta+1i*sqrt(1-zeta^2));
        poles_Tds=zpk([],[polo conj(polo)],1);
        poles_Tds_to_d=c2d(poles_Tds,0.05);
        [num_aux,den_aux]=tfdata(poles_Tds_to_d);
        Tdz_poles=tf(1,den_aux,DTtd);
        poles_Tdz=pole(Tdz_poles);
        
        % reescalar polos para ter modulo 0.9
        absolute=abs(poles_Tdz);
        for i=1:size(absolute)
            scaled_poles(i)=poles_Tdz(i)*0.9/absolute(i);
        end
        % now mount Tdz poles with scaled values
        Tdz_poles=zpk([],scaled_poles,1,DTtd);
        [mag,phase]=mag_phase(Tdz_poles,z);
        poles_at_w=mag*exp(1i*phase*pi/180);
        
        aux=poles_at_w^-1;
        A=[real(1) real(z);
            imag(1) imag(z);];
        b=[real(aux); imag(aux)];
        k=A\b;
        
        k1=k(1);
        k2=k(2);
        
        
        
        
        T1=Tdz_poles;%zpk([],[poles_at_w conj(poles_at_w)],1);
        T2=tf([ k2 k1],[1],0.05);
        Td=T1*T2;
        
    case 'TdG2o'
        % caso em que a Td de  den 4 ordem para matar os polos
        
        zeta=p_Td_IPC;
        z=exp(1i*w*DTtd);
        z2=exp(1i*2*w*DTtd);
        
        polo=-w*(zeta+1i*sqrt(1-zeta^2));
        polo2=-2*w*(zeta+1i*sqrt(1-zeta^2));
        poles_Tds=zpk([],[polo conj(polo) polo2 conj(polo2)],1);
        poles_Tds_to_d=c2d(poles_Tds,0.05);
        [num_aux,den_aux]=tfdata(poles_Tds_to_d);
        Tdz_poles=tf(1,den_aux,DTtd);
        
        [mag,phase]=mag_phase(Tdz_poles,z);
        poles_at_w=evalfr(Tdz_poles,z);%mag*exp(1i*phase*pi/180);
        poles_at_w2=evalfr(Tdz_poles,z2);
        
        aux=poles_at_w^-1;
        aux2=poles_at_w2^-1;
        A=[real(1) real(z) real(z^2) real(z^3);
            imag(1) imag(z) imag(z^2) imag(z^3);
            real(1) real((z2)) real((z2)^2) real((z2)^3);
            imag(1) imag((z2)) imag((z2)^2) imag((z2)^3);];
        b=[real(aux); imag(aux); real(aux2); imag(aux2)];
        k=A\b;
        
        
        T1=Tdz_poles;%zpk([],[poles_at_w conj(poles_at_w)],1);
        T2=tf([ k(4) k(3) k(2) k(1)],[1],0.05);
        Td=T1*T2;
        
    case 'TdG2o_09m'
        % caso em que a Td de  den 4 ordem para matar os polos
        % e modulo dos polos =0.9
        
        zeta=p_Td_IPC;
        z=exp(1i*w*DTtd);
        z2=exp(1i*2*w*DTtd);
        
        polo=-w*(zeta+1i*sqrt(1-zeta^2));
        polo2=-2*w*(zeta+1i*sqrt(1-zeta^2));
        poles_Tds=zpk([],[polo conj(polo) polo2 conj(polo2)],1);
        poles_Tds_to_d=c2d(poles_Tds,0.05);
        [num_aux,den_aux]=tfdata(poles_Tds_to_d);
        Tdz_poles=tf(1,den_aux,DTtd);
        
        
        % reescalar polos para ter modulo 0.9
        poles_Tdz=pole(Tdz_poles);
        absolute=abs(poles_Tdz);
        for i=1:size(absolute)
            scaled_poles(i)=poles_Tdz(i)*0.9/absolute(i);
        end
        % now mount Tdz poles with scaled values
        Tdz_poles=zpk([],scaled_poles,1,DTtd);
        
       
        [mag,phase]=mag_phase(Tdz_poles,z);
        poles_at_w=evalfr(Tdz_poles,z);%mag*exp(1i*phase*pi/180);
        poles_at_w2=evalfr(Tdz_poles,z2);
        
        aux=poles_at_w^-1;
        aux2=poles_at_w2^-1;
        A=[real(1) real(z) real(z^2) real(z^3);
            imag(1) imag(z) imag(z^2) imag(z^3);
            real(1) real((z2)) real((z2)^2) real((z2)^3);
            imag(1) imag((z2)) imag((z2)^2) imag((z2)^3);];
        b=[real(aux); imag(aux); real(aux2); imag(aux2)];
        k=A\b;
        
        
        T1=Tdz_poles;%zpk([],[poles_at_w conj(poles_at_w)],1);
        T2=tf([ k(4) k(3) k(2) k(1)],[1],0.05);
        Td=T1*T2;
        
        % C_ de duas harmonicas
        chooseCspace_IPC='RessP2';
        
        
    case 'TdGts' % caso onde a Td de segundo grau é definido por Ts e wn
        chooseCspace_IPC='RessP'; % controlador 
        ts=p_Td_IPC; % nesse caso, p_Td_IPC é o ts, baseline 10 ou 20 seg
        zeta=4/(w*ts)
        
        z=exp(1i*w*DTtd);
        s=exp(1i*w);
        
        polo=-w*(zeta+1i*sqrt(1-zeta^2));
        poles_Tds=zpk([],[polo conj(polo)],1);
        poles_Tds_to_d=c2d(poles_Tds,0.05);
        [num_aux,den_aux]=tfdata(poles_Tds_to_d);
        Tdz_poles=tf(1,den_aux,DTtd);
       
        [mag,phase]=mag_phase(Tdz_poles,z);
        poles_at_w=mag*exp(1i*phase*pi/180);
        
        aux=poles_at_w^-1;
        A=[real(1) real(z);
            imag(1) imag(z);];
        b=[real(aux); imag(aux)];
        k=A\b;
        
        k1=k(1);
        k2=k(2);
        
        
        
        
        T1=Tdz_poles;%zpk([],[poles_at_w conj(poles_at_w)],1);
        T2=tf([ k2 k1],[1],0.05);
        Td=T1*T2;
        
    case 'TdGts2o' % caso onde a Td de quarto grau (z e z2) é definida por Ts e wn
        chooseCspace_IPC='RessP2'; % controlador
        ts=p_Td_IPC; % nesse caso, p_Td_IPC é o ts, baseline 10 ou 20 seg
        zeta=4/(w*ts)
        z=exp(1i*w*DTtd);
        z2=exp(1i*2*w*DTtd);
        
        polo=-w*(zeta+1i*sqrt(1-zeta^2));
        polo2=-2*w*(zeta+1i*sqrt(1-zeta^2));
        poles_Tds=zpk([],[polo conj(polo) polo2 conj(polo2)],1);
        poles_Tds_to_d=c2d(poles_Tds,0.05);
        [num_aux,den_aux]=tfdata(poles_Tds_to_d);
        Tdz_poles=tf(1,den_aux,DTtd);
        
        [mag,phase]=mag_phase(Tdz_poles,z);
        poles_at_w=evalfr(Tdz_poles,z);%mag*exp(1i*phase*pi/180);
        poles_at_w2=evalfr(Tdz_poles,z2);
        
        aux=poles_at_w^-1;
        aux2=poles_at_w2^-1;
        A=[real(1) real(z) real(z^2) real(z^3);
            imag(1) imag(z) imag(z^2) imag(z^3);
            real(1) real((z2)) real((z2)^2) real((z2)^3);
            imag(1) imag((z2)) imag((z2)^2) imag((z2)^3);];
        b=[real(aux); imag(aux); real(aux2); imag(aux2)];
        k=A\b;
        
        
        T1=Tdz_poles;%zpk([],[poles_at_w conj(poles_at_w)],1);
        T2=tf([ k(4) k(3) k(2) k(1)],[1],0.05);
        Td=T1*T2;
        
        
    case 'TdGwd_ts2o' % caso onde a Td de quarto grau (z e z2) é definida por Ts e wd
        % lembrando: wd é a frequencia de oscilação da resposta transitória
        % da Td. w=1.26 a frequencia fundamental, wn é obtida por wd nesse
        % caso.
        chooseCspace_IPC='RessP2'; % controlador
        ts=p_Td_IPC; % nesse caso, p_Td_IPC é o ts, baseline 10 ou 20 seg
        wd=w;
        wn=sqrt(wd^2+16/ts^2);
        
        zeta=4/(wn*ts)
        z=exp(1i*w*DTtd);
        z2=exp(1i*2*w*DTtd);
        
        polo=-wn*(zeta+1i*sqrt(1-zeta^2));
        polo2=-2*wn*(zeta+1i*sqrt(1-zeta^2));
        poles_Tds=zpk([],[polo conj(polo) polo2 conj(polo2)],1);
        poles_Tds_to_d=c2d(poles_Tds,0.05);
        [num_aux,den_aux]=tfdata(poles_Tds_to_d);
        Tdz_poles=tf(1,den_aux,DTtd);
        
        [mag,phase]=mag_phase(Tdz_poles,z);
        poles_at_w=evalfr(Tdz_poles,z);%mag*exp(1i*phase*pi/180);
        poles_at_w2=evalfr(Tdz_poles,z2);
        
        aux=poles_at_w^-1;
        aux2=poles_at_w2^-1;
        A=[real(1) real(z) real(z^2) real(z^3);
            imag(1) imag(z) imag(z^2) imag(z^3);
            real(1) real((z2)) real((z2)^2) real((z2)^3);
            imag(1) imag((z2)) imag((z2)^2) imag((z2)^3);];
        b=[real(aux); imag(aux); real(aux2); imag(aux2)];
        k=A\b;
        
        
        T1=Tdz_poles;%zpk([],[poles_at_w conj(poles_at_w)],1);
        T2=tf([ k(4) k(3) k(2) k(1)],[1],0.05);
        Td=T1*T2;
        
    case 'TdGwd_ts3o' % caso onde a Td de sexto grau (z e z2 e z3) é definida por Ts e wd
        % lembrando: wd é a frequencia de oscilação da resposta transitória
        % da Td. w=1.26 a frequencia fundamental, wn é obtida por wd nesse
        % caso.
        chooseCspace_IPC='RessP32'; % controlador
        ts=p_Td_IPC; % nesse caso, p_Td_IPC é o ts, baseline 10 ou 20 seg
        wd=w;
        wn=sqrt(wd^2+16/ts^2);
        
        zeta=4/(wn*ts)
        z=exp(1i*w*DTtd);
        z2=exp(1i*2*w*DTtd);
        z3=exp(1i*4*w*DTtd); % terceira harmonica
        
        polo=-wn*(zeta+1i*sqrt(1-zeta^2));
        polo2=-2*wn*(zeta+1i*sqrt(1-zeta^2));
        polo3=-4*wn*(zeta+1i*sqrt(1-zeta^2));
        poles_Tds=zpk([],[polo conj(polo) polo2 conj(polo2) polo3 conj(polo3)],1);
        poles_Tds_to_d=c2d(poles_Tds,0.05);
        [num_aux,den_aux]=tfdata(poles_Tds_to_d);
        Tdz_poles=tf(1,den_aux,DTtd);
        
        [mag,phase]=mag_phase(Tdz_poles,z);
        poles_at_w=evalfr(Tdz_poles,z);%mag*exp(1i*phase*pi/180);
        poles_at_w2=evalfr(Tdz_poles,z2);
        poles_at_w3=evalfr(Tdz_poles,z3);
        
        aux=poles_at_w^-1;
        aux2=poles_at_w2^-1;
        aux3=poles_at_w3^-1;
        A=[real(1) real(z) real(z^2) real(z^3) real(z^4) real(z^5);
            imag(1) imag(z) imag(z^2) imag(z^3) imag(z^4) imag(z^5);
            real(1) real((z2)) real((z2)^2) real((z2)^3) real((z2)^4) real((z2)^5);
            imag(1) imag((z2)) imag((z2)^2) imag((z2)^3) imag((z2)^4) imag((z2)^5);
            real(1) real((z3)) real((z3)^2) real((z3)^3) real((z3)^4) real((z3)^5);
            imag(1) imag((z3)) imag((z3)^2) imag((z3)^3) imag((z3)^4) imag((z3)^5);];
        
        
        
        b=[real(aux); imag(aux); real(aux2); imag(aux2); real(aux3); imag(aux3)];
        k=A\b;
        
        
        T1=Tdz_poles;%zpk([],[poles_at_w conj(poles_at_w)],1);
        T2=tf([k(6) k(5) k(4) k(3) k(2) k(1)],[1],0.05);
        Td=T1*T2;
        
        
        
            case 'TdGwd_ts1o' % caso onde a Td de segundo grau (z ) é definida por Ts e wd
        % lembrando: wd é a frequencia de oscilação da resposta transitória
        % da Td. w=1.26 a frequencia fundamental, wn é obtida por wd nesse
        % caso.
        chooseCspace_IPC='RessP'; % controlador
        ts=p_Td_IPC; % nesse caso, p_Td_IPC é o ts, baseline 10 ou 20 seg
        wd=w;
        wn=sqrt(wd^2+16/ts^2);
        
        zeta=4/(wn*ts)
        z=exp(1i*w*DTtd);
        
        polo=-wn*(zeta+1i*sqrt(1-zeta^2));
        poles_Tds=zpk([],[polo conj(polo)],1);
        poles_Tds_to_d=c2d(poles_Tds,0.05);
        [num_aux,den_aux]=tfdata(poles_Tds_to_d);
        Tdz_poles=tf(1,den_aux,DTtd);
        
        [mag,phase]=mag_phase(Tdz_poles,z);
        poles_at_w=evalfr(Tdz_poles,z);%mag*exp(1i*phase*pi/180);
        
        aux=poles_at_w^-1;
        A=[real(1) real(z);
            imag(1) imag(z);];
        b=[real(aux); imag(aux); ];
        k=A\b;
        
        
        T1=Tdz_poles;%zpk([],[poles_at_w conj(poles_at_w)],1);
        T2=tf([k(2) k(1)],[1],0.05);
        Td=T1*T2;
end

%% Checa if nan

isTd_nan=isnan(dcgain(Td));



