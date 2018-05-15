function [Imagem_bmp_h264, ImagemYUV_h264, PSNRY_h264, BpP_h264, Tamanho_bytes] = avc(NOMEDOARQUIVO, h, w, rgb, ImagemYUV, newh, neww, QPISlice)

% Encode using H.264
[status, result] = system(['x264 --qp ' num2str(QPISlice) ' --input-csp i420 --tune psnr --psnr --verbose --profile high --bframes 0 --preset placebo -o ' ...
    NOMEDOARQUIVO '.264 ' NOMEDOARQUIVO '.yuv --input-res ' num2str(neww) 'x' num2str(newh)]);

% Decode using H.264
[status, result_decod] = system(['ldecod -i '  NOMEDOARQUIVO '.264'...
    ' -o '  NOMEDOARQUIVO '_decoded_h264.yuv']);

% Calculate rate
Info_Img_h264 = dir([ NOMEDOARQUIVO '.264']);
Tamanho_bytes = Info_Img_h264.bytes;
BpP_h264 = 8*Tamanho_bytes/(h*w); % In bytes
                                                                  
% Transforma a imagem YUV decodificada em BMP
[Imagem_bmp_h264, ImagemYUV_h264] = loadYUV2RGB([NOMEDOARQUIVO '_decoded_h264.yuv'], h, w, newh, neww, rgb);

% Calculate PSNR
ImagemYUV = double(ImagemYUV);
ImagemYUV_h264 = double(ImagemYUV_h264);

PSNRY_h264 = calcPSNR(ImagemYUV(1:h*w), ImagemYUV_h264(1:h*w)); 


return
