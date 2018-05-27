%{                                                                                   
   #include <stdarg.h>
   #include <stdio.h>
   #include "simple_shared.h"                                                        
   #define YYSTYPE char *                                                            
   int yydebug=0;                                                                    
   int indent=0;                                                                     
   void yyerror (char const *s);
   void completed();                                                               
%} 

%token ELSE                                                                         
%token IF                                                                      
%token INT
%token RETURN
%token VOID
%token WHILE
%token PLUS                                                                    
%token MINUS                                                             
%token MULTIPLICATION
%token DIVISION
%token LESSTHAN
%token LESSTHANOREQUAL
%token GREATERTHAN                                                                        
%token GREATERTHANOREQUAL                                                                      
%token EQUAL
%token NOTEQUAL
%token ASSIGN
%token COMMA
%token OPENCURLYBRACKETS                                                                    
%token CLOSECURLYBRACKETS                                                                      
%token OPENBRACKETS
%token CLOSEBRACKETS
%token OPENSQUREBRACKETS
%token CLOSESQUREBRACKETS
%token ID
%token NUM
%token EOL

%%
program             : declaration-list;
declaration-list    : declaration-list declaration | declaration;
declaration         : var-declaration | fun-declaration;
var-declaration     : type-specifier ID EOL | type-specifier ID OPENSQUREBRACKETS NUM CLOSESQUREBRACKETS EOL;
type-specifier      : INT | VOID;
fun-declaration     : type-specifier ID OPENBRACKETS params CLOSEBRACKETS compound-stmt;
params              : param-list | VOID;
param-list          : param-list COMMA param| param;
param               : type-specifier ID | type-specifier ID OPENSQUREBRACKETS CLOSESQUREBRACKETS;
compound-stmt       : OPENCURLYBRACKETS local-declarations statement-list CLOSECURLYBRACKETS;
local-declarations  : local-declarations var-declaration | %empty;
statement-list      : statement-list statement | %empty;
statement           : expression-stmt | compound-stmt | selection-stmt | iteration-stmt | return-stmt;
expression-stmt     : expression EOL | EOL;
selection-stmt      : IF OPENBRACKETS expression CLOSEBRACKETS statement | IF OPENBRACKETS expression CLOSEBRACKETS statement ELSE statement;
iteration-stmt      : WHILE OPENBRACKETS expression CLOSEBRACKETS statement;
return-stmt         : RETURN EOL | RETURN expression EOL;
expression          : var ASSIGN expression | simple-expression;
var                 : ID | ID OPENSQUREBRACKETS expression CLOSESQUREBRACKETS;
simple-expression   : additive-expression relop additive-expression | additive-expression;
relop               : LESSTHAN | LESSTHANOREQUAL | GREATERTHAN | GREATERTHANOREQUAL | EQUAL | NOTEQUAL;
additive-expression : additive-expression addop term | term;
addop               : PLUS | MINUS;
term                : term mulop factor | factor;
mulop               : MULTIPLICATION | DIVISION;
factor              : OPENBRACKETS expression CLOSEBRACKETS | var | call | NUM;
call                : ID OPENBRACKETS args CLOSEBRACKETS;
args                : arg-list | %empty;
arg-list            : arg-list COMMA expression | expression;
%%

void yyerror (char const *s) {
  fprintf (stderr, "%s\n", s);
}

void completed(void){
  fprintf (stderr, "\n ======== Successfully Parsed! ======== \n");
}

int main ()                                                                              
{                                                                                    
  yyparse ();
  completed();                                                                        
}


