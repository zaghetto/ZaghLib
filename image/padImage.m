function pI = padImage(I, blksize, rgb) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alexandre Zaghetto                               %
% zaghetto@unb.br                                  %
% University of Brasília                           % 
% Department of Computer Science                   %
% Laboratory of Images, Signals and Acoustics      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image padding.                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Perform padding with blocks of blksize x blksize pixels
[h, w, z] = size(I);
newh = blksize*ceil(h/blksize);
neww = blksize*ceil(w/blksize);

% Verify if image is RGB
if rgb % Color
    pI = zeros(newh, neww, 3);
    pI(1:h, 1:w, 1:z) = I;
else    % Gray
    pI = zeros(newh, neww);
    pI(1:h,1:w) = I;    
end

return