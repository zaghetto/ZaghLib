function [Y,U,V] = readyuv(filename_in, w, h, nframes, luma_only ,upsample , filename_out)
%READYUV - Le arquivos de video no formato yuv (raw).
%   function [Y,U,V] = readyuv(filename_in, w, h, nframes, luma_only ,upsample , filename_out)
%
%   Y = readyuv(filename_in,w,h) le um frame do arquivo filename_in, de tamanho w x h, e retorna 
%       na variavel Y apenas a matriz de luminancia.
%
%   Y = readyuv(filename_in,w,h,nframes) le nframes frame do arquivo filename_in, de tamanho w x h,
%       e retorna na variavel Y apenas a matriz de luminancia.
%
%   [Y,U,V] = readyuv(filename_in,w,h, nframes, 0) le nframes do arquivo filename_in, de tamanho 
%       w x h, e retorna nas variaveis Y, U e V as matrizes de luminancia e
%       crominancia.
%
%   readyuv(filename_in,w,h) le um frame do arquivo filename_in, de tamanho w x h, e 
%       salva no arquivo filename_out = ['output_' filename_in '.mat'] o
%       frame de luminancia. 
%
%   Outros parametros que podem ser utilizados: 
%       nframes - numero de frames que serao lidos do arquivo filename_in.
%           Padrao: nframes = 1.
%       luma_only - indica se apenas os componentes de luminancia deve ser
%           lidos (luma_only = 1) ou se os componentes de crominancia serao
%           lidos (luma_only = 0). Padrao: luma_only = 1. Para o caso de 
%           frames no formato do tipo 4:0:0 o luma_only = 2.
%       upsample - indica se os frames de crominancia serao interpolados,
%           gerando uma matriz de tamanho w x h (upsample = 1), ou se eles 
%           nao serao interpolados, gerando a matriz de tamanho w/2 x h/2
%           (upsample = 0). Padrao: upsample = 0.
%       filename_out - indica se as variaveis Y, U e V serao salvas neste
%           arquivo. Padrao: filename_out = ['output_' filename_in '.mat'].
%
%    Eduardo Peixoto F. Silva.
%    eduardopfs@gmail.com
%    Edson Mintsu Hung
%    mintsu@gmail.com

%Numero de Parametros = 0,1 ou 2.
if (nargin <3)
    disp('Numero de argumentos insuficiente.')
    disp('A funcao readyuv precisa de ao menos 3 argumentos.')
    return
end

%Numero de Parametros = 3.
if nargin == 3
    if (isstr(filename_in) == 0)
        disp('Erro: o parametro filename_in deve ser uma string.')
        return
    end
    nframes = 1;
    luma_only = 1;
    upsample = 0;
    salvar = 0;
    filename_out = ['output_' filename_in '.mat'];
end

%Numero de Parametros = 4.
if nargin == 4
    if (isstr(filename_in) == 0)
        disp('Erro: o parametro filename_in deve ser uma string.')
        return
    end
    luma_only = 1;
    upsample = 0;
    salvar = 0;
    filename_out = ['output_' filename_in '.mat'];
end

%Numero de Parametros = 5.
if nargin == 5
    if (isstr(filename_in) == 0)
        disp('Erro: o parametro filename_in deve ser uma string.')
        return
    end
%     if ((luma_only ~= 0) || (luma_only ~= 2) )
%         luma_only = 1;
%     end
    upsample = 0;
    salvar = 0;
    filename_out = ['output_' filename_in '.mat'];
end

%Numero de Parametros = 6.
if nargin == 6
    if (isstr(filename_in) == 0)
        disp('Erro: o parametro filename_in deve ser uma string.')
        return
    end
    if (luma_only ~= 0) || (luma_only ~= 2) 
        luma_only = 1;
    end
    if (upsample ~= 0) || (luma_only ~= 2) 
        upsample = 1;
    end
    salvar = 0;
    filename_out = ['output_' filename_in '.mat'];
end

%Numero de Parametros = 7.
if nargin == 7
    salvar = 1;
    if (isstr(filename_in) == 0)
        disp('Erro: o parametro filename_in deve ser uma string.')
        return
    end
    if (isstr(filename_out) == 0)
        disp('Erro: o parametro filename_in deve ser uma string.')
        return
    end
    if (luma_only ~= 0) || (luma_only ~= 2) 
        luma_only = 1;
    end    
    if (upsample ~= 0) || (luma_only ~= 2) 
        upsample = 1;
    end
end

%Abre o arquivo.
arquivo = fopen(filename_in,'r');
img = fread(arquivo,'uint8=>uint8');
fclose(arquivo);

%Le os dados referentes a Luminancia.
if (luma_only ~= 2)
    Luma = zeros(1,w*h*nframes);
    for n = 1:nframes
        for i = 1:w*h
            a = (3*w*(h/2)*(n-1));
            b = (w*h*(n-1));
            Luma(1,i+b) = img(i+a);
        end
    end
else
    Luma(1,1:w*h*(nframes)) = img(1:w*h*(nframes));
end

%Le os dados referentes a Crominancia
if (luma_only == 0)
    
    ChromaU = zeros(1,w*h*nframes/4);
    ChromaV = zeros(1,w*h*nframes/4);    
    
    for n = 1:nframes
        for i = 1:w/2*h/2
            a = ((w*h*n)+(1/2*w*h*(n-1)));
            b = (w/2*h/2*(n-1));
            ChromaU(1,i+b) = img(i+a);
            
            c = ((5/4*w*h*n)+(1/4*w*h*(n-1)));
            d = (w/2*h/2*(n-1));
            ChromaV(1,i+d) = img(i+c);
        end        
    end
end

%Monta os frames de Luminancia.
Y = zeros(h,w,nframes);
for n = 1:nframes
    m = (w*h*(n-1));

    for i = 1:w
        for j = 1:h
            Y(j,i,n) = Luma(1,(j-1)*w+i+m);
        end
    end
end
Y = uint8(Y);

%Monta os frames de Crominancia.
if (luma_only == 0)

    u = zeros(h/2,w/2,nframes);
    v = zeros(h/2,w/2,nframes);

    if (upsample == 1)
        U = zeros(h,w,nframes);
        V = zeros(h,w,nframes);    
    end
    
    for n = 1:nframes
        m = (w*h*(n-1));
        
        for i = 1:w/2
            for j = 1:h/2
                u(j,i,n) = ChromaU(1,(j-1)*w/2+i+m/4);
                
                v(j,i,n) = ChromaV(1,(j-1)*w/2+i+m/4);
            end
        end
        
        if (upsample == 1)            
            U(:,:,n) = imresize(u(:,:,n),2,'bicubic');
            V(:,:,n) = imresize(v(:,:,n),2,'bicubic');            
        end
        
    end
    
    if (upsample == 0)
        U = u;
        V = v;
    end 
    
    U = uint8(U);
    V = uint8(V);
end

%Montando as matrizes de saida.
if (salvar == 1)
    if (luma_only == 1)
        save(filename_out,'Y');
    else
        save(filename_out,'Y','U','V');
    end
end

if nargout == 0
    disp(['Salvando os dados no arquivo ' filename_out ' .'])
    if (luma_only == 1)
        save(filename_out,'Y');
    else
        save(filename_out,'Y','U','V');
    end
end
if nargout == 1
    Y = Y; 
end
if (nargout == 2 || nargout == 3)
    Y = Y;
    if (luma_only == 1)
        U = [];
        V = [];
    end
end   