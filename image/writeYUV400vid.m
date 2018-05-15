function writeYUV400vid(NOMEDOARQUIVO, Y, U, V, Np)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alexandre Zaghetto                               %
% zaghetto@unb.br                                  %
% University of Brasília                           % 
% Department of Computer Science                   %
% Laboratory of Images, Signals and Acoustics      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Writes 4:0:0 video as 4:2:0 YUV file.            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

YUVfile = fopen([NOMEDOARQUIVO '.yuv'], 'w');

for i = 1:Np
    fwrite(YUVfile, Y(:,:,i)','uint8');
    fwrite(YUVfile, U(:,:,i)','uint8');
    fwrite(YUVfile, V(:,:,1)','uint8');
end

fclose('all');

end