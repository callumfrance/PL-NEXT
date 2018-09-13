%{
#include<stdio.h>
%}

%union {
	long value;
}

%type <value> expression add_expr mul_expr
%token <value> NUMBER

%%
input:
	expression
	input expression
expression:
	expression '\n' { printf("%ld\n", $1); }
	expression '+' add_expr { $$ = $1 + $3; }
	expression '-' add_expr { $$ = $1 - $3; }
	add_expr { $$ = $1; }
add_expr:
		add_expr '*' mul_expr { $$ = $1 * $3; }
		add_expr '/' mul_expr { $$ = $1 / $3; }
		mul_expr { $$ = $1; }
mul_expr:
		NUMBER { $$ = $1; }
%%
