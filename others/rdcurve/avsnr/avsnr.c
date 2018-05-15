/************************************************************************
*
*  avsnr.c
*
*  Telenor Broadband Services 
*  Keysers gate 13                        
*  N-0130 Oslo
*  Norway                  
*
************************************************************************/
#include <string.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>


void main(int argc,char **argv)
{
  FILE *fd;
  FILE *p_log;
  char snr_filename[100];
  float tmp;
  
  double xl,xh;// end points
  double diff[1];
  int mode;    // dsnr or percentage mode
 

  int J0=0;//SNR index
  int J1=1;//bitrate index

  double X[2][4];
   
  double Y[2][4];
  
  double E[4],F[4],G[4],H[4];
  double SUM[2];
  
  int ind[2];
  int i,j;
    
  double  DET0,DET1,DET2,DET3,DET;
  double  D0,D1,D2,D3;
  double  A[2],B[2],C[2],D[2], Coefs[8];

  if (argc != 2) 
  {
    printf("Usage: %s <snr.txt> \n",argv[0]);
    printf("<snr.txt> gives snr values and bitrates\n");
    printf("Format:\n");
    printf("snrA0  snrA1  snrA2  snrA3 \n");
    printf("birtA0 bitrA1 bitrA2 bitrA3 \n");
    printf("snrB0  snrB1  snrB2  snrB3 \n");
    printf("birtB0 bitrB1 bitrB2 bitrB3 \n");


    exit(-1);
  }
  strcpy(snr_filename,argv[1]);
  
  if((fd=fopen(snr_filename,"r")) == NULL){
      printf("Error: Input file %s not found\n",snr_filename);
      exit(0);
  } 
  else{  
    printf("--------------------------------------------------------------------------\n");
    printf(" SNR input file               : %s \n",snr_filename);
    printf("--------------------------------------------------------------------------\n");
    printf(" Computing average differance of 2 datasets: ok.\n");
   
  }
  
  fscanf(fd,"%d",&mode);      // read mode 0=DSNR 1=Percentage
  fscanf(fd,"%*[^\n]");         // new line 

  
  for(i=0;i<4;i++){
    fscanf(fd,"%f",&tmp);      // first 4 SNR values
    if(mode==0)
      Y[0][i]=tmp;
    else
      X[0][i]=tmp;
    }
  fscanf(fd,"%*[^\n]");         // new line 
  
  for(i=0;i<4;i++){             // first 4 bitrate values
    fscanf(fd,"%f,",&tmp);
    if(mode==0)
      X[0][i]=log(tmp);
    else
      Y[0][i]=log(tmp);
  }
  fscanf(fd,"%*[^\n]");  

  for(i=0;i<4;i++){
    fscanf(fd,"%f,",&tmp);
    if(mode==0)
      Y[1][i]=tmp;
    else
      X[1][i]=tmp;

  }
  fscanf(fd,"%*[^\n]");
  
  for(i=0;i<4;i++){
    fscanf(fd,"%f,",&tmp);
    if(mode==0)
      X[1][i]=log(tmp);
    else
      Y[1][i]=log(tmp);
  }
  fscanf(fd,"%*[^\n]");  


  xl=max(X[J0][0],X[J1][0]);
  xh=min(X[J0][3],X[J1][3]);
  ind[0]=J0;
  ind[1]=J1;
  
  
  for (j=0;j<2;j++){

    for (i=0;i<4;i++){   
		
      E[i]=X[ind[j]][i];            
      F[i]=E[i]*E[i];         
     
      G[i]=E[i]*E[i]*E[i];
      H[i]=Y[ind[j]][i];
	  
    }

    DET0= E[1]*(F[2]*G[3]-F[3]*G[2])-E[2]*(F[1]*G[3]-F[3]*G[1])+E[3]*(F[1]*G[2]-F[2]*G[1]);
    DET1=-E[0]*(F[2]*G[3]-F[3]*G[2])+E[2]*(F[0]*G[3]-F[3]*G[0])-E[3]*(F[0]*G[2]-F[2]*G[0]);
    DET2= E[0]*(F[1]*G[3]-F[3]*G[1])-E[1]*(F[0]*G[3]-F[3]*G[0])+E[3]*(F[0]*G[1]-F[1]*G[0]);
    DET3=-E[0]*(F[1]*G[2]-F[2]*G[1])+E[1]*(F[0]*G[2]-F[2]*G[0])-E[2]*(F[0]*G[1]-F[1]*G[0]);
    DET=DET0+DET1+DET2+DET3;

     
    D0=H[0]*DET0+H[1]*DET1+H[2]*DET2+H[3]*DET3;
    
    
    D1=
      H[1]*(F[2]*G[3]-F[3]*G[2])-H[2]*(F[1]*G[3]-F[3]*G[1])+H[3]*(F[1]*G[2]-F[2]*G[1])-
      H[0]*(F[2]*G[3]-F[3]*G[2])+H[2]*(F[0]*G[3]-F[3]*G[0])-H[3]*(F[0]*G[2]-F[2]*G[0])+
      H[0]*(F[1]*G[3]-F[3]*G[1])-H[1]*(F[0]*G[3]-F[3]*G[0])+H[3]*(F[0]*G[1]-F[1]*G[0])-
      H[0]*(F[1]*G[2]-F[2]*G[1])+H[1]*(F[0]*G[2]-F[2]*G[0])-H[2]*(F[0]*G[1]-F[1]*G[0]);
 
    D2=
      E[1]*(H[2]*G[3]-H[3]*G[2])-E[2]*(H[1]*G[3]-H[3]*G[1])+E[3]*(H[1]*G[2]-H[2]*G[1])-
      E[0]*(H[2]*G[3]-H[3]*G[2])+E[2]*(H[0]*G[3]-H[3]*G[0])-E[3]*(H[0]*G[2]-H[2]*G[0])+
      E[0]*(H[1]*G[3]-H[3]*G[1])-E[1]*(H[0]*G[3]-H[3]*G[0])+E[3]*(H[0]*G[1]-H[1]*G[0])-
      E[0]*(H[1]*G[2]-H[2]*G[1])+E[1]*(H[0]*G[2]-H[2]*G[0])-E[2]*(H[0]*G[1]-H[1]*G[0]);
   
    D3=
      E[1]*(F[2]*H[3]-F[3]*H[2])-E[2]*(F[1]*H[3]-F[3]*H[1])+E[3]*(F[1]*H[2]-F[2]*H[1])-
      E[0]*(F[2]*H[3]-F[3]*H[2])+E[2]*(F[0]*H[3]-F[3]*H[0])-E[3]*(F[0]*H[2]-F[2]*H[0])+
      E[0]*(F[1]*H[3]-F[3]*H[1])-E[1]*(F[0]*H[3]-F[3]*H[0])+E[3]*(F[0]*H[1]-F[1]*H[0])-
      E[0]*(F[1]*H[2]-F[2]*H[1])+E[1]*(F[0]*H[2]-F[2]*H[0])-E[2]*(F[0]*H[1]-F[1]*H[0]);
   
    A[j]=D0/DET;
    B[j]=D1/DET;
    C[j]=D2/DET;
    D[j]=D3/DET;
      
    SUM[j]=A[j]*(xh-xl)+B[j]*(xh*xh-xl*xl)/2+C[j]*(xh*xh*xh-xl*xl*xl)/3+D[j]*(xh*xh*xh*xh-xl*xl*xl*xl)/4;
	   
  } 

  
  diff[0]=(SUM[1]-SUM[0])/(xh-xl);
  
  if(mode==1) diff[0]=(exp(diff[0])-1)*100;
  
	  Coefs[0] = A[0];
	  Coefs[1] = B[0];
	  Coefs[2] = C[0];
	  Coefs[3] = D[0];
	  Coefs[4] = A[1];
	  Coefs[5] = B[1];
	  Coefs[6] = C[1];
	  Coefs[7] = D[1];
    
  /*
  write to file
  */
  
  /* Modificações realizadas
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Alexandre Zaghetto (zaghetto@image.unb.br) %                       
% Orientador: Ricardo L. de Queiroz                 %
% UnB - Universidade de Brasília                    % 
% FT - Faculdade de Tecnologia                      % 
% ENE - Departamento de Engenharia Elétrica         % 
% GPDS - Grupo de Processamento Digital de Sinais   % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 Alterou-se apenas a forma como os resultados são armazenados nos 
 arquivos ".dat". O objetico é disponibilizar os coeficientes e o cálculo da
 diferença média para ser lido pelo MATLAB.                                                     
  
*/
  
  p_log = fopen("log.dat","w");

  fprintf(p_log,"%6.4f %6.4f %6.4f %6.4f \n", Coefs[0], Coefs[1], Coefs[2], Coefs[3]);
  fprintf(p_log,"%6.4f %6.4f %6.4f %6.4f ", Coefs[4], Coefs[5], Coefs[6], Coefs[7]);
  fclose( p_log );

  p_log = fopen("diff.dat","w");
  fprintf(p_log,"%6.2f", diff[0]);
  fclose( p_log );

}

