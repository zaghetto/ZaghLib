function [YUV, h2, w2] = rgb2yuv(Imagem, rgb)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alexandre Zaghetto                               %
% zaghetto@unb.br                                  %
% University of Brasília                           % 
% Department of Computer Science                   %
% Laboratory of Images, Signals and Acoustics      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RGB to YUV 4:2:0.                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Imagem YUV
[h, w, z] = size(Imagem);

% Size of U and V matrix
h2 = 2*ceil(h/2);
w2 = 2*ceil(w/2);

if rgb
    
    % RGB2YUV transformation
    T = [0.299 0.587 0.114; -0.168736 -0.331264 0.5000; 0.5000 -0.418688 -0.081312];
        
    % Copy original image to image with new dimensions        
    IResize = ones(h2, w2, 3);
    IResize(1:h, 1:w, :) = Imagem(1:h, 1:w, 1:3);    
    IResize = double(IResize);
    
    % Separate color channels
    r = IResize(:,:,1);
    g = IResize(:,:,2);
    b = IResize(:,:,3);
    
    r = r(:);
    g = g(:);
    b = b(:);
    
    % Convert to YUV
    Y  = [r g b]*T(1,:)';
    Y  = vec2mat(Y, h2)';            
    UU = [r g b]*T(2,:)'+128;
    UU = vec2mat(UU, h2)';
    VV = [r g b]*T(3,:)'+128;
    VV = vec2mat(VV, h2)';   
    
    U = zeros(h2/2, w2/2);
    V = zeros(h2/2, w2/2);

    % Filter U and V before subsampling
    hf = fspecial('average', 2);
    U = imfilter(UU, hf);
    U = U(1:2:end, 1:2:end);
    V = imfilter(VV, hf);
    V = V(1:2:end, 1:2:end);    
           
else
    
    % If image if gray, U and V will be set yo 128
    Y = Imagem;
    U = 128*ones(h2/2, w2/2);
    V = 128*ones(h2/2, w2/2);        
    
end

% Represent matrices as vectores
Y = Y';
Y = uint8(Y(:));
U = U';
U = uint8(U(:));
V = V';
V = uint8(V(:));

% Final YUV data
YUV = [Y; U; V]';


return

    
    
    
    
    
    
    
    
    
    
    
    
    
    