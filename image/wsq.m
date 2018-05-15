function [Imagem_RAW_WSQ, PSNR_WSQ, BpP_WSQ, Tamanho_WSQ] = wsq(Image, NOMEDOARQUIVO, rate)

% Image size
[h, w] = size(Image);

% Encode raw file
system(['cwsq ' num2str(rate) ' wsq ' NOMEDOARQUIVO '.raw -r '  num2str(w) ',' num2str(h) ',8,500']);

% Decode wsq
system(['dwsq rec_raw ' NOMEDOARQUIVO '.wsq -r']);

% Size of wsq file
Info_Img_WSQ = dir([NOMEDOARQUIVO '.wsq']);
Tamanho_WSQ = Info_Img_WSQ.bytes; % bytes
BpP_WSQ = 8*Tamanho_WSQ/(h*w);

% Read decoded image
fid_rec = fopen([NOMEDOARQUIVO '.rec_raw'], 'rb');
DataRec = fread(fid_rec, h*w, 'uint8');
fclose(fid_rec);

% Construct image
Imagem_RAW_WSQ = vec2mat(DataRec, w);

% Calculate PSNR
PSNR_WSQ = calcPSNR(Image(:), Imagem_RAW_WSQ(:));

return