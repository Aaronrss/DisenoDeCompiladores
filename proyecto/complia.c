#include <stdio.h>
#include <stdlib.h>

int sigToken(){

}
int token;

void msgerr(int tipo){
    switch(tipo){
        case 0: printf("Error: El programa empieza con "); break;
        case 1: printf("Se esperaba un id\n"); break;
        case 2: printf("Se esperaba un punto y coma\n"); break;
        case 3: printf("Se esperaba el token program\n"); break;
        case 4: printf("Se esperaba un tipo o envvars\n"); break;
    }
    system("pause");
    exit(1);
}

void encabezado(){
    token=sigToken();
    if(token==)

}

void variable(void)
{
    token = sigToken();
    if (token == tipo)
    {
        token = sigToken();
        if (token == identificador)
        {
            token = sigToken();
            if (token == puntoycoma)
            {
                token = sigToken();
                variable();
            }
            else
            {
                msgerr(2);
            }
        }
        else
        {
            msgerr(1);
        }
    }
    else
    {
        error("Se esperaba un tipo de dato");
    }
}

void listaVariables(void){
    token=sigToken();
    if (token==tipo){
        declaraciones();
    }
    else{
        if (token==endVars)
        {
            token=sigToken();
            if(token==puntoycoma){
                token=sigToken();
            }
            else{
                msgerr(2);
            }
        }
        else{
            msgerr(4);
        }
    }
}

void declaraciones(void){
    variable();
    listaVariables;
}

int main(){
    encabezado();

}

// analisis sintactico y ejercicio en bison
// opcion multiple, analisis sintáctico
// quiz
// parte practica en papel
// bison no da tiempo
// el lunes 31 de mayo
