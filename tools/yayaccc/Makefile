# Makefile for yayaccc 
# Wei Tong

GCC	= gcc
CFLAGS	= -g
OUTPUT	= yayaccc 

LEX	= flex 
YACC	= bison
YFLAGS	= -d -v 

default: syn.tab.c lex.yy.c main.c tree.c xml.c
	$(GCC) -O2 $(CFLAGS) syn.tab.c  main.c tree.c xml.c -lfl -ly  -o $(OUTPUT)

syn.tab.c: syn.y lex.l
	$(YACC) $(YFLAGS) syn.y

lex.yy.c: lex.l 
	$(LEX) -o lex.yy.c lex.l

clean:
	rm -f $(OUTPUT) lex.yy.c syn.tab.h syn.tab.c syn.output *.o
all: 
	make clean
	make

