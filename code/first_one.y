%{
#include<stdio.h>
%}

%left '+' '-' '*' '/'

%token <number> NUMBER
%token <sIndex> IDENT

%token START STOP
%token STARTWHILE ENDWHILE STARTDO ENDDO STARTFOR ENDFOR STARTIF THEN ENDIF
%token EXECUTE SET
%token PROC FUNC IMPL IMPLIES DECL
%token TO ARRAY OF IS
%token TYPEWORD TYPEARROW
%token CONST VAR DECLARATION END
%token PROGRAM TERMINATE

%%

list_ident              : IDENT
                        | list_ident ',' IDENT
                        ;

list_ident2             : IDENT
                        | list_ident2 ';'
                        ;

id_num    :
          | NUMBER
          | IDENT
          ;

term      : id_num
          | term '*' term
          | term '/' term
          ;

expression              : term
                        | expression '+' expression
                        | expression '-' expression
                        ;

compound_statement      : START statements statement STOP
                        ;

for_statement           : STARTFOR IDENT EQ EXPRESSION DO statements statement ENDFOR
                        ;

do_statement            : STARTDO statements statement WHILE expression ENDDO
                        ;

while_statement         : STARTWHILE expression STARTDO statement ENDWHILE
                        | STARTWHILE expression STARTDO statements statement ENDWHILE
                        ;

if_statement            : STARTIF expression THEN statement ENDIF
                        ;

procedure_call          : EXECUTE IDENT
                        ;

assignment              : IDENT SET EXPRESSION
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

function_declaration    : FUNC IDENT ';' block ';'

procedure_declaration   : PROC IDENT ';' block ';'

specification_part      :
                        | CONST constant_declaration
                        | VAR variable_declaration
                        | procedure_declaration
                        | function_declaration
                        ;

block                   : specification_part implementation_part
                        ;

implementation_unit     : IMPL IMPLIES IDENT block '.'
                        ;

range                   : NUMBER TO NUMBER
                        ;

array_type              : ARRAY IDENT '[' range ']' OF type
                        ;

range_type              : '[' range ']'
                        ;

enumerated_type         : '{' list_ident '}'
                        ;

basic_type              : IDENT
                        | enumerated_type
                        | range_type
                        ;

type                    : basic_type
                        | array_type
                        ;

match_idents            : IDENT ':' IDENT
                        | match_idents ',' IDENT ':' IDENT
                        ;

variable_declaration    : match_idents ';'
                        ;

declarations            : IDENT IS NUMBER
                        | declarations ',' IDENT IS NUMBER
                        ;

constant_declaration    : declarations ';'
                        ;

formal_parameters       : '(' list_ident2 ')'
                        ;

type_declaration        : TYPEWORD IDENT TYPEARROW type ';'
                        ;

function_interface      : FUNC IDENT
                        | FUNC IDENT formal_parameters
                        ;

procedure_interface     : PROC IDENT
                        | PROC IDENT formal_parameters
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

func_part               :
                        | function_interface
                        ;

declaration_unit        : DECL IMPLIES IDENT const_part var_part type_part proc_part func_part DECLARATION END
                        ;

basic_program           : PROGRAM declaration_unit implementation_unit TERMINATE
                        ;

%%
