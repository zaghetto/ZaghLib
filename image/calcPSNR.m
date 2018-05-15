function PSNRY  = calcPSNR(ImagemYUV, ImagemYUV_decod)

   
    PSNRY = 10*log10( (255^2 ) / (mean(  ( double(ImagemYUV) - double(ImagemYUV_decod) ).^2   ))  );
    
       
return

