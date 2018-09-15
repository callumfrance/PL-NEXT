%{
#include<stdio.h>
#include "y.tab.h"
%}

NUMBER                     [0-9]+

IDENT                      [a-z]+

ID_NUM                     [{NUMBER}{ID}]

TERM                       {ID_NUM}([\*\/]{ID_NUM})*

EXPRESSION                 {TERM}([\+\-]{TERM})*

COMPOUND_STATEMENT         "START"({STATEMENT}";")*{STATEMENT}"STOP"

FOR_STATEMENT              "FOR"{IDENT}":="{EXPRESSION}"DO"({STATEMENT}";")*{STATEMENT}"ROF"

DO_STATEMENT               "DO"({STATEMENT}";")*{STATEMENT}"WHILE"{EXPRESSION}"OD"

WHILE_STATEMENT            "WHILE"{EXPRESSION}"DO"({STATEMENT}";")*{STATEMENT}"ELIHW"

IF_STATEMENT               "IF"{EXPRESSION}"THEN"{STATEMENT}"FI"

PROCEDURE_CALL             "EXECUTE"{IDENT}

ASSIGNMENT                 {IDENT}"SET"{EXPRESSION}

STATEMENT                  [{ASSIGNMENT}{PROCEDURE_CALL}{IF_STATEMENT}{WHILE_STATEMENT}{DO_STATEMENT}{FOR_STATEMENT}{COMPOUND_STATEMENT}]

IMPLEMENTATION_PART        {STATEMENT}

FUNCTION_DECLARATION       "FUNC"{IDENT}";"{BLOCK}";"

PROCEDURE_DECLARATION      "PROC"{IDENT}";"{BLOCK}";"

SPECIFICATION_PART         [("CONST"{CONSTANT_DECLARATION})("VAR"{VARIABLE_DECLARATION}){PROCEDURE_DECLARATION}{FUNCTION_DECLARATION}]?

BLOCK                      {SPECIFICATION_PART}{IMPLEMENTATION_PART}

IMPLEMENTATION_UNIT        "IMPL""::"{IDENT}{BLOCK}"."

RANGE                      {NUMBER}"TO"{NUMBER}

ARRAY_TYPE                 "ARR"{IDENT}"["{RANGE}"]""OF"{TYPE}

RANGE_TYPE                 "["{RANGE}"]"

ENUMERATED_TYPE            "{"[{IDENT}","]*{IDENT}"}"

BASIC_TYPE                 [{IDENT}{ENUMERATED_TYPE}{RANGE_TYPE}]

TYPE                       [{BASIC_TYPE}{ARRAY_TYPE}]

VARIABLE_DECLARATION       [{IDENT}":"{IDENT}","]*{IDENT}":"{IDENT}";"

CONSTANT_DECLARATION       [{IDENT}"IS"{NUMBER}","]*{IDENT}"IS"{NUMBER}";"

FORMAL_PARAMETERS          "("[{IDENT}";"]*{IDENT}")"

TYPE_DECLARATION           "TYPE"{IDENT}"=>"{TYPE}";"

FUNCTION_INTERFACE         "FUNC"{IDENT}({FORMAL_PARAMETERS})?

PROCEDURE_INTERFACE        "PROC"{IDENT}({FORMAL_PARAMETERS})?

DECLARATION_UNIT           "DECL""::"{IDENT}("CONST"{CONSTANT_DECLARATION})?("VAR"{VARIABLE_DECLARATION})?({TYPE_DECLARATION})?({PROCEDURE_INTERFACE})?({FUNCTION_INTERFACE})?"DECLARATION""END"

BASIC_PROGRAM              "PROGRAM"{DECLARATION_UNIT}{IMPLEMENTATION_PART}"TERMINATE"

%%
{NUMBER}              { yylval=atoi(yytext); return NUMBER; }
{IDENT}               { return IDENT; }
[ \t]+                { ; } /* ignore whitespace, like my boy C */

.                     { /* matches all single otherwise unmatched characters */
                        return (int) yytext[0];
                      }

"START"               { return START; }
"STOP"                { return STOP; }

"WHILE"               { return STARTWHILE; }
"DO"                  { return STARTDO; }
"OD"                  { return ENDDO; }
"ELIHW"               { return ENDWHILE; }
"FOR"                 { return STARTFOR; }
"ROF"                 { return ENDFOR; }
"IF"                  { return STARTIF; }
"THEN"                { return THEN; }
"FI"                  { return ENDIF; }

"EXECUTE"             { return EXECUTE; }
"SET"                 { return SET; }

"PROC"                { return PROC; }
"FUNC"                { return FUNC; }
"IMPL"                { return IMPL; }
"::"                  { return IMPLIES; }
"DECL"                { return DECL; }

"TO"                  { return TO; }
"ARR"                 { return ARRAY; }
"OF"                  { return OF; }
"IS"                  { return IS; }


"TYPE"                { return TYPEWORD; }
"=>"                  { return TYPEARROW; }

"CONST"               { return CONST; }
"VAR"                 { return VAR; }

"DECLARATION"         { return DECLARATION; }
"END"                 { return END; }

"PROGRAM"             { return PROGRAM; }
"TERMINATE"           { return TERMINATE; }


%%

#ifndef yywrap
    yywrap() { return 1; }
#endif

int main(void) {
    yylex();  // invokes lexer, returns token
    return 0;
}
