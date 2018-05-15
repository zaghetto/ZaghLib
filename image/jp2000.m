function [PSNRY_JP2, Ganho, BpP, Tamanho_JP2, Imagem_bmp_JP2] = jp2000(FILENAME,TaxaKadu);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Alexandre Zaghetto                        %
% Orientador: Ricardo L. de Queiroz                %
% UnB - Universidade de Brasília                   %
% FT - Faculdade de Tecnologia                     %
% ENE - Departamento de Engenharia Elétrica        %
% GPDS - Grupo de Processamento Digital de Sinais  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Função que codifica uma imagem utilizando o Kakadu (JPEG-2000)

% Nome do arquivo sem a extensão
NOMEDOARQUIVO = FILENAME(1:length(FILENAME)-4);

% Abre o arquivo indicado pelo usuario
Imagem_bmp = imread(FILENAME);
[h,w,z] = size(Imagem_bmp);

% Retorna o tamanho do arquivo bmp
Info_Img_Original = dir(FILENAME);
Tamanho_orig = Info_Img_Original.bytes; % Em Kbytes

% Verifica se a imagem aberta eh RGB ou Gray
EhRGB = isRGB(Imagem_bmp);

% Converte as imagens para ppm (cor) ou pgm (grayscale) para serem
% utilizadas pelo kakadu
if EhRGB
    Arquivo_original = [NOMEDOARQUIVO '.ppm'];
    imwrite(Imagem_bmp, Arquivo_original ,'ppm');
else
    Arquivo_original = [NOMEDOARQUIVO '.pgm'];
    imwrite(Imagem_bmp, Arquivo_original ,'pgm');
end
                        
% Codifica a imagem utilizando TaxaKadu
[status,result] = system(['kdu_compress'...
                          ' -i ' Arquivo_original...
                          ' -o ' NOMEDOARQUIVO '.j2c'...
                          ' Cuse_sop=yes'...
                          ' Cuse_eph=yes'...
                          ' Creversible=no'...
                          ' Cmodes=RESTART'...
                          ' Qderived=yes'...
                          ' -rate ' num2str(TaxaKadu)]);                     

% Retorna o tamanho do arquivo Jp2
Info_Img_JP2 = dir([NOMEDOARQUIVO '.j2c']);
Tamanho_JP2 = Info_Img_JP2.bytes;

% Determina o ganho de compressao
Ganho = Tamanho_orig/Tamanho_JP2;
BpP = 8*Tamanho_JP2/(h*w);

% Decodifica a imagem, convertendo-a para ppm (cor) ou pgm (grayscale)
if EhRGB
        [status,result] = system(['kdu_expand'...
                          ' -i ' NOMEDOARQUIVO '.j2c'...
                          ' -o ' NOMEDOARQUIVO '_jpeg2000_kakadu.ppm']);
                      
        Imagem_bmp_JP2 = imread([NOMEDOARQUIVO '_jpeg2000_kakadu.ppm']);
else
        [status,result] = system(['kdu_expand'...
                          ' -i ' NOMEDOARQUIVO '.j2c'...
                          ' -o ' NOMEDOARQUIVO '_jpeg2000_kakadu.pgm']); 
                      
        Imagem_bmp_JP2 = imread([NOMEDOARQUIVO '_jpeg2000_kakadu.pgm']);
end

PSNRY_JP2 = calcPSNR(Imagem_bmp(:), Imagem_bmp_JP2(:));

return



