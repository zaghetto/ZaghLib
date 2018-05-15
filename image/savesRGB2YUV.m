function [ImagemYUV, newh, neww] = savesRGB2YUV(FILENAME, blksize, rgb)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alexandre Zaghetto                               %
% zaghetto@unb.br                                  %
% University of Brasília                           % 
% Department of Computer Science                   %
% Laboratory of Images, Signals and Acoustics      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Converts image from RGB to YUV and saves it.     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Remove file extension
NOMEDOARQUIVO = FILENAME(1:length(FILENAME)-4);

% Open file
Imagem_bmp = imread(FILENAME);

% Padding with block size of 16
Imagem_bmp_padd = padImage(Imagem_bmp, blksize, rgb);

% This function converts only to 4:2:0. Must be updated.
[ImagemYUV, newh, neww] = rgb2yuv(Imagem_bmp_padd, rgb); 

% Save files
YUVfile = fopen([NOMEDOARQUIVO '.yuv'], 'w');
fwrite(YUVfile, ImagemYUV, 'uint8');
fclose('all');

return