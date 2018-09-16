YFLAGS        = -d
PROGRAM       = PL-NEXT
OBJS          = y.tab.o lex.yy.o
SRCS          = y.tab.c lex.yy.c
CC            = gcc
all:            $(PROGRAM)
.c.o:           $(SRCS)
				$(CC) -c $*.c -o $@ -O
y.tab.c:        pl-next.y
				yacc $(YFLAGS) pl-next.y
lex.yy.c:       pl-next.l
				flex pl-next.l
PL-NEXT:         $(OBJS)
				$(CC) $(OBJS)  -o $@ -ll -lm
clean:;         rm -f $(OBJS) core *~ \#* *.o $(PROGRAM) \
				y.* lex.yy.* y.tab.*
