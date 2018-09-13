%{
#include<stdio.h>
#include "y.tab.h"
%}

%%
[\t ]+$                                       ;
[\t ]+                                        printf(" ");

"*"                                           return MUL;
"/"                                           return DIV;
"+"                                           return ADD;
"-"                                           return MIN;

[a-z]+                                        return IDENT;
[0-9]+                                        return NUMBER;
({IDENT}|{NUMBER})                            return ID_NUM;
{ID_NUM}(({MUL}|{DIV}){ID_NUM})*              return TERM;
{TERM}(({ADD}|{MIN}){TERM})*                  return EXPRESSION;
"START"({STATEMENT}";")*{STATEMENT}"STOP"     return COMPOUND_STATEMENT;
%%
