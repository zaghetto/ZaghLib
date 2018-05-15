function [PSNRY_JPEG, Ganho, BpP, Tamanho_JPG, Imagem_bmp_JPG] = jpeg(FILENAME, Q)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alexandre Zaghetto                               %
% zaghetto@unb.br                                  %
% University of Brasília                           % 
% Department of Computer Science                   %
% Laboratory of Images, Signals and Acoustics      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Encode image using the JPEG algorithm.           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Remove file extension
NOMEDOARQUIVO = removeExt(FILENAME);

% OPen file
Imagem_bmp = imread(FILENAME);
[h,w,z] = size(Imagem_bmp);

% Size in bytes of bmp file
Info_Img_Original = dir(FILENAME);
Tamanho_orig = Info_Img_Original.bytes; % Em Kbytes
                       
% Encode bmp image
[status,result] = system(['cjpeg'...
                          ' -quality ' num2str(Q) ...
                          ' -grayscale'...
                          ' -baseline' ...
                          ' -dct float'...
                          ' ' FILENAME...
                          ' ' NOMEDOARQUIVO '.jpg']);                                          
                      
% Size in bytes of jpeg file
Info_Img_JPG = dir([NOMEDOARQUIVO '.jpg']);
Tamanho_JPG = Info_Img_JPG.bytes;

% Compression gain
Ganho = Tamanho_orig/Tamanho_JPG;

% Bitrate
BpP = 8*Tamanho_JPG/(h*w);

% Decode jpeg image
[status,result] = system(['djpeg'...
                          ' -bmp '...
                          ' -grayscale'...
                          ' -dct float'...
                          ' ' NOMEDOARQUIVO '.jpg'...
                          ' ' NOMEDOARQUIVO '_jpeg.bmp']);

% Load decoded image. Function returns this image.
Imagem_bmp_JPG = imread([NOMEDOARQUIVO '_jpeg.bmp']);

% Calculate PSNR
PSNRY_JPEG = calcPSNR(Imagem_bmp(:), Imagem_bmp_JPG(:));

% Delete encoded and decoded files
eval(['delete ' NOMEDOARQUIVO '.jpg;']);
eval(['delete ' NOMEDOARQUIVO '_jpeg.bmp;']);

return



