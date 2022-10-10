/* Declaraciones */
%{
/* Lo que yo coloque aquí se copiara tal cual en el código */
%}
%option noyywrap


%%

select|SELECT printf("Token SELECT , Lexema %s VALIDO\n",yytext);
from|FROM printf("Token FROM , Lexema %s VALIDO\n",yytext);
where|WHERE printf("Token WHERE , Lexema %s  VALIDO\n",yytext);
and|AND printf("Token AND , Lexema %s VALIDO\n",yytext);

-?[0-9]+                printf("Token DIGITO, Lexema %s VALIDO\n",yytext);
-?[0-9]+"."[0-9]* |
-?"."[0-9]+             printf("Token DIGITO REAL: %s VALIDO\n",yytext);

"<"     printf("Token OpRel, Lexema %s VALIDO \n",yytext);
"<="    printf("Token OpRel, Lexema %s VALIDO \n",yytext);
">"     printf("Token OpRel, Lexema %s VALIDO \n",yytext);
">="    printf("Token OpRel, Lexema %s VALIDO \n",yytext);
"="     printf("Token OpRel, Lexema %s VALIDO \n",yytext);
"<>"    printf("Token OpRel, Lexema %s VALIDO \n",yytext);

[A-Za-z][A-Za-z0-9_]*   printf("Token CAMPO: Lexema %s VALIDO\n",yytext);

[A-Za-z][A-Za-z0-9_]*|"*"   printf("Token TABLA: Lexema %s VALIDO\n",yytext);

[A-Za-z][A-Za-z0-9_]*" "[<=|>=|<>|<|>|=]" "-?[0-9]+|-?[0-9]+"."[0-9]*|-?"."[0-9]+       printf("Token COMPARASIÓN, Lexema %s VALIDO\n",yytext);


%%

/* USER CODE SECTION */
int main(int argc, char *argv[])
{
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
}
