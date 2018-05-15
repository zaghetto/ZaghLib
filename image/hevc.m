function [result, Imagem_bmp_hevc, ImagemYUV_hevc, PSNRY_hevc, BpP, Tamanho_bin]  = hevc(NOMEDOARQUIVO, h, w, rgb, ImagemYUV, newh, neww, ARQCONFIG, QPISlice);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Alexandre Zaghetto                        %
% UnB - Universidade de Brasília                   %
% FT - Faculdade de Tecnologia                     %
% ENE - Departamento de Engenharia Elétrica        %
% GPDS - Grupo de Processamento Digital de Sinais  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Date: 2018-03-12                                 % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Encode and decode image using HEVC (HM 4.0)      %
% Working for gray images. Never tested for RGB    %
% images.                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1) The input for this function is the            % 
% name of a YUV file without the ".yuv" extension. % 
% 2) h and w are the original size of the image.   %                                                     
% 3) ImagemYUV is a padded image, newh and neww    %
%    are the new size of the image.                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Different combanation of encoders and decoder may be tested. Here HM 16.18

% [status, result] = system(['x265 --qp ' num2str(QPISlice) ' --log-level 0 --fps 1 --rd 5 --input-depth 8 --input-csp i420 --tune psnr --psnr --profile main --bframes 0 --preset placebo -o ' ...
%                NOMEDOARQUIVO '.265 ' NOMEDOARQUIVO '.yuv --input-res ' num2str(w) 'x' num2str(h)]);

% Encode
[status, result] = system(['TAppEncoder -c encoder_intra_main.cfg --SEIDecodedPictureHash --Level'...
                          ' -i ' NOMEDOARQUIVO '.yuv' ...
                          ' -o ' NOMEDOARQUIVO '_recon_hevc.yuv' ...
                          ' -b ' NOMEDOARQUIVO '.265'... 
                          ' -wdt ' num2str(neww) ...
                          ' -hgt ' num2str(newh)...                                                    
                          ' -fr 2'...  
                          ' -f 1'...  
                          ' -q ' num2str(QPISlice)]);

% Size of H.265 file
Info_Img_bin = dir([NOMEDOARQUIVO '.265']);
Tamanho_bin = Info_Img_bin.bytes; % Em bytes

% Bitrate
BpP = 8*Tamanho_bin/(h*w);

% Decode with ffmeg
% [status, result_decod] = system(['ffmpeg -loglevel quiet -i ' NOMEDOARQUIVO '.265 -pix_fmt yuv420p ' NOMEDOARQUIVO '_decoded_hevc.yuv 2>NUL']);

% Decode
[status,result_decod] = system(['TAppDecoder -b ' NOMEDOARQUIVO '.265 -d 8'...
                               ' -o ' NOMEDOARQUIVO '_decoded_hevc.yuv']);
                                                                             
% Load decoded YUV file and transform back to RGB.
[Imagem_bmp_hevc, ImagemYUV_hevc] = loadYUV2RGB([NOMEDOARQUIVO '_decoded_hevc.yuv'], h, w, newh, neww, rgb);

% Calculate PSNR
ImagemYUV = double(ImagemYUV);
ImagemYUV_hevc = double(ImagemYUV_hevc);
PSNRY_hevc = calcPSNR(ImagemYUV(1:h*w), ImagemYUV_hevc(1:h*w));     

return



