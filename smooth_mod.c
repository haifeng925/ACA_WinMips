#include <stdio.h>

#define N_SAMPLES 5
#define N_COEFFS 5

double sample[N_SAMPLES] = {1, 2, 1 ,2, 1};
double coeff[N_COEFFS] = {0.25, 0.5, 1, 0.5, 0.25};

double result[N_SAMPLES];


void smooth(double sample[], double coeff[], double result[], int n){

    int i, j;
    double norm1 = 0.0, norm2 = 0.0;

    /* for(i=0; i<N_COEFFS; i++){ */
    /*     if(coeff[i] > 0){ */
    /*         norm1 += coeff[i]; */
    /*     }else{ */
    /*         norm1 += (-coeff[i]); */
    /*     } */
    /* } */


    for(i=1; i<N_COEFFS-1; i++){
        if(coeff[i]>0){
            norm2 += coeff[i];
        }else{
            norm2 += (-coeff[i]);
        }
        
    }

    if(coeff[0] > 0){
        norm1 = norm2 + coeff[0];
    }else{
        norm1 = norm2 + (-coeff[0]);
    }

    int last = N_COEFFS-1;
    if(coeff[last] > 0){
        norm1 += coeff[last];
    }else{
        norm1 += (-coeff[last]);
    }

    for(i=0; i<n; i++){
        if( i==0 || i==n-1){
            result[i] = sample[i];
        }else if(i==1 || i==n-2){
            result[i] = 0.0;
            for(j=1; j<N_COEFFS-1; j++){
                result[i] += sample[i-2+j]*coeff[j];
            }
            result[i]/=norm2;
        }else{

            result[i]=0.0;
            for (j=0; j<N_COEFFS; j++)
                result[i] += sample[i-2+j]*coeff[j];
            result[i]/=norm1;
            
        }
    }

}



int main(int argc, char *arvg[]){

    int i;
    if(N_SAMPLES >= N_COEFFS)
        smooth(sample, coeff, result, N_SAMPLES);

    for(i=0; i<N_SAMPLES; i++)
        printf("%f\n", result[i]);
}
