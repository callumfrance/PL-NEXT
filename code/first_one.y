%{
#include<stdio.h>
%}

/* %left '+' '-' '*' '/'

%token <number> NUMBER
%token <sIndex> IDENT */

%token START STOP
%token IDENT NUMBER
%token STARTWHILE ENDWHILE STARTDO ENDDO STARTFOR ENDFOR STARTIF THEN ENDIF
%token EXECUTE SET
%token PROC FUNC IMPL IMPLIES EQ DECL
%token TO ARRAY OF IS
%token TYPEWORD TYPEARROW
%token CONST VAR DECLARATION END
%token PROGRAM TERMINATE

%%

basic_program           : PROGRAM declaration_unit implementation_unit TERMINATE
                        ;

declaration_unit        : DECL IMPLIES ident const_part var_part type_part proc_part func_part DECLARATION END
                        ;

const_part              :
                        | CONST constant_declaration
                        ;

var_part                :
                        | VAR variable_declaration
                        ;

type_part               :
                        | type_declaration
                        ;

proc_part               :
                        | procedure_interface
                        ;


compound_statement      : START statements statement STOP
                        ;

for_statement           : STARTFOR ident EQ expression STARTDO statements statement ENDFOR
                        ;

do_statement            : STARTDO statements statement STARTWHILE expression ENDDO
                        ;

while_statement         : STARTWHILE expression STARTDO statement ENDWHILE
                        | STARTWHILE expression STARTDO statements statement ENDWHILE
                        ;

if_statement            : STARTIF expression THEN statement ENDIF
                        ;

procedure_call          : EXECUTE ident
                        ;

expression              : term
                        | expression '+' expression
                        | expression '-' expression
                        ;

assignment              : ident SET expression
                        ;

statement               : assignment
                        | procedure_call
                        | if_statement
                        | while_statement
                        | do_statement
                        | for_statement
                        | compound_statement
                        ;

statements              : statement
                        | statements ';' statement
                        ;

implementation_part     : statement
                        ;

function_declaration    : FUNC ident ';' block ';'

procedure_declaration   : PROC ident ';' block ';'

specification_part      :
                        | CONST constant_declaration
                        | VAR variable_declaration
                        | procedure_declaration
                        | function_declaration
                        ;

block                   : specification_part implementation_part
                        ;

implementation_unit     : IMPL IMPLIES ident block '.'
                        ;

range                   : number TO number
                        ;

array_type              : ARRAY ident '[' range ']' OF type
                        ;

range_type              : '[' range ']'
                        ;

enumerated_type         : '{' list_ident '}'
                        ;

basic_type              : ident
                        | enumerated_type
                        | range_type
                        ;

type                    : basic_type
                        | array_type
                        ;

match_idents            : ident ':' ident
                        | match_idents ',' ident ':' ident
                        ;

variable_declaration    : match_idents ';'
                        ;

declarations            : ident IS number
                        | declarations ',' ident IS number
                        ;

constant_declaration    : declarations ';'
                        ;

formal_parameters       : '(' list_ident2 ')'
                        ;

type_declaration        : TYPEWORD ident TYPEARROW type ';'
                        ;

function_interface      : FUNC ident
                        | FUNC ident formal_parameters
                        ;

procedure_interface     : PROC ident
                        | PROC ident formal_parameters
                        ;

func_part               :
                        | function_interface
                        ;
list_ident              : ident
                        | list_ident ',' ident
                        ;

list_ident2             : ident
                        | list_ident2 ';'
                        ;


term                    : id_num
                        | term '*' term
                        | term '/' term
                        ;

id_num                  :
                        | number
                        | ident
                        ;

ident                   : IDENT
                        ;

number                  : NUMBER
                        ;


%%
main()
{
    return yyparse();
}
yyerror()
{
    printf("\n============================\n");
    printf(  "A PL-NEXT error has occurred\n");
    printf(  "============================\n");
}
