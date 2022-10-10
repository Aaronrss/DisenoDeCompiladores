%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
void yyerror(char *s);
int yyparse();
%}

%union{ int dval; char *sval; }

%token MAS POR PAR_IZQ PAR_DER FIN
%token <dval> NUM
%left MAS
%left POR
%type <dval> Expr Term Factor

%start Lineas

%%

Lineas: Linea | Lineas Linea;

Linea: Expr FIN {printf("Resultado: %i\n", $1);};

Expr: Expr MAS Term {$$ = $1 + $3} | Term {$$ = $1};
Term: Term POR Factor {$$ = $1 * $3} | Factor {$$ = $1};
Factor: PAR_IZQ Expr PAR_DER {$$ = $2} | NUM {$$ = $1};

/* 
S: tokA A tokB  	{ printf("S->aAb\n"); }
   | B tokA A tokA	{ printf("S->BaAa\n"); }
 			;
	
A: tokA tokB	{ printf("A->ab\n"); }
  | tokB	{ printf("A->b\n"); }
	 	;
B: B tokB	{ printf("B->Bb\n"); }
  | tokB	{ printf("B->b\n"); }
	 	;

 */
%%

void yyerror(char *s) {
  printf("%s\n",s);
  exit(1);
}

int main(void) {
  yyparse();
  printf("0 errores");
}

