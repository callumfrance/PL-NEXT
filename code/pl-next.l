 /* Title: pl-next.l
    Author: Callum France
 */
 /* =================================================
    Definition section
    ================================================= */
%{
#include<stdio.h>
#include<stdlib.h>
#include "y.tab.h"
%}
 /* this option aids compilation */
%option noyywrap
 /* below defines a context to allows block comments in PL-NEXT */
%x C_COMMENT
 /* these are the two fundamental types in PL-NEXT */
NUMBER                     [0-9]+
IDENT                      [a-z]+
%%
 /* =================================================
    Rules section
    ================================================= */

 /* The below C line converts the parsed number into an actual integer */
{NUMBER}                      { yylval=atoi(yytext); return NUMBER; }
{IDENT}                       { return IDENT; }
 /* ignore whitespace, like my boy C */
[ \t]+                        { ; }

 /* add C style comments */
"/*"                          { BEGIN(C_COMMENT); }
<C_COMMENT>"*/"               { BEGIN(INITIAL); }
<C_COMMENT>\n                 { }
<C_COMMENT>.                  { }

 /* Any otherwise unrecognized CHAR is passed directly into Yacc */
.                             { return (int) yytext[0]; }

"START"                       { printf("START\n"); return START; }
"STOP"                        { printf("STOP\n"); return STOP; }

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
":="                          { return ISEQ; }
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

"PROGRAM"                     { printf("\n"
"  _______  _         _        _______          _________\n"
" (  ____ )( \\       ( (    /|(  ____ \\|\\     /|\\__   __/\n"
" | (    )|| (       |  \\  ( || (    \\/( \\   / )   ) (   \n"
" | (____)|| | _____ |   \\ | || (__     \\ (_) /    | |   \n"
" |  _____)| |(_____)| (\\ \\) ||  __)     ) _ (     | |   \n"
" | (      | |       | | \\   || (       / ( ) \\    | |   \n"
" | )      | (____/\\ | )  \\  || (____/\\( /   \\ )   | |   \n"
" |/       (_______/ |/    )_)(_______/|/     \\|   )_( \n");
return PROGRAM; }
"TERMINATE"                   { printf("\nEnd of program\n"
"                                       .\n"
"                             /^\\     .\n"
"                        /\\   \"V\"\n"
"                       /__\\   I      O  o\n"
"                      //..\\\\  I     .\n"
"                      \\].`[/  I\n"
"                      /l\\/j\\  (]    .  O\n"
"                     /. ~~ ,\\/I          .\n"
"                     \\\\L__j^\\/I       o\n"
"                      \\/--v}  I     o   .\n"
"                      |    |  I   _________\n"
"                      |    |  I c(`       ')o\n"
"                      |    l  I   \\.     ,/\n"
"                    _/j  L l\\_!  _//^---^\\\\_\n"
"                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

return TERMINATE; }


%%
 /* =================================================
    User subroutines - there are none
    ================================================= */
