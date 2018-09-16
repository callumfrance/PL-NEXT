YFLAGS        = -d
PROGRAM       = PLNEXT
OBJS          = y.tab.o lex.yy.o
SRCS          = y.tab.c lex.yy.c
CC            = gcc
all:            $(PROGRAM)
.c.o:           $(SRCS)
				$(CC) -c $*.c -o $@ -O
y.tab.c:        first_one.y
				yacc $(YFLAGS) first_one.y
lex.yy.c:       first_one.l
				flex first_one.l
PLNEXT:         $(OBJS)
				$(CC) $(OBJS)  -o $@ -lfl -lm
clean:;         rm -f $(OBJS) core *~ \#* *.o $(PROGRAM) \
				y.* lex.yy.* y.tab.*
