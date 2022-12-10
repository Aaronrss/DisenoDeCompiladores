%{
#include "grammar.tab.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
int line=1;
%}

%option noyywrap
espacio    [ \t]
digito      [0-9]
letra       [a-zA-Z]
%%

"\n"		{ line++; }
{espacio}+	{/* se ignoran */}

"inicio" { return INICIO; }
"fin" { return FIN; }
"estructura" { return ESTRUCTURA; }
"estructuraTermina" { return ESTRUCTURA_TERMINA; }
"funcion" { return FUNCION; }
"funcionTermina" { return FUNCION_TERMINA; }
"mientras" { return MIENTRAS; }
"mientrasTermina" { return MIENTRAS_TERMINA; }
"si" { return SI; }
"sino" { return SINO; }
"siTermina" { return SI_TERMINA; }
"entero" { return TIPO_ENTERO; }
"decimal" { return TIPO_DECIMAL; }
"cadena" { return TIPO_CADENA; }
"caracter" { return TIPO_CARACTER; }
"booleano" { return TIPO_BOOLEANO; }
"leer" { return LEER; }
"escribir" { return ESCRIBIR; }

"+"         { return(MAS); }
"-"         { return(MENOS); }
"*"         { return(POR); }
"/"         { return(DIV); }
"%"         { return(MOD); }
"**"        { return(POTE); }
"=="        { return(IGUAL); }
"noes"      { return(DIFERENTE); }
">="        { return(MAYORIGUAL); }
">"         { return(MAYOR); }
"<="        { return(MENORIGUAL); }
"<"         { return(MENOR); }
"yy"        { return(AND); }
"oo"        { return(OR); }
"="         { return(ASIGN); }
"("         { return(PAR_IZQ); }
")"         { return(PAR_DER); }
","         { return(COMMA); }

e{letra}+e { yylval.sval=yytext; return ESTRUC_ID; }
f{letra}+f    { yylval.sval=yytext; return FUNC_ID; }
v{letra}+v    { yylval.sval=yytext; return VAR_ID; }
a{letra}+a    { yylval.sval=yytext; return ARR_ID; }
{digito}+	{ yylval.dval=atoi(yytext); return NUM_ENTERO; }
{digito}+"."{digito}+	{ yylval.dval=atof(yytext); return NUM_DECIMAL; }
"falso"|"verdadero"	{ yylval.sval=yytext; return VAL_BOOLEANO; }
"\""{letra}"\""     { yylval.sval=yytext; return VAL_CARACTER; }
"\""{letra}+"\""	{ yylval.sval=yytext; return VAL_CADENA; }

%%