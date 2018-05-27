%{                                                                                          
#include "simple.tab.h"                                                                     
extern int line_number;
extern void completed();                                                                   
%}                                                                                          
%option noyywrap

%x COMMENTS

%%

<INITIAL>"/*"           { BEGIN(COMMENTS);}
<COMMENTS>"*/"          { BEGIN(INITIAL);}
<COMMENTS><<EOF>>       { exit(EXIT_SUCCESS);}
<COMMENTS>.|"\n"        { /*DO NOTHING*/}
<INITIAL><<EOF>>        { completed(); exit(EXIT_SUCCESS);}

<INITIAL>"else"         { printf("FROM FLEX ELSE: %s\n", yytext); return ELSE; }
<INITIAL>"if"           { printf("FROM FLEX IF: %s\n", yytext); return IF; }
<INITIAL>"int"          { printf("FROM FLEX INT: %s\n", yytext); return INT; }
<INITIAL>"return"       { printf("FROM FLEX RETURN: %s\n", yytext); return RETURN; }
<INITIAL>"void"         { printf("FROM FLEX VOID: %s\n", yytext); return VOID; }
<INITIAL>"while"        { printf("FROM FLEX WHILE: %s\n", yytext); return WHILE; }

<INITIAL>"+"            { printf("FROM FLEX PLUS: %s\n", yytext); return PLUS; }
<INITIAL>"-"            { printf("FROM FLEX MINUS: %s\n", yytext); return MINUS; }
<INITIAL>"*"            { printf("FROM FLEX MULTIPLICATION: %s\n", yytext); return MULTIPLICATION; }
<INITIAL>"/"            { printf("FROM FLEX DIVISION: %s\n", yytext); return DIVISION; }
<INITIAL>"<"            { printf("FROM FLEX LESSTHAN: %s\n", yytext); return LESSTHAN; }
<INITIAL>"<="           { printf("FROM FLEX LESSTHANOREQUAL: %s\n", yytext); return LESSTHANOREQUAL; }
<INITIAL>">"            { printf("FROM FLEX GREATERTHAN: %s\n", yytext); return GREATERTHAN; }
<INITIAL>">="           { printf("FROM FLEX GREATERTHANOREQUAL: %s\n", yytext); return GREATERTHANOREQUAL; }
<INITIAL>"=="           { printf("FROM FLEX EQUAL: %s\n", yytext); return EQUAL; }
<INITIAL>"!="           { printf("FROM FLEX NOTEQUAL: %s\n", yytext); return NOTEQUAL; }
<INITIAL>"="            { printf("FROM FLEX ASSIGN: %s\n", yytext); return ASSIGN; }
<INITIAL>";"            { printf("FROM FLEX EOL: %s\n", yytext); return EOL; }
<INITIAL>","            { printf("FROM FLEX COMMA: %s\n", yytext); return COMMA; }
<INITIAL>"{"            { printf("FROM FLEX OPENCURLYBRACKETS: %s\n", yytext); return OPENCURLYBRACKETS; }
<INITIAL>"}"            { printf("FROM FLEX CLOSECURLYBRACKETS: %s\n", yytext); return CLOSECURLYBRACKETS; }
<INITIAL>"("            { printf("FROM FLEX OPENBRACKETS: %s\n", yytext); return OPENBRACKETS; }
<INITIAL>")"            { printf("FROM FLEX CLOSEBRACKETS: %s\n", yytext); return CLOSEBRACKETS; }
<INITIAL>"["            { printf("FROM FLEX OPENSQUREBRACKETS: %s\n", yytext); return OPENSQUREBRACKETS; }
<INITIAL>"]"            { printf("FROM FLEX CLOSESQUREBRACKETS: %s\n", yytext); return CLOSESQUREBRACKETS; }

<INITIAL>[_a-zA-Z][_a-zA-Z]* {printf("FROM FLEX ID: %s\n", yytext); return ID;}
<INITIAL>[_0-9][_0-9]*       {printf("FROM FLEX NUM: %s\n", yytext); return NUM;}

<INITIAL>[ \t\r]+          /* IGNORE whitespace */
%%