# Considerações iniciais

Esse repositório contém todos os scripts que escrevi ao longo da minha dissertação de mestrado "Projeto de controle baseado em dados para regulação de velocidade de rotor e redução de esforços mecânicos em turbinas eólicas". Atualizarei o link com minha dissertação uma vez que ela for publicada em vias oficiais da UFRGS.

Inicialmente, eu iria adicionar todo o meu folder de arquivos aqui, porém tenho muitos arquivos pesados e o github não é o local adequado para guardar tudo. Por isso, fiz upload da pasta "FAST", que contém todos meus codigos, assim como os arquivos do simulador nesse link: https://1drv.ms/f/s!ApSWXT3Krh1UgahpdmIa8yvcQhevCw?e=wP3Afq

IMPORTANTE: é necessario que o repositorio seja salvo em C:/FAST/, visto que os scripts utilizam path absoluto.

# Instalações prévias

Para utilizar esse repositório e executar meus scripts, é necessário:

Instalar o FAST v7, conforme https://www.nrel.gov/wind/nwtc/fastv7.html

Instalar MATLAB R2015a -> essa versão é necessária, visto que em 2016 o matlab mudou a forma como S_FUNC são compiladas.

# Scripts

A fonte inicial e mais completa de informações é minha própria dissertação. Resumidamente, eu aplico o método VRFT para projetar controladores do tipo CPC e IPC em uma turbina simulada pelo FAST.

Infelizmente, quando escrevi esses códigos, não o fiz de uma maneira que seja facilmente entendível para outra pessoa. Sinceramente, se é teu objetivo tentar entender como isso funciona, sugiro fortemente me enviar um email que posso ajudar.

## Projeto pelo VRFT

### CPC

A coleta de dados do CPC é feita através de exe_VRFT_dataCollect.m, e os dados são tratados em exe_VRFT_dataCollect_tratamento.m. O tratamento é o corte dos dados de acordo com os tempos e ventos requeridos.

O projeto do VRFT é feito a partir de VRFTdesign*ex3_2.m. Esse nome se refere ao ex3_2 do livro do Bazanella, que foi utilizado como base para a formulação inicial desse script. Uma vez rodado esse arquivo, ele gera um controlador com um nome como:
"02_down50_18_PI_Td2o_10_05*.mat"
Tradução:
02*down50_18: dados coletados, salto de 0.2 graus para baixo com periodo de 50 segundos (para coleta de dados)
\_PI_Td2o_10_05*: controlador PI projetado, utilizando uma Td(z) de segunda ordem com ts=10 segundos e Mp=5%.

Com o controlador projetado, é possivel executar exe_VRFT_discreto.m, que executa uma simulação com esse controlador na malha. é possivel escolher o cenario de vento (f1422 é o cenario de vento de disturbio, ctrl_step são os cenarios de vento constante e salto unitario na referência). Esse script salva uma simulação com o nome, por exemplo:

'02*down50_18_PI_Td2o_10_05_f1422htzgauto.mat'
02_down50_18_PI_Td2o_10_05*: o controlador utilizado
f1422htzgauto.mat: cenário f1422, com filtro de entrada do htzg, e o auto indica que foi executado a partir de um script de automaticamente gerar simulações (rerunCPC_mlife_pontop).

### IPC

De forma semelhante, o IPC utiliza:

exe_VRFT_collectData_IPC.m: gera os dados de coleta para o IPC

VRFTdesign_IPC.m: projeta o controlador IPC baseado nos dados

exe_VRFT_IPC.m: executa uma simulação em malha fechada com o controlador escolhido.

exemplo de arquivo de simulação do IPC:
'OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o5**fwdIPCsteady18_Shadhtzgauto.mat'
OLsin_3p_smol2DC_man_250_shadIPC_18_RessP2_TdGwd_ts2o5**fwdIPC > isso é o controlador
OLsin_3p_smol2DC_man_250_shadIPC_18: Dados coletados utilizando o sinal u_c3 de excitação, periodo de 250 segundos, com efeitos te tower shadow e cisalhamento no ponto de operação de 18.
\_RessP2_TdGwd_ts2o5\_\_fwdIPC: usando modelo de referência construido a partir de tempo de acomodação desejado de 5 segundos (equivalente a 0,6 \xi, ou algo assim), RessP2 significa que é um controlador ressonante com duas frequências de ressonancia
steady18_Shadhtzgauto: cenário de vento constante em 18 m/s, com efeito de tower shadow e cisalhamento, utilizando filtro do htzg e gerato em batch run (auto)

## Gráficos

### CPC

Para o CPC, o arquivo que gera os gráficos e tabelas é plot_bestVRFT3.m

### IPC

Para o IPC, plot_bestIPC_all.m
