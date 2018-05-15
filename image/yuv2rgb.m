function RGB = yuv2rgb(ImagemYUV, h, w, rgb)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alexandre Zaghetto                               %
% zaghetto@unb.br                                  %
% University of Brasília                           % 
% Department of Computer Science                   %
% Laboratory of Images, Signals and Acoustics      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YUV 4:2:0 to RGB.                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize Y, U and V as vectors
Y = zeros(1,w*h);
U = zeros(1,w*h/4);
V = zeros(1,w*h/4);

% Take values from ImagemYUV
Y = double(ImagemYUV(1:w*h));
U = double(ImagemYUV((1+w*h):(w*h+w*h/4)));
V = double(ImagemYUV((1+w*h+w*h/4):(w*h+w*h/2)));

% Represent Y, U and V as matrices
U = vec2mat(U, w/2)';
U = imresize(U,2,'bicubic');
V = vec2mat(V, w/2)';
V = imresize(V,2,'bicubic');

% Check if image was originaly RGB
if rgb

    % Transformation matrix
    T = [1 0 1.4020; 1 -0.344136 -0.714136; 1 1.772 0];
    
    % Represent U and V as vectors
    U = U(:);
    V = V(:);
    
    % Y, U and V channels to R, G and B
    R = ([Y' U-128 V-128])*T(1,:)';
    G = ([Y' U-128 V-128])*T(2,:)';
    B = ([Y' U-128 V-128])*T(3,:)';
    
    % Represent vectors as a matrices and concatenate color channels
    RGB(:,:,1) = vec2mat(R, w);
    RGB(:,:,2) = vec2mat(G, w);
    RGB(:,:,3) = vec2mat(B, w);
    
    % Crop color levels
    RGB(RGB<0) = 0;
    RGB(RGB>2^8-1) = 2^8-1;
    
    RGB = uint8(RGB);
    
else
    
    RGB = uint8(vec2mat(Y, w));
    
end


return












