%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Alexandre Zaghetto (zaghetto@image.unb.br) %                        
% Orientador: Ricardo L. de Queiroz                 %
% UnB - Universidade de Brasília                    %
% FT - Faculdade de Tecnologia                      %
% ENE - Departamento de Engenharia Elétrica         %
% GPDS - Grupo de Processamento Digital de Sinais   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: call rdcurvediff                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Clear screen
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%
% Parametros de entrada %
%%%%%%%%%%%%%%%%%%%%%%%%%

% Method
method = 0
%   method = 0: Average PSNR difference;
%   method = 1; Average bitrate difference;

% Titles
tituloPSNR = 'Average PSNR difference';
tituloTaxa = 'Average bitrate difference';

% Curve 1
bitrates1 = [ 0.2500    0.5000    0.7500    1.0000 ];
PSNRs1    = [44.6185   53.7880   60.5435   65.4666];
label1 = 'HEVC-INTER';  % Label for curve 1

% Curve 2
bitrates2 = [ 0.2500    0.5000    0.7500    1.0000];
PSNRs2    = [43.3482   53.3873   59.9172   64.7641];
label2 = 'HEVC-INTRA'; % Label for curve 2


%PSNRs2    = [36.3624   45.0724   51.0005   55.3760];
%label2 = 'JPEG2000'; % Label for curve 2

% Ajusta label para eixo x e para eixo y
labelx = 'bitrate (bits/pixel)';
labely = 'Average PSNR (dB)';

% Chama rdcurvediff (calcula a diferença média PSNR ou bitrate)
[Coefs, diff] = rdcurvediff(method, bitrates1, PSNRs1, bitrates2, PSNRs2,label1,label2, labelx, labely, tituloPSNR, tituloTaxa);









