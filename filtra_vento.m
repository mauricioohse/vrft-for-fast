% Passa a curva de vento por um filtro de segunda ordem, salva já formatado
% como arquivo de vento 'DadosVentoFormatado.WND' no diretório atual.
% por alguma razao precisa executar esse codigo duas vezes pra funcinar 

% close all
clear dados_formatado
clear time_resampled
clear dados_vento

% criação do filtro
w0=1;                                                % frequencia de corte do filtro
wind(1:2)=[wind(3) wind(3)];                            % wind(1:2) é zero por default, nao quermos isso
filter=tf(w0^2,[1 2*w0 w0^2]);                          % cria uma tf de filtro de segunda ordem
[sys_A,sys_B,sys_C,sys_D]=tf2ss(w0^2,[1 2*w0 w0^2])     % cria as matrizes de ss
sys_wind_filter=ss(sys_A,sys_B,sys_C,sys_D)             % cria ss 

% Aplicaçao do filtro em wind
wind_filtrado=lsim(sys_wind_filter,wind,Time,[0 wind(3)/sys_C(2)]); 

% Plota o vento após filtro
% plot(Time,wind_filtrado)


% Encurta o vetor vento e tempo em 100 vezes
tamanho_Time=size(Time,1);
for n=1:floor(tamanho_Time/1);
dados_vento(n)=wind_filtrado(n*1);
time_resampled(n)=Time(n*1);
end
dados_vento=dados_vento';
time_resampled=time_resampled';
% figure(2)
% plot(time_resampled,dados_vento)

% plota os winds para comparaçao
figure
plot(Time,wind,time_resampled,dados_vento)
legend('Vento FAST','Vento Filtrado')

% Cria um arquivo com a formatacao de WND file do FAST
tamanho_resampled=size(time_resampled,1);
dados_formatado=zeros(tamanho_resampled,8);
dados_formatado(:,1)=time_resampled(:);
dados_formatado(:,2)=dados_vento;
dados_formatado(:,6)=0; % Adiciona vento cortante
dlmwrite('DadosVentoFormatado.WND',dados_formatado,'delimiter','\t','precision','%.2f')

%funcao comma2dot para converter ',' pra '.' < n foi necessario usar