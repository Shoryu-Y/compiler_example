%{
    #include <stdio.h>
    #include <math.h>

    #define M_SIZE  16
    double  Memory[M_SIZE]
    // int  yylex(void);
    void yyerror(const char *s);
%}

%union{
    int     ival;
    double  rval;
}

%token  MEM EXP LOG SQRT

%token  <ival>  INTC
%token  <rval>  REALC

%type   <ival>  mcell
%type   <rval>  expr

%right  '='
%left   '+' '-'
%left   '*' '/'
%right  '^'
%right  UMINUS

%%
line    :   line    expr    '\n'    { printf("result: %f\n", $2); }
        |   line    error   '\n'    { yyerrok; }
        ;

expr    :   mcell   '='     expr            { $$ = Memory[$1] = $3; }
        |   expr    '+'     expr            { $$ = $1 + $3; }
        |   expr    '-'     expr            { $$ = $1 - $3; }
        |   expr    '*'     expr            { $$ = $1 * $3; }
        |   expr    '/'     expr            { $$ = $1 / $3; }
        |   expr    '^'     expr            { $$ = pow($1, $3); }
        |   '-'     expr    %prec   UMINUS  { $$ = -$2; }
        |   '('     expr    ')'             { $$ = $2; }
        |   LOG     '('     expr    ')'     { $$ = log($3); }
        |   EXP     '('     expr    ')'     { $$ = exp($3); }
        |   SQRT    '('     expr    ')'     { $$ = sqrt($3); }
        |   mcell                           { $$ = Memory[$1]; }
        |   INTC                            { $$ = (double)$1; }
        |   REALC                           { $$ = $1; }
        ;

mcell   :   MEM     '['     INTC    ']'     { if ($3>=0 && $3<M_SIZE)
                                                $$ = $3;
                                              else {
                                                printf("Memory Fault\n");
                                                $$ = 0;
                                              }
                                            }
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

// int yylex() {
//     printf("yylex\n");
//     int c = getchar();
//     while (c == ' ') {}
//     if (isdigit(c)) {
//         yylval = c - '0';
//         while (isdigit(c = getchar()))
//             yylval = yylval*10 + (c-'0');
//         ungetc(c, stdin);
//         return NUM;
//     } else 
//         return c;
// }