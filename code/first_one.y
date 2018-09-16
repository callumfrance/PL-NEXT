%{
#include<stdio.h>

int yylex();
void yyerror(const char *s);
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
                        { printf("basic program\n"); }
                        ;

declaration_unit        : DECL IMPLIES ident const_part var_part type_part proc_part func_part DECLARATION END
                        { printf("declaration unit\n"); }
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

procedure_interface     : PROC ident
                        | PROC ident formal_parameters
                        { printf("procedure interface\n"); }
                        ;

function_interface      : FUNC ident
                        | FUNC ident formal_parameters
                        { printf("function interface\n"); }
                        ;

type_declaration        : TYPEWORD ident TYPEARROW type ';'
                        ;

formal_parameters       : '(' list_ident2 ')'
                        ;

constant_declaration    : declarations ';'
                        ;

declarations            : ident IS number
                        | declarations ',' ident IS number
                        ;

type                    : basic_type
                        | array_type
                        ;

enumerated_type         : '{' list_ident '}'
                        ;

basic_type              : ident
                        | enumerated_type
                        | range_type
                        ;

range                   : number TO number
                        ;

array_type              : ARRAY ident '[' range ']' OF type
                        ;

range_type              : '[' range ']'
                        ;

block                   : specification_part implementation_part
                        ;


specification_part      :
                        | CONST constant_declaration
                        | VAR variable_declaration
                        | procedure_declaration
                        | function_declaration
                        ;

implementation_unit     : IMPL IMPLIES ident block '.'
                        ;

variable_declaration    : match_idents ';'
                        ;

match_idents            : ident ':' ident
                        | match_idents ',' ident ':' ident
                        ;

implementation_part     : statement
                        ;

function_declaration    : FUNC ident ';' block ';'
                        ;

procedure_declaration   : PROC ident ';' block ';'
                        ;

func_part               :
                        | function_interface
                        ;

statements              : statement
                        | statements ';' statement
                        ;

statement               : assignment
                        | procedure_call
                        | if_statement
                        | while_statement
                        | do_statement
                        | for_statement
                        | compound_statement
                        ;

procedure_call          : EXECUTE ident
                        ;

assignment              : ident SET expression
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

compound_statement      : START statements statement STOP
                        ;

list_ident              : ident
                        | list_ident ',' ident
                        ;

list_ident2             : ident
                        | list_ident2 ';'
                        ;

expression              : term
                        | expression '+' expression
                        | expression '-' expression
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
                        { printf("ident\n"); }
                        ;

number                  : NUMBER
                        { printf("number\n"); }
                        ;


%%
int main()
{
    return yyparse();
}
void yyerror(const char *s)
{
    printf("\n============================\n");
    printf(  "A PL-NEXT error has occurred\n");
    printf(  "============================\n");
    printf("\tMessage:\n");
    printf("\t%s\n\n", s);
}
