/* Declaraciones */
%{
/* Lo que yo coloque aquí se copiara tal cual en el código */
%}
%option noyywrap

vocal [a|e|i|o|u]

%%
f{vocal} printf("");
%%

/* USER CODE SECTION */
int main(void){
   yylex();
}
