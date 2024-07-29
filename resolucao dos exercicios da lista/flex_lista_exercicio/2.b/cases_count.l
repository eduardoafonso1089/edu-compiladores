%{
#include <stdio.h>

int uppercase_count = 0;
int lowercase_count = 0;
int number_count = 0;

%}

%%

[A-Z]    { uppercase_count++; }
[a-z]    { lowercase_count++; }
[0-9]    { number_count++; }
.        { /* Ignora outros caracteres */ }
\n       { /* Ignora nova linha */ }
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
    printf("Type the text and press CTRL+D to check the results! \n");
    yylex();
    printf("Number of uppercase letters: %d\n", uppercase_count);
    printf("Number of lowercase letters: %d\n", lowercase_count);
    printf("Number of numbers: %d\n", number_count);

    return 0;
}

int yywrap() {
    return 1;
}
