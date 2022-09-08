/* Declaraciones */
%{ int numLineas=0;
%}
%option noyywrap
/* Buscará la palabra amor y escribirá odio */

letra [a-zA-Z]
digito [0-9]

%%
ito 		printf("OTE");
{letra}+	printf("Token Palabra, Lexema %s\n",yytext);
{digito}+	printf("Token Entero, Lexema %s\n", yytext);
"<"		printf("Token OpRel, Lexema %s\n", yytext);
"<="		printf("Token OpRel, Lexema %s\n", yytext);
">"		printf("Token OpRel, Lexema %s\n", yytext);
">="		printf("Token OpRel, Lexema %s\n", yytext);
"=="		printf("Token OpRel, Lexema %s\n", yytext);
"!="		printf("Token OpRel, Lexema %s\n", yytext);
{digito}+(\.{digito}+)?	printf("Token Real, Lexema %s\n",yytext);
"\n" { numLineas++; }

%%
int main(void){
   yylex();
   printf("Total de lineas: %i\n",numLineas);
}
