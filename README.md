
Compile Bison with:
	bison -d -v fileName.y

Compile Flex with:
	flex fileName.l

Compile Both Result Files with:
	gcc lex.yy.c fileName.tab.c -o main 
