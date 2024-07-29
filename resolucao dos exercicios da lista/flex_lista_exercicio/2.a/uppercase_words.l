%{
#include <stdio.h>

int uppercase_word_count = 0;

%}

%%

[A-Z][a-zA-Z]*    { uppercase_word_count++; }
.                 { /* Ignora outros caracteres */ }
\n                { /* Ignora nova linha */ }
%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Could not open file");
            return 1;
        }
        yyin = file;
    }

    yylex();
    printf("Number of words starting with uppercase letters: %d\n", uppercase_word_count);

    return 0;
}

int yywrap() {
    return 1;
}
