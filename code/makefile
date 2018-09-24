# makefile for PL-NEXT-SYNTAX
# Author: Callum France
YFLAGS                = -d
# The name of the executable file used to check PL-NEXT syntax
PROGRAM               = PL-NEXT-SYNTAX
OBJS                  = y.tab.o lex.yy.o
SRCS                  = y.tab.c lex.yy.c
CC                    = gcc
all:                    $(PROGRAM)
.c.o:                   $(SRCS)
						$(CC) -c $*.c -o $@ -O
# Compilation of the Yacc files
y.tab.c:                pl-next.y
						yacc $(YFLAGS) pl-next.y
# Compilation of the Lex files
lex.yy.c:               pl-next.l
						flex pl-next.l
PL-NEXT-SYNTAX:         $(OBJS)
# Compilation of the final executable file PL-NEXT-SYNTAX
						$(CC) $(OBJS)  -o $@ -ll -lm
clean:;                 rm -f $(OBJS) core *~ \#* *.o $(PROGRAM) \
						y.* lex.yy.* y.tab.*
