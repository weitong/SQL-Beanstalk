#
# File: Makefile
# Author: Wei Tong
# 
# IDENTIFICATION
#      sqlparser/Makefile


CC	= gcc
CFLAGS	= -g
OUTPUT	= gsql

LEX	= flex 
YACC	= bison
YFLAGS	= -d -v 

OBJS = gram.tab.o main.o tree.o xml.o memory.o keywords.o kwlookup.o

default: $(OBJS)
	$(CC) -o $(OUTPUT)  $(OBJS)

gram.tab.o: gram.tab.c scan.yy.c
	$(CC) $(CFLAGS) -c -lfl -ly gram.tab.c

main.o: main.c
	$(CC) $(CFLAGS) -c main.c

tree.o: tree.c
	$(CC) $(CFLAGS) -c tree.c

xml.o: xml.c
	$(CC) $(CFLAGS) -c xml.c

memory.o: memory.c
	$(CC) $(CFLAGS) -c memory.c

keywords.o: keywords.c
	$(CC) $(CFLAGS) -c keywords.c

kwlookup.o: kwlookup.c
	$(CC) $(CFLAGS) -c kwlookup.c

scan.yy.c: scan.l 
	$(LEX) -o scan.yy.c scan.l

gram.tab.c: gram.y
	$(YACC) $(YFLAGS) gram.y

clean:
	rm -f $(OUTPUT) scan.yy.c gram.tab.h gram.tab.c gram.output *.o *.exe.*
all: 
	make clean
	make

