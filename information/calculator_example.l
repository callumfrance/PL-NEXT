%{
#include "y.tab.h"
%}
NUMBER [0-9]+
OP [+-/*]
%%
{NUMBER}  { yylval.value = strtol(yytext, 0, 10); return NUMBER; }
({OP}|\n) { return yytext[0]; }
.         { ; }
%%
#ifndef yywrap
	yywrap() { return 1; }
#endif
