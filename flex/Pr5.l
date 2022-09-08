%{
  #include<math.h>
  int words=0; 
  int nesp=0;
  int wordsline=0;
  int line=0;
%}

%option noyywrap
letra [a-zñA-ZÑ]
esp [ ]

%%
{letra}+ { words++; wordsline++;}
{esp}	nesp++;	
"\n"	{
         printf("%d palabras en la linea %d\n",wordsline, ++line);
         wordsline=0;
        }
<<EOF>> {printf("%d palabras en la linea %d\n",wordsline, ++line);
         yyterminate();
        }
%%
int main(void){
    yylex();
    printf("words: %d  espacios: %d lineas: %d\n", words,nesp,line);
    return 0;
}

