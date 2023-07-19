function [freq,amplitude]=fft_ok2(fs,sinal)
%Função que retorna a amplitude e faixa de frequênciacos
%da transformada de Fourier de um sinal baseado nos dados temporais


nn=length(sinal);
freq = (fs/2)*linspace(0,1,nn/2+1);

x = fft(sinal,nn)/nn;
amp = abs(x(1:nn/2+1));
ang = angle(x(1:nn/2+1));

amplitude = 20*log10(amp);

figure
semilogx(freq,amplitude,'Linewidth',2,'color',[1 1 1]*0) %
grid on
xlabel('Frequencia [Hz]')
ylabel('Magnitude dB')
