function rgb = EhRGB(Imagem_bmp)

[h, w, z] = size(Imagem_bmp);

rgb = (z == 3);

return