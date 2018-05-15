function writeyuv(filename,Y,U,V)
%WRITEYUV - Escreve arquivos de video no formato yuv (raw).
%    writeyuv(filename,Y) escreve a matriz de luminancia Y no
%    arquivo filename.
%   
%    writeyuv(filename_in,Y,U,V) escreve o video descrito pelas matrizes Y,
%    U e V no arquivo filename.
%
%    Eduardo Peixoto F. Silva.
%    eduardopfs@gmail.com
%    Edson Mintsu Hung
%    mintsu@gmail.com

%nargin 0, 1
if (nargin < 2)
    disp('Parametros de entrada insuficientes.')
    disp('A funcao writeyuv necessita de pelo menos 2 parametros de entrada.')
    return
end
%nargin = 2
if (nargin == 2)
    luma_only = 1;
end
%nargin = 3
if (nargin == 3)
    disp('Numero de parametros invalido.')
    return
end
%nargin = 4
if (nargin == 4)
    [wy hy ny] = size(Y);
    [wu hu nu] = size(U);
    [wv hv nv] = size(V);
    
    luma_only = 0;
    
    if (ny ~= nu | ny ~= nv | nu ~= nv)
        disp('As matrizes de entrada nao tem o mensmo numero de frames.')
        return
    end
    
    if (hu ~= hv | wu ~= wv)
        disp('As matrizes de crominancia nao tem o mesmo temanho.')
        return
    end
end
    

%Abre o arquivo.
arquivo = fopen(filename,'w');

[h w nframes] = size(Y);

for n = 1:nframes
    
    for j = 1:h
        for i = 1:w            
            fwrite(arquivo,Y(j,i,n),'uint8');            
        end
    end
    
    if (luma_only == 0)
        for j = 1:h/2
            for i = 1:w/2
                fwrite(arquivo,U(j,i,n),'uint8');
            end
        end
        
        for j = 1:h/2
            for i = 1:w/2
                fwrite(arquivo,V(j,i,n),'uint8');
            end
        end
    end

end

fclose(arquivo);