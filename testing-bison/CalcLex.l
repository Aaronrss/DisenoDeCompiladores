%{
#include "CalcYacc.tab.h"
#include <stdio.h>
#include <stdlib.h>
int nl=0;
%}

%option noyywrap
espacios    [ \t]+
digito      [0-9]
%%

{espacios}	{/* se ignoran */}
"\n"		{ return FIN;}
"+"         { return MAS; }
"*"         { return POR; }
"("         { return PAR_IZQ; }
")"         { return PAR_DER; }
{digito}+	{ yylval.dval=atoi(yytext); return NUM; }
%%
