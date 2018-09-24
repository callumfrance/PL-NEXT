 /* Title: pl-next.y
    Author: Callum France
 */
 /* =================================================
    Declarations section
    ================================================= */
%{
#include<stdio.h>

int yylex();
void yyerror(const char *s);
%}

 /* -------------------------------------------------
    Tokens
        Tokens are used to identify keywords from Lex
    -------------------------------------------------
 */
%start basic_program

 /* %left is used for a token when the leftmost word should gain priority
 */
%left '+' '-'
%left '*' '/'

%token NUMBER
%token IDENT

%token START STOP
%token STARTWHILE ENDWHILE STARTDO ENDDO STARTFOR ENDFOR STARTIF THEN ENDIF
%token EXECUTE SET
%token PROC FUNC IMPL IMPLIES ISEQ DECL
%token TO ARRAY OF IS
%token TYPEWORD TYPEARROW
%token CONST VAR DECLARATION END
%token PROGRAM TERMINATE

%%
 /* =================================================
    Rules
    ================================================= */

basic_program           : PROGRAM declaration_unit implementation_unit TERMINATE
                        { printf("Basic Program Finished.\n\texiting...\n");
                          return(0); }
                        ;

declaration_unit        : DECL IMPLIES ident const_part var_part type_part proc_part func_part DECLARATION END
                        { printf("\nDECLARATION UNIT.\n"
						"-----------------"); }
                        ;

const_part              :
                        | CONST constant_declaration
                        { printf("\nConstant Declaration Part"); }
                        ;

var_part                :
                        | VAR variable_declaration
                        { printf("\nVariable Declaration Part"); }
                        ;

type_part               :
                        | type_declaration
                        { printf("\nType Declaration Part"); }
                        ;

proc_part               :
                        | procedure_interface
                        { printf("\nProcedure Interface Part"); }
                        ;

procedure_interface     : PROC ident
                        { printf("Procedure interface without parameters\n"); }
                        | PROC ident formal_parameters
                        { printf("Procedure interface with parameters\n"); }
                        ;

function_interface      : FUNC ident
                        { printf("Function interface without parameters\n"); }
                        | FUNC ident formal_parameters
                        { printf("Function interface with parameters\n"); }
                        ;

type_declaration        : TYPEWORD ident TYPEARROW type ';'
                        { printf("Type declaration, "); }
                        ;

formal_parameters       : '(' list_ident2 ')'
                        { printf("Formal parameters, "); }
                        ;

constant_declaration    : declarations ';'
                        { printf("Constant declarations, "); }
                        ;

declarations            : ident IS number
                        { printf("Singular declaration, "); }
                        | declarations ',' ident IS number
                        { printf("Multiple declarations, "); }
                        ;

type                    : basic_type
                        { printf("Type is basic type, "); }
                        | array_type
                        { printf("Type is array type, "); }
                        ;

enumerated_type         : '{' list_ident '}'
                        { printf("Enumerated type, "); }
                        ;

basic_type              : ident
                        { printf("Basic type is ident, "); }
                        | enumerated_type
                        { printf("Basic type is enumerated_type, "); }
                        | range_type
                        { printf("Basic type is range_type, "); }
                        ;

range                   : number TO number
                        { printf("Range, "); }
                        ;

array_type              : ARRAY ident '[' range ']' OF type
                        { printf("Array type, "); }
                        ;

range_type              : '[' range ']'
                        { printf("Range type, "); }
                        ;

block                   : specification_part implementation_part
                        { printf("BLOCK\n"); }
                        ;


specification_part      :
                        | CONST constant_declaration
                        { printf("Specification part constant_declaration\n"); }
                        | VAR variable_declaration
                        { printf("Specification part variable_declaration\n"); }
                        | procedure_declaration
                        { printf("Specification part procedure_declaration\n"); }
                        | function_declaration
                        { printf("Specification part function_declaration\n"); }
                        ;

implementation_unit     : IMPL IMPLIES ident block '.'
                        { printf("\nIMPLEMENTATION UNIT.\n"
						"--------------------"); }
                        ;

variable_declaration    : match_idents ';'
                        { printf("Variable declaration, "); }
                        ;

match_idents            : ident ':' ident
                        | match_idents ',' ident ':' ident
                        ;

implementation_part     : statement
                        { printf("Implementation Part\n"); }
                        ;

function_declaration    : FUNC ident ';' block ';'
                        { printf("Function declaration, "); }
                        ;

procedure_declaration   : PROC ident ';' block ';'
                        { printf("Procedure declaration, "); }
                        ;

func_part               :
                        | function_interface
                        { printf("\nFunction Interface Part"); }
                        ;

statements              : statement
                        { printf("One in 'statements'\n"); }
                        | statements ';' statement
                        { printf("Statements\n"); }
                        ;

statement               : assignment
                        { printf("Statement is an assignment, "); }
                        | procedure_call
                        { printf("Statement is a procedure_call, "); }
                        | if_statement
                        { printf("Statement is an if_statement, "); }
                        | while_statement
                        { printf("Statement is a while_statement, "); }
                        | do_statement
                        { printf("Statement is a do_statement, "); }
                        | for_statement
                        { printf("Statement is a for_statement, "); }
                        | compound_statement
                        { printf("Statement is a compound_statement, "); }
                        ;

procedure_call          : EXECUTE ident
                        { printf("Procedure call, "); }
                        ;

assignment              : ident SET expression
                        { printf("Assignment, "); }
                        ;

for_statement           : STARTFOR ident ISEQ expression STARTDO statements ENDFOR
                        { printf("For statement, "); }
                        ;

do_statement            : STARTDO statements STARTWHILE expression ENDDO
                        { printf("Do statement, "); }
                        ;

while_statement         : STARTWHILE expression STARTDO statements ENDWHILE
                        { printf("While statement, "); }
                        ;

if_statement            : STARTIF expression THEN statement ENDIF
                        { printf("If statement, "); }
                        ;

compound_statement      : START statements STOP
                        { printf("Compound statement, "); }
                        ;

list_ident              : ident
                        | list_ident ',' ident
                        ;

list_ident2             : ident
                        | list_ident2 ';' ident
                        ;

expression              : term
                        { printf("Expression is a term, "); }
                        | expression '+' expression
                        { printf("Expression is an addition, "); }
                        | expression '-' expression
                        { printf("Expressions is a subtraction, "); }
                        ;

term                    : id_num
                        { printf("Expression is an id_num, "); }
                        | term '*' term
                        { printf("Term is a multiplication, "); }
                        | term '/' term
                        { printf("Term is a division, "); }
                        ;

id_num                  : number
                        { printf("id_num is a number, "); }
                        | ident
                        { printf("id_num is an ident, "); }
                        ;

ident                   : IDENT
                        { /*printf("ident, ");*/ }
                        ;

number                  : NUMBER
                        { /*printf("number, ");*/ }
                        ;


%%
 /* =================================================
    Routines
    ================================================= */
int main()
{
    // The main function is simply the parser.
    yyparse();
}
void yyerror(const char *s)
{
    // The behaviour the program takes when an error is encountered
    //     Prints the error message string with an error header
    printf("\n\t============================\n");
    printf(  "\tA PL-NEXT error has occurred\n");
    printf(  "\t============================\n");
    printf("Message: ");
    printf("%s\n\n", s);
}
