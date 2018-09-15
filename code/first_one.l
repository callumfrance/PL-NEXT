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
{NUMBER}              { /* printf("number found"); */ return NUMBER; }
{IDENT}               { /* printf("ident found"); */  return IDENT; }
{TERM}                { return TERM; }
{EXPRESSION}          { return EXPRESSION; }
{PROCEDURE_CALL}      { return PROCEDURE_CALL; }
{STATEMENT}           { return STATEMENT; }
{ASSIGNMENT}          { return ASSIGNMENT; }
{IF_STATEMENT}        { return IF_STATEMENT; }
[ \t]+                { ; } /* ignore whitespace, like my boy C */
%%

#ifndef yywrap
	yywrap() { return 1; }
#endif

int main(void) {
	yylex();  // invokes lexer, returns token
	return 0;
}
