%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<math.h>
#include<ctype.h>

void yyerror(char *s);
int yylex();
void add(char);
void insert_type();
int search(char *);
void insert_type();

struct dataType {
    char * id_name;
    char * data_type;
    char * type;
    int line_no;
} symbol_table[40];

int count = 0;
int q;
char type[10];
extern int line;
%}

%union{ int dval; char *sval; }

%token INICIO FIN MAS POR MENOS DIV MOD POTE MENOR MENORIGUAL MAYOR MAYORIGUAL IGUAL DIFERENTE AND OR ASIGN PAR_IZQ PAR_DER ESTRUCTURA ESTRUCTURA_TERMINA FUNCION FUNCION_TERMINA MIENTRAS MIENTRAS_TERMINA SI SINO SI_TERMINA TIPO_ENTERO TIPO_DECIMAL TIPO_CADENA TIPO_CARACTER TIPO_BOOLEANO ESTRUC_ID FUNC_ID VAR_ID ARR_ID COMMA LEER ESCRIBIR

%token <dval> NUM_ENTERO NUM_DECIMAL
%token <sval> VAL_BOOLEANO VAL_CADENA VAL_CARACTER
%left MAS
%left POR
%type <dval> Condicion Expr Term Factor 
%start S
%%

S: INICIO Lineas FIN {printf("S –> inicio Lineas fin (Compilacion exitosa) \n");}
    | INICIO Lineas {yyerror("Error de compilacion: Falta cerrar el programa. \n");}
    | Lineas FIN {yyerror("Error de compilacion: Falta abrir el programa. \n");}
    | Lineas {yyerror("Error de compilacion: Falta abrir y cerrar el programa. \n");}
;

Lineas: Linea {printf("Lineas –> Linea (Correcto) \n");}
    | Lineas Linea {printf("Lineas –> Lineas Linea (Correcto) \n");}
;

Bloque: Lineas {printf("Bloque –> Lineas (Correcto) \n");}
;

Linea: Estructura { printf("Linea –> Estructura (Correcto) \n"); }
    | Funcion { printf("Linea –> Funcion (Correcto) \n"); }
    | Mientras { printf("Linea –> Mientras (Correcto) \n"); }
    | Condicion { printf("Linea –> Condicion (Correcto) \n"); }
    | Si { printf("Linea –> Si (Correcto) \n"); }
    | Variable { printf("Linea –> Variable (Correcto) \n"); add('V'); }
    | Lectura { printf("Linea –> Lectura (Correcto) \n"); }
    | Escritura { printf("Linea –> Escritura (Correcto) \n"); }
    | Asignacion { printf("Linea –> Estructura (Correcto) \n"); }
    | Llamada { printf("Linea –> Estructura (Correcto) \n"); }
;

Estructura: ESTRUCTURA ESTRUC_ID Atributos ESTRUCTURA_TERMINA { printf("Estructura –> estructura ESTRUC_ID Atributos estructuraTermina (Correcto) \n"); }
    | ESTRUCTURA Atributos ESTRUCTURA_TERMINA Bloque ESTRUCTURA_TERMINA { yyerror("Error de compilación: La estructura no tiene nombre. (Error) \n"); }
    | ESTRUCTURA ESTRUC_ID Atributos { yyerror("Error de compilacion: La estructura no se cerro correctamente. (Error) \n"); }
    | ESTRUC_ID Atributos ESTRUCTURA_TERMINA { yyerror("Error de compilacion: La estructura no se abrio correctamente. (Error) \n"); }
    | ESTRUCTURA ESTRUC_ID ESTRUCTURA_TERMINA { yyerror("Error de compilacion: La estructura no tiene atributos. (Error) \n"); }
;

Atributos: Variable {printf("Atributos –> Variable (Correcto) \n");}
        | Atributos Variable {printf("Atributos –> Atributos Variable (Correcto) \n");}
;

Funcion: FUNCION FUNC_ID PAR_IZQ Parametros PAR_DER Bloque FUNCION_TERMINA {printf("Funcion –> funcion FUNC_ID ( Parametros ) Bloque funcionTermina (Correcto) \n");}
    | FUNCION FUNC_ID PAR_IZQ PAR_DER Bloque FUNCION_TERMINA { printf("Funcion –> funcion FUNC_ID ( ) Bloque funcionTermina (Correcto) \n"); }
    | FUNCION PAR_IZQ Parametros PAR_DER Bloque FUNCION_TERMINA { yyerror("Error de compilacion: La funcion no tiene nombre. (Error) \n"); }
    | FUNCION PAR_IZQ PAR_DER Bloque FUNCION_TERMINA { yyerror("Error de compilacion: La funcion no tiene nombre. (Error) \n"); }
    | FUNCION FUNC_ID Parametros PAR_IZQ PAR_DER Bloque { yyerror("Error de compilación: La funcion no se cerro correctamente. (Error) \n"); }
    | FUNCION FUNC_ID PAR_IZQ PAR_DER Bloque { yyerror("Error de compilacion: La funcion no se cerro correctamente. (Error) \n"); }
    | FUNC_ID PAR_IZQ Parametros PAR_DER Bloque FUNCION_TERMINA { yyerror("Error de compilacion: La funcion no se abrio correctamente. (Error) \n"); }
    | FUNC_ID PAR_IZQ PAR_DER Bloque FUNCION_TERMINA { yyerror("Error de compilacion: La funcion sin parametros no se abrio correctamente. (Error) \n"); }
;

Mientras: MIENTRAS PAR_IZQ Condicion PAR_DER Bloque MIENTRAS_TERMINA { printf("Mientras –> mientras ( Condicion ) Bloque mientrasTermina (Correcto) \n"); }
        | MIENTRAS PAR_IZQ Condicion PAR_DER Bloque { yyerror("Error de compilacion: El ciclo no se cerro correctamente. (Error) \n"); }
        | MIENTRAS PAR_IZQ Condicion Bloque MIENTRAS_TERMINA { yyerror("Error de compilacion: Se esperaba un parentesis que cierra. (Error) \n"); }
        | MIENTRAS PAR_IZQ PAR_DER Bloque MIENTRAS_TERMINA { yyerror("Error de compilacion: Se esperaba una condicion. (Error) \n"); }
        | MIENTRAS Condicion PAR_DER Bloque MIENTRAS_TERMINA { yyerror("Error de compilacion: SE ESPERABA un parentesis que abre. (Error) \n"); }
        | PAR_IZQ Condicion PAR_DER Bloque MIENTRAS_TERMINA { yyerror("Error de compilacion: El ciclo no se abrio correctamente. (Error) \n"); }
;

Si: SI PAR_IZQ Condicion PAR_DER Bloque SINO Bloque SI_TERMINA { printf("Si –> si ( Condicion ) Bloque sino Bloque siTermina (Correcto) \n"); }
    | SI PAR_IZQ Condicion PAR_DER Bloque SI_TERMINA { printf("Si –> si ( Condicion ) Bloque siTermina (Correcto) \n"); }
    | SI PAR_IZQ Condicion PAR_DER Bloque SINO Bloque { yyerror("Error de compilacion: El ciclo no se cerro correctamente. (Error) \n"); }
    | SI PAR_IZQ Condicion Bloque SINO Bloque SI_TERMINA { yyerror("Error de compilacion: Se esperaba un parentesis que cierra. (Error) \n"); }
    | SI PAR_IZQ PAR_DER Bloque SINO Bloque SI_TERMINA { yyerror("Error de compilacion: Se esperaba una condicion. (Error) \n"); }
    | SI Condicion PAR_DER Bloque SINO Bloque SI_TERMINA { yyerror("Error de compilacion: SE ESPERABA un parentesis que abre. (Error) \n"); }
    | PAR_IZQ Condicion PAR_DER Bloque SINO Bloque SI_TERMINA { yyerror("Error de compilacion: El ciclo no se abrio correctamente. (Error) \n"); }
    | SI PAR_IZQ Condicion PAR_DER Bloque { yyerror("Error de compilacion: El ciclo no se cerro correctamente. (Error) \n"); }
    | SI PAR_IZQ Condicion Bloque SI_TERMINA { yyerror("Error de compilacion: Se esperaba un parentesis que cierra. (Error) \n"); }
    | SI PAR_IZQ PAR_DER Bloque SI_TERMINA { yyerror("Error de compilacion: Se esperaba una condicion. (Error) \n"); }
    | SI Condicion PAR_DER Bloque SI_TERMINA { yyerror("Error de compilacion: SE ESPERABA un parentesis que abre. (Error) \n"); }
    | PAR_IZQ Condicion PAR_DER Bloque SI_TERMINA { yyerror("Error de compilacion: El ciclo no se abrio correctamente. (Error) \n"); }
;


Condicion: Expr IGUAL Expr { $$ = $1 == $3; printf("Condicion –> Expr == Expr (Correcto) \n"); }
    | Expr DIFERENTE Expr { $$ = $1 != $3; printf("Condicion –> Expr != Expr (Correcto) \n"); }
    | Expr MAYORIGUAL Expr { $$ = $1 >= $3; printf("Condicion –> Expr >= Expr (Correcto) \n"); }
    | Expr MAYOR Expr { $$ = $1 > $3; printf("Condicion –> Expr > Expr (Correcto) \n"); }
    | Expr MENORIGUAL Expr { $$ = $1 <= $3; printf("Condicion –> Expr <= Expr (Correcto) \n"); }
    | Expr MENOR Expr { $$ = $1 < $3; printf("Condicion –> Expr < Expr (Correcto) \n"); }
    | Condicion AND Condicion { $$ = $1 && $3; printf("Condicion –> Condicion && Condicion (Correcto) \n"); }
    | Condicion OR Condicion { $$ = $1 || $3; printf("Condicion –> Condicion || Condicion (Correcto) \n"); }
    | Expr { $$ = $1; printf("Condicion –> Expr (Correcto) \n"); }
;


Expr: Expr MAS Term { $$ = $1 + $3; printf("Expr –> Expr + Term (Correcto) \n"); }
    | Expr MENOS Term { $$ = $1 - $3; printf("Expr –> Expr - Term (Correcto) \n"); }
    | Term { $$ = $1; printf("Expr –> Term (Correcto) \n"); }
;

Term: Term POR Factor { $$ = $1 * $3; printf("Term –> Term * Factor (Correcto) \n"); }
    | Term DIV Factor { $$ = $1 / $3; printf("Term –> Term / Factor (Correcto) \n"); }
    | Term MOD Factor { $$ = $1 % $3; printf("Term –> Term mod Factor (Correcto) \n"); }
    | Term POTE Factor { $$ = pow($1, $3); printf("Term –> Term ^ Factor (Correcto) \n"); }
    | Factor { $$ = $1; printf("Term –> Factor (Correcto) \n"); }
;

Factor: PAR_IZQ Condicion PAR_DER { $$ = $2; printf("Factor –> ( Condicion ) (Correcto) \n"); }
    | NUM_ENTERO { $$ = $1; printf("Factor –> NUM_ENTERO (Correcto) \n"); }
    | NUM_DECIMAL { $$ = $1; printf("Factor –> NUM_DECIMAL (Correcto) \n"); }
    | VAR_ID { printf("Factor –> ID (Correcto) \n"); }
;

Variable: Tipo VAR_ID ASIGN Expr { printf("Variable –> Tipo VAR_ID = Expr (Correcto) \n"); }
    | Tipo VAR_ID ASIGN VAL_BOOLEANO { printf("Variable –> Tipo VAR_ID = VAL_BOOLEANO (Correcto) \n"); }
    | Tipo VAR_ID ASIGN VAL_CADENA { printf("Variable –> Tipo VAR_ID = VAL_CADENA (Correcto) \n"); }
    | Tipo VAR_ID ASIGN VAL_CARACTER { printf("Variable –> Tipo VAR_ID = VAL_CARACTER (Correcto) \n"); }
    | Tipo VAR_ID { printf("Variable –> Tipo VAR_ID (Correcto) \n"); }
    | Tipo VAR_ID ASIGN { yyerror("Error de compilacion: Se esperaba un valor para asignar. (Error) \n"); }
    | Arreglo { printf("Variable –> Arreglo (Correcto) \n"); }
;


Tipo: TIPO_ENTERO { printf("Tipo –> entero (Correcto) \n"); add('V'); }
    | TIPO_DECIMAL { printf("Tipo –> decimal (Correcto) \n"); add('V'); }
    | TIPO_BOOLEANO { printf("Tipo –> booleano (Correcto) \n"); add('V'); }
    | TIPO_CADENA { printf("Tipo –> cadena (Correcto) \n"); add('V'); }
    | TIPO_CARACTER { printf("Tipo –> caracter (Correcto) \n"); add('V'); }
;

Arreglo: Tipo ARR_ID PAR_IZQ NUM_ENTERO PAR_DER { printf("Arreglo declarado de tipo: ")};


Llamada: FUNC_ID PAR_IZQ Parametros PAR_DER { printf("Llamada –> FUNC_ID ( Parametros ) (Correcto) \n"); }
    | FUNC_ID PAR_IZQ PAR_DER { printf("Llamada –> FUNC_ID () (Correcto) \n"); }
    | FUNC_ID PAR_IZQ Parametros { yyerror("Error de compilacion: Se esperaba un parentesis que cierra. (Error) \n"); }
    | FUNC_ID Parametros PAR_DER { yyerror("Error de compilacion: Se esperaba un parentesis que abre. (Error) \n"); }
    | FUNC_ID PAR_IZQ { yyerror("Error de compilacion: Se esperaba un parentesis que cierra. (Error) \n"); }
    | FUNC_ID PAR_DER { yyerror("Error de compilacion: Se esperaba un parentesis que abre. (Error) \n"); }
    | FUNC_ID { yyerror("Error de compilacion: Se esperaba un parentesis que abre y cierra. (Error) \n"); }

;


Parametros: Parametros COMMA Llamada
    | Parametros COMMA Condicion
    | Parametros COMMA VAL_CADENA
    | Parametros COMMA VAL_CARACTER
    | Parametros COMMA ESTRUC_ID
    | VAL_CADENA
    | VAL_CARACTER
    | ESTRUC_ID
    | Llamada
    | Condicion
;

Asignacion: VAR_ID ASIGN Expr { printf("Asignacion –> VAR_ID = Expr (Correcto) \n"); }
    | VAR_ID ASIGN Llamada { printf(" Asignacion –> VAR_ID = Llamada (Correcto) \n"); }
    | VAR_ID ASIGN Lectura { printf(" Asignacion –> VAR_ID = Lectura (Correcto) \n"); }
    | VAR_ID ASIGN  { printf("Error de compilacion: Se esperaba un valor para asignar. (Error) \n"); }
;

Lectura: LEER PAR_IZQ  PAR_DER { printf("Lectura –> leer ( ) (Correcto) \n"); }
;


Escritura: ESCRIBIR PAR_IZQ VAL_CADENA PAR_DER { printf("Escritura –> escribir ( ) (Correcto) \n") }
;

%%

void yyerror(char *s) {
  printf("%sError en linea: %d\n",s,line);
  exit(1);
}

int main(void) {
  yyparse();
  printf("0 errores");
  printf("\nSYMBOL   DATATYPE   TYPE   LINE NUMBER \n");
    printf("_______________________________________\n\n");
  int i=0;
    for(i=0; i<count; i++) {
        printf("%s\t%s\t%s\t%d\t\n", symbol_table[i].id_name, symbol_table[i].data_type, symbol_table[i].type, symbol_table[i].line_no);
    }
    for(i=0;i<count;i++) {
        free(symbol_table[i].id_name);
        free(symbol_table[i].type);
    }
    printf("\n\n");
}
int search(char *type) {
    int i;
    for(i=count-1; i>=0; i--) {
        if(strcmp(symbol_table[i].id_name, type)==0) {
            return -1;
            break;
        }
    }
    return 0;
}
void add(char c) {
  q=search(yylex);
  if(!q) {
        if(c == 'V') {
            symbol_table[count].id_name=strdup(yylex);
            symbol_table[count].data_type=strdup(type);
            symbol_table[count].line_no=line;
            symbol_table[count].type=strdup("Variable");
            count++;
        }
    }
}
void insert_type() {
    strcpy(type, yylex);
}