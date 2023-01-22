CC = gcc
OBJFILES = lex.yy.o y.tab.o VSM.o

SOURCE_DIR = ./source

Calc : ${OBJFILES}
	${CC} y.tab.c -ly -o Calc

VSM.o: $(SOURCE_DIR)/VSM.c $(SOURCE_DIR)/VSM.h
	$(CC) -c -o VSM.o $(SOURCE_DIR)/VSM.c

lex.yy.o: lex.yy.c y.tab.h

lex.yy.c: $(SOURCE_DIR)/express.l
	flex -l $(SOURCE_DIR)/express.l

y.tab.o: y.tab.c $(SOURCE_DIR)/VSM.h

y.tab.c y.tab.h: $(SOURCE_DIR)/express.y
	bison -dv -y $(SOURCE_DIR)/express.y



