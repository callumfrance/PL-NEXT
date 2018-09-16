%{
#include<stdio.h>

int yylex();
void yyerror(const char *s);
%}

%start basic_program

%left '+' '-'
%left '*' '/'

%token NUMBER
%token IDENT

%token START STOP
/* %token IDENT NUMBER */
%token STARTWHILE ENDWHILE STARTDO ENDDO STARTFOR ENDFOR STARTIF THEN ENDIF
%token EXECUTE SET
%token PROC FUNC IMPL IMPLIES ISEQ DECL
%token TO ARRAY OF IS
%token TYPEWORD TYPEARROW
%token CONST VAR DECLARATION END
%token PROGRAM TERMINATE

%%

basic_program           : PROGRAM declaration_unit implementation_unit TERMINATE
                        { printf("basic program, "); }
                        ;

declaration_unit        : DECL IMPLIES ident const_part var_part type_part proc_part func_part DECLARATION END
                        { printf("declaration unit, "); }
                        ;

const_part              :
                        | CONST constant_declaration
                        { printf("constant declaration part, "); }
                        ;

var_part                :
                        | VAR variable_declaration
                        { printf("variable declaration part, "); }
                        ;

type_part               :
                        | type_declaration
                        { printf("type declaration part, "); }
                        ;

proc_part               :
                        | procedure_interface
                        { printf("procedure interface part, "); }
                        ;

procedure_interface     : PROC ident
                        | PROC ident formal_parameters
                        { printf("procedure interface, "); }
                        ;

function_interface      : FUNC ident
                        | FUNC ident formal_parameters
                        { printf("function interface, "); }
                        ;

type_declaration        : TYPEWORD ident TYPEARROW type ';'
                        { printf("type declaration, "); }
                        ;

formal_parameters       : '(' list_ident2 ')'
                        { printf("formal parameters, "); }
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

for_statement           : STARTFOR ident ISEQ expression STARTDO statements statement ENDFOR
                        { printf("for statement, "); }
                        ;

do_statement            : STARTDO statements statement STARTWHILE expression ENDDO
                        { printf("do statement, "); }
                        ;

while_statement         : STARTWHILE expression STARTDO statement ENDWHILE
                        | STARTWHILE expression STARTDO statements statement ENDWHILE
                        { printf("while statement, "); }
                        ;

if_statement            : STARTIF expression THEN statement ENDIF
                        { printf("if statement, "); }
                        ;

compound_statement      : START statements statement STOP
                        { printf("compound statement, "); }
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
                        { printf("expression %d, ", $1); }
                        ;

term                    : id_num
                        | term '*' term
                        | term '/' term
                        { printf("term %d, ", $1); }
                        ;

id_num                  :
                        | number
                        | ident
                        { printf("id_num %d, ", $1); }
                        ;

ident                   : IDENT
                        { printf("ident %d, ", $1); }
                        ;

number                  : NUMBER
                        { printf("number %d, ", $1); }
                        ;


%%
int main()
{
    yyparse();
}
void yyerror(const char *s)
{
    printf("\n\t============================\n");
    printf(  "\tA PL-NEXT error has occurred\n");
    printf(  "\t============================\n");
    printf("Message: ");
    printf("%s\n\n", s);
}
