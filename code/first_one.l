%{
#include<stdio.h>
#include<stdlib.h>
#include "y.tab.h"
%}
%x C_COMMENT
NUMBER                     [0-9]+
IDENT                      [a-z]+
%%
{NUMBER}                      { yylval=atoi(yytext); return NUMBER; }
{IDENT}                       { return IDENT; }
[ \t]+                        { ; } /* ignore whitespace, like my boy C */

"/*"                          { BEGIN(C_COMMENT); } /* add C style comments */
<C_COMMENT>"*/"               { BEGIN(INITIAL); }
<C_COMMENT>\n                 { }
<C_COMMENT>.                  { }

.                             { return (int) yytext[0]; } /* matches all single otherwise unmatched characters */

"START"                       { return START; }
"STOP"                        { return STOP; }

"WHILE"                       { return STARTWHILE; }
"DO"                          { return STARTDO; }
"OD"                          { return ENDDO; }
"ELIHW"                       { return ENDWHILE; }
"FOR"                         { return STARTFOR; }
"ROF"                         { return ENDFOR; }
"IF"                          { return STARTIF; }
"THEN"                        { return THEN; }
"FI"                          { return ENDIF; }

"EXECUTE"                     { return EXECUTE; }
"SET"                         { return SET; }

"PROC"                        { return PROC; }
"FUNC"                        { return FUNC; }
"IMPL"                        { return IMPL; }
"::"                          { return IMPLIES; }
":="                          { return EQ; }
"DECL"                        { return DECL; }

"TO"                          { return TO; }
"ARR"                         { return ARRAY; }
"OF"                          { return OF; }
"IS"                          { return IS; }


"TYPE"                        { return TYPEWORD; }
"=>"                          { return TYPEARROW; }

"CONST"                       { return CONST; }
"VAR"                         { return VAR; }

"DECLARATION"                 { return DECLARATION; }
"END"                         { return END; }

"PROGRAM"                     { return PROGRAM; }
"TERMINATE"                   { return TERMINATE; }


%%
