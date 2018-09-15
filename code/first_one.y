%{
#include<stdio.h>
%}

%token <iValue> NUMBER
%token <sIndex> IDENT
%token TERM EXPRESSION PROCEDURE_CALL STATEMENT ASSIGNMENT IF_STATEMENT

%left '+' '-' '*' '/'

%%

program   : {printf("program accepted!");};

%%
