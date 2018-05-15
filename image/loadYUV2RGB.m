function [Imagem_bmp_decod, ImagemYUV_decod] = loadYUV2RGB(ImagemYUV, h, w, newh, neww, rgb)

% Load decoded YUV image
fid = fopen(ImagemYUV,'r');
ImagemYUV_decod = fread(fid,'uint8=>uint8'); 
fclose(fid);

ImagemYUV_decod = ImagemYUV_decod';

% Transforma a imagem YUV decodificada em BMP
Imagem_bmp_decod = yuv2rgb(ImagemYUV_decod, newh, neww, rgb);

if rgb
    % 4:2:0
    Imagem_bmp_decod = Imagem_bmp_decod(1:h, 1:w, 1:3);
else
    % 4:0:0 com Cb e Cr = 128
    Imagem_bmp_decod = Imagem_bmp_decod(1:h, 1:w, 1);
end

return
