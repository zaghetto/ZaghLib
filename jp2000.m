function [PSNRY_JP2, Ganho, BpP, Tamanho_JP2, Imagem_bmp_JP2] = jp2000(FILENAME, TaxaKadu)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alexandre Zaghetto                               %
% zaghetto@unb.br                                  %
% University of Brasília                           %
% Department of Computer Science                   %
% Laboratory of Images, Signals and Acoustics      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Encode image using the JPEG2000 algorithm.       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Remove extension
NOMEDOARQUIVO = removeExt(FILENAME);

% Load file to be encoded
Imagem_bmp = imread(FILENAME);
[h,w,z] = size(Imagem_bmp);

% Size of original image
Info_Img_Original = dir(FILENAME);
Tamanho_orig = Info_Img_Original.bytes; % Em Kbytes

% Verify if image os RGB of gray
rgb = EhRGB(Imagem_bmp);

% Convert image to ppm (RGB) or pgm (gray).
if rgb
    Arquivo_original = [NOMEDOARQUIVO '.ppm'];
    imwrite(Imagem_bmp, Arquivo_original ,'ppm');
else
    Arquivo_original = [NOMEDOARQUIVO '.pgm'];
    imwrite(Imagem_bmp, Arquivo_original ,'pgm');
end

% Encode image uisng kakadu
[status,result] = system(['kdu_compress'...
    ' -i ' Arquivo_original...
    ' -o ' NOMEDOARQUIVO '.j2c'...
    ' Cuse_sop=yes'...
    ' Cuse_eph=yes'...
    ' Creversible=no'...
    ' Cmodes=RESTART'...
    ' Qderived=yes'...
    ' -rate ' num2str(TaxaKadu)]);

% Size of JPEG2000 encoded image
Info_Img_JP2 = dir([NOMEDOARQUIVO '.j2c']);
Tamanho_JP2 = Info_Img_JP2.bytes;

% Compression gain
Ganho = Tamanho_orig/Tamanho_JP2;
BpP = 8*Tamanho_JP2/(h*w);

% Decode image
if rgb
    [status,result] = system(['kdu_expand'...
        ' -i ' NOMEDOARQUIVO '.j2c'...
        ' -o ' NOMEDOARQUIVO '_jpeg2000_kakadu.ppm']);
    
    Imagem_bmp_JP2 = imread([NOMEDOARQUIVO '_jpeg2000_kakadu.ppm']);
    delete('*.ppm');
else
    [status,result] = system(['kdu_expand'...
        ' -i ' NOMEDOARQUIVO '.j2c'...
        ' -o ' NOMEDOARQUIVO '_jpeg2000_kakadu.pgm']);
    
    Imagem_bmp_JP2 = imread([NOMEDOARQUIVO '_jpeg2000_kakadu.pgm']);
    delete('*.pgm');
end

% Delete encoded file
delete('*.j2c');

% Calculate PSNR
PSNRY_JP2 = calcPSNR(Imagem_bmp(:), Imagem_bmp_JP2(:));



return



