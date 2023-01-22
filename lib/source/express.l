%{
#include <string.h>
#include <stdio.h>
#include "y.tab.h"
%}

white       [ \t]
integer     [0-9]+
floating    [0-9]+\.[0-9]+
symbol      [=+\-\^*/();\n]
letter      [a-zA-Z]
other       .

%%
{white}+
{symbol}                { return(yytext[0]); }
"M"                     { return(MEM); }
"exp"                   { return(EXP); }
"log"                   { return(LOG); }
"sqrt"                  { return(SQRT); }
{integer}               { sscanf(yytext, "%d", &yylval);
                          return(INTC); }
{floating}              { sscanf(yytext, "%lf", &yylval);
                          return(REALC); }
{other}                 { fprintf(stderr, "Illegal charcter %c, ignored\n", yytext[0]); }

%%