%{
    #include <stdio.h>
    #include <math.h>
    int  yylex(void);
    void yyerror(const char *s);
%}
%start line
%token NUM

%%
line    : expr '\n'   { printf("result: %d\n", $1) }
        ;

expr    : expr '+' term { $$ = $1 + $3 }
        | expr '-' term { $$ = $1 - $3 }
        | term
        ;

term    : term '*' factor   { $$ = $1 * $3 }
        | term '/' factor   { $$ = $1 / $3 }
        | term '%' factor   { $$ = $1 % $3 }
        | term '^' factor   { $$ = pow($1, $3) }
        | factor
        ;

factor  : '(' expr ')'  { $$ = $2; }
        | NUM
        ;
%%

#include <ctype.h>
#include <stdio.h>

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    printf("yacc error: %s\n", s);
}

int yylex() {
    printf("yylex\n");
    int c = getchar();
    while (c == ' ') {}
    if (isdigit(c)) {
        yylval = c - '0';
        while (isdigit(c = getchar()))
            yylval = yylval*10 + (c-'0');
        ungetc(c, stdin);
        return NUM;
    } else 
        return c;
}