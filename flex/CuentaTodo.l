/* Declaraciones */
%{
    int numLineas=0;
    int numPalabras=0;
%}
%option noyywrap
/* Buscará la palabra amor y escribirá odio */

letra [a-zA-Z]
digito [0-9]

%%
{letra}+	{ numPalabras++;
            numCaracteres += strlen(yytext);
            };
"\n" { numLineas++; }

%%
int main(void){
   yylex();
   printf("Total de lineas: %i\n",numLineas);
   printf("Total de lineas: %i\n",numPalabras);
   printf("Total de lineas: %i\n",numCaracteres);

}
