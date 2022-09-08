/* Declaraciones */
%{
/* Lo que yo coloque aquí se copiara tal cual en el código */
%}
%option noyywrap

vocal [a|e|i|o|u]

%%
{vocal} printf("%sf%s",yytext,yytext);
%%

/* USER CODE SECTION */
int main(void){
   yylex();
}
