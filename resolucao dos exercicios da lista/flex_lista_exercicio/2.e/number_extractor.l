%{
#include <stdio.h>
#include <stdlib.h>

void install_num(const char *text);

%}

%%

[+-]?[0-9]+([eE][+-]?[0-9]+)?       { install_num(yytext); }
[+-]?[0-9]*\.[0-9]+([eE][+-]?[0-9]+)? { install_num(yytext); }
[ \t\n]                              { /* Ignora espaços, tabs e novas linhas */ }
.                                    { /* Ignora outros caracteres */ }
%%

void install_num(const char *text) {
    if (strchr(text, '.') || strchr(text, 'e') || strchr(text, 'E')) {
        double num = atof(text);
        printf("Float: %f\n", num);
    } else {
        int num = atoi(text);
        printf("Integer: %d\n", num);
    }
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Could not open file");
            return 1;
        }
        yyin = file;
    }

    printf("Please enter the text (CTRL+D to end input):\n");
    yylex();

    return 0;
}

int yywrap() {
    return 1;
}

