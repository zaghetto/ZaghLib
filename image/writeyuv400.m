function writeyuv400(Y, fileName, width, height, fheight, fwidth)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alexandre Zaghetto                               %
% zaghetto@unb.br                                  %
% University of Brasília                           % 
% Department of Computer Science                   %
% Laboratory of Images, Signals and Acoustics      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Writes 4:0:0 image as 4:2:0 YUV file.            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file
fid = fopen(fileName,'w');

% New width and height
neww = width*fwidth;
newh = height*fheight;

U = uint8(128*ones(newh,neww));
V = uint8(128*ones(newh,neww));

fwrite(fid,Y','uchar');
fwrite(fid,U','uchar');
fwrite(fid,V','uchar');

fclose(fid);

end

