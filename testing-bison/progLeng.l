%{
#include "progLeng.tab.h"
#include <stdio.h>
#include <stdlib.h>
int nl=0;
%}

%option noyywrap
espacios	[ \t]+
letra		[a-zA-Z]
digito		[0-9]
%%

{espacios}	{/* se ignoran */}

"\n"		{ nl++;  }

program				{ //printf("%s\n",yytext);
				  return(program); 
				}

end				{ //printf("%s\n",yytext);
				  return(end); 
				}

int 				{ //printf("%s\n",yytext);
				  return(tipo); 
				}

float 				{ //printf("%s\n",yytext);
				  return(tipo); 
				}

";"				{ return(pyc); }
"="				{ return(eq); }

endVars				{ //printf("%s\n",yytext);
				    return(endVars); 
				}

endAsigns			{ //printf("%s\n",yytext);
				    return(endAsigns); 
				}

{letra}({letra}|{digito})*	{ //printf("%s\n",yytext);
				    return(id); 
				}

{digito}+(\.{digito}+)?		{ //printf("%s\n",yytext);
				    return(valor); 
				}


%%

int main(){
	yylex();
	return 0;
}