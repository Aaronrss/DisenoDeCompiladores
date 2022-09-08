#include <stdio.h>
#include <string.h>

char tokens[8][4]={"LT", "LE", "GT", "GE", "EQ", "NE", "ASIG", "NEG"};
//                  0    1      2     3    4      5     6       7
char lexema[80];  //lexema: palabra que casa con el patrón
int indLexema=0;

char cadena[80]={"<x>; <= a == x >= ) !="};
// token oprel <|>|<=|>=|==|!=
// token LT GT LE GE EQ NE ASIG
// token OPREL, lexema <=


void imprimeTokLex(int nT){
    lexema[indLexema]='\0';
    printf("Token: %s, Lexema: %s\n",tokens[nT],lexema);
    indLexema=0;
}

/* char tokens[8][5]={"LT", "LE", "GT", "GE", "EQ", "NE", "ASIG", "NEG"};
                       0    1      2     3    4      5     6       7    */

int main(void){
int ind=0;  // indice de la cadena
int n;      // n número de caracteres en cadena
int edo=0;  // edo es el estado del autómata
int numToken; //indica el número de token que se está reconociendo
    printf("%s\n",cadena);
    n = strlen(cadena);  //n  tiene el tamaño de la línea
    printf("%d",n);
    while(ind < n){
        switch(edo){
        case 0:
            switch(cadena[ind]){
                case '<':
                    edo = 1;
                    lexema[indLexema++]='<';
                    break;
                case '>':
                    edo = 2;
                    lexema[indLexema++]='>';
                    break;
                case '=':
                    edo = 3;
                    lexema[indLexema++]='=';
                    break;
                case '!':
                    edo = 4;
                    lexema[indLexema++]='!';
                    break;
                default:
                    printf("Error %c\n",cadena[ind]);
                    edo=0; break;
            }
            ind++;
            break;
/* char tokens[8][5]={"LT", "LE", "GT", "GE", "EQ", "NE", "ASIG", "NEG"};
                       0    1      2     3    4      5     6       7    */

        case 1: //llevo < debo determinar si es < o <=
            if(cadena[ind]=='='){
                lexema[indLexema++]='=';
                imprimeTokLex(1);
                ind++;
            }
            else{
                imprimeTokLex(0);
            }
            edo=0;
            break;
        case 2:
            if(cadena[ind]=='='){
                lexema[indLexema++]='=';
                imprimeTokLex(3);
                ind++;
            }
            else{
                imprimeTokLex(2);
            }
            edo=0;
            break;
        case 3: // ya llevaba =, debo revisar si es asig o comp
            if(cadena[ind]=='='){
                lexema[indLexema++]='=';
                imprimeTokLex(4);
                ind++;
            }
            else{
                imprimeTokLex(6);
            }
            edo=0;
            break;
        case 4: //ya se reconocion ! falta ver si es !=
            if(cadena[ind]=='='){
                lexema[indLexema++]='=';
                imprimeTokLex(5);
                ind++;
            }
            else{
                imprimeTokLex(7);
            }
            edo=0;
            break;
        }
    }
    return 0;
}




