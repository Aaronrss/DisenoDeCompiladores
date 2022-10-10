%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
void yyerror(char *s);
int yyparse();
%}

%token program id tipo endVars endAsigns valor end pyc eq
%start S

%%
S: 	ENCABEZADO DECLARAVARIABLES ASIGNACIONES FINAL { printf("S => E D A F \n");}
	;
	
ENCABEZADO: program id			{ printf("E => program id\n");}
	 	;

DECLARAVARIABLES: VARIABLE LISTAVARS 	{ printf("D => V LV\n"); }
		;
 
VARIABLE: tipo id pyc			{ printf("V => tipo id;\n"); }
		;

LISTAVARS : DECLARAVARIABLES 		{ printf("LV => D\n"); }
		| endVars pyc 		{ printf("LV => endVars;\n"); }
		| endVars program 	{ yyerror("se esperaba ';'\n");}
		| endVars id 		{ yyerror("se esperaba ';'\n");}
		| endVars tipo 		{ yyerror("se esperaba ';'\n");}
		| endVars endVars 	{ yyerror("se esperaba ';'\n");}
		| endVars endAsigns 	{ yyerror("se esperaba ';'\n");}
		| endVars valor		{ yyerror("se esperaba ';'\n");}
		| endVars end		{ yyerror("se esperaba ';'\n");}
		| endVars eq		{ printf("Se esperaba ;"); }
		;


ASIGNACIONES: ASIGNA LISTAASIGNS	{ printf("A => As LA\n"); }
		;

ASIGNA: id eq valor pyc			{ printf("As => id = valor;\n"); }
		;

LISTAASIGNS : ASIGNACIONES 		{ printf("LA => A\n"); }
		| endAsigns pyc 		{ printf("LA => endAsigns;\n"); }
		;

FINAL : end id				{ printf("F => end id\n"); }
		;

%%

void yyerror(char *s) {
  printf("%s\n",s);
  exit(1);
}

int main(void) {
  yyparse();
  printf("0 errores");
}

