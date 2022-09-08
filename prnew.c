#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_LINE_LENGTH 120

char lexema[80];
int indLexema=0;

void imprimeTokLex(){
    lexema[indLexema]='\0';
    printf("Lexema: %s\n",lexema);
    indLexema=0;
}

void tok(char line[MAX_LINE_LENGTH], int lineCounter){
	int ind=0;
	int lineLen;
	int edo=0;
	int numToken;
	lineLen = strlen(line);
	printf("Linea: %d Tamaño: %d Cadena: %s",lineCounter,lineLen-1,line);
    while(ind < lineLen){
        int ascii = line[ind];
        printf("Ascii: %d Char: %c\n",ascii, line[ind]);
        if(ascii >= 65 && ascii <= 90 || ascii >= 97 && ascii <= 122){
            lexema[indLexema++]=line[ind];
            int ascii2 = line[ind+1];
            if(ascii2 >= 65 && ascii2 <= 90 || ascii2 >= 97 && ascii2 <= 122 || ascii2 >= 48 && ascii2 <= 57){
                lexema[indLexema++]=line[++ind];
                printf("Es un ID de letras y numeros");
            }

            printf("Es una ID de letras %c\n",line[ind]);
        }
        else if (ascii >= 48 && ascii <= 57)
        {
            printf("Es un digito");
        }
        else if (ascii >= 60 && ascii <= 62){
            printf("Es un mayor o igual %c\n",line[ind]);
        }
        else if(ascii == 42 || ascii == 43 || ascii == 45 || ascii == 47 || ascii == 37){
            printf("Es un OPAR %c\n",line[ind]);
        }
        else{
            printf("Es un salto de linea o espacio\n");
        }
        imprimeTokLex();
        ind++;
    }
}

//	Leer txt
int readFile(void)
{
	FILE *textfile;
	char line[MAX_LINE_LENGTH];
	int lineCounter = 0;

	textfile = fopen("test.txt", "r");
	if (textfile == NULL)
	{
		perror("Error opening file");
		return (-1);
	}
	//	Leer linea por linea
	while (fgets(line, MAX_LINE_LENGTH, textfile))
	{
		tok(line, ++lineCounter);
	}
	fclose(textfile);
	return 0;
}

// Main
// falta preguntar por el nombre del archivo
int main(void)
{
	readFile();
	return 0;
}
