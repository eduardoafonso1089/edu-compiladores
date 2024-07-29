%{
#include <stdio.h>

int vowel_count = 0;
int consonant_count = 0;

%}

%%

[AEIOUaeiou]    { vowel_count++; }
[BCDFGHJKLMNPQRSTVWXYZbcdfghjklmnpqrstvwxyz] { consonant_count++; }
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

    printf("Please enter the text (CTRL+D to end input):\n");
    yylex();

    printf("Number of vowels: %d\n", vowel_count);
    printf("Number of consonants: %d\n", consonant_count);

    return 0;
}

int yywrap() {
    return 1;
}
