/******************************************************************************
 * Assignment:  A2, Análisis Léxico
 * 
 * Author:	Maximiliano Sapien, Rodrigo Marquez y Aaron Rosas
 * Language:  C, GNU Compiler Collection (GCC)
 * To Compile:  gcc [filename.c] -o [compiledfilename]
 * 
 * Class:	Diseño de Compiladores
 * Instructor:  Dra. Maricel Quinta Lópex
 * Due Date:  9/09/22
 * 
 * ****************************************************************************
 * 
 * Description:	El programa debe encontrar tokens
 * 
 * Input:	Solicitar nombre del archivo txt a procesar
 * 
 * Output:  Al encontrarse un token se debe imprimir el mismo, el Lexema, y número de línea en que se encontró el token.
 * 
 * Algorithm:  OUTLINE THE APPROACH USED BY THE PROGRAM TO SOLVE THE PROBLEM.
 * 
 * Required Features Not Included:  DESCRIBE HERE ANY REQUIREMENTS OF THE ASSIGNMENT THAT THE PROGRAM DOES NOT ATTEMPT TO SOLVE.
 * 
 * Known Bugs:  IF THE PROGRAM DOES NOT FUNCTION CORRECTLY IN SOME SITUATIONS, DESCRIBE THE SITUATIONS AND PROBLEMS HERE.
 ******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_LINE_LENGTH 120

//	Constantes
char tokens[8][5]={"OPREL","ASIG","OPAR","ID","ENT","REAL","ERR"};
char tOprel[8][4]={"LT", "LE", "GT", "GE", "EQ", "NE", "ASIG", "NEG"};
char tAsig[2][2]={"="};
char tOpar[9][2]={"+", "-", "*", "/", "%", "**", "++", "--"};
char tId[8][4]={"LT", "LE", "GT", "GE", "EQ", "NE", "ASIG", "NEG"};
char lexema[80];  //lexema: palabra que casa con el patrón
int indLexema=0;


void printTokLex(int nTok){
	lexema[indLexema]='\0';
	printf("Token: %s, Lexema: %s\n",tOprel[nTok],lexema);
	indLexema=0;
}

// Identificar token
void tok(char line[MAX_LINE_LENGTH], int lineCounter){
	int ind=0;
	int lineLen;
	int edo=0;
	int numToken;
	lineLen = strlen(line);
	printf("Linea: %d Tamaño: %d Cadena: %s",lineCounter,lineLen-1,line);
	while(ind < lineLen){
		switch(edo){
			case 0:
				switch(line[ind]){
					case '<':
						edo = 1;
						lexema[indLexema++]='<';
						break;
					case '>':
						edo = 2;
						lexema[indLexema++]='>';
						break;
					case '=':
						edo = 3;
						lexema[indLexema++]='=';
						break;
					case '!':
						edo = 4;
						lexema[indLexema++]='!';
						break;
					default:
						printf("Error %c\n",line[ind]);
						edo=0;
						break;
				}
				ind++;
				break;
			case 1:
				if(line[ind]=='='){
					lexema[indLexema++]='=';
					printTokLex(1);
					ind++;
				}
				else{
					printTokLex(0);
				}
				edo=0;
				break;
			case 2:
				if(line[ind]=='='){
					lexema[indLexema++]='=';
					printTokLex(3);
					ind++;
				}
				else{
					printTokLex(2);
				}
				edo=0;
				break;
			case 3:
				if(line[ind]=='='){
					lexema[indLexema++]='=';
					printTokLex(4);
					ind++;
				}
				else{
					printTokLex(6);
				}
				edo=0;
				break;
			case 4:
				if(line[ind]=='='){
					lexema[indLexema++]='=';
					printTokLex(5);
					ind++;
				}
				else{
					printTokLex(7);
				}
				edo=0;
				break;
		}
	}
}

//	Leer txt
int readFile(void){
	FILE *textfile;
	char line[MAX_LINE_LENGTH];
	int lineCounter=0;

	textfile = fopen("test.txt","r");
	if(textfile == NULL){
		perror("Error opening file");
		return(-1);
	}
	//	Leer linea por linea
	while(fgets(line, MAX_LINE_LENGTH, textfile)){
		tok(line,++lineCounter);
	}
	fclose(textfile);
	return 0;
}

// Main
// falta preguntar por el nombre del archivo
int main(void){
	readFile();
	return 0;
}
