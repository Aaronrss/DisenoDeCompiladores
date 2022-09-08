/* Declaraciones */

%{
  #include<math.h> 
%}

%option noyywrap

letra [a-zA-Z]
digito [0-9]
 

%%

if			printf("res if\n");
for			printf("res for\n");
{letra}{letra}*		printf("ID Lexema: %s\n", yytext);
{digito}		printf("Digito Lexema: %s Valor: %i\n", yytext,atoi(yytext));
{digito}+		printf("Numero lexema: %s Valor: %i\n", yytext,atoi(yytext));
.			ECHO;

%%

int main(void){
	yylex();
}
