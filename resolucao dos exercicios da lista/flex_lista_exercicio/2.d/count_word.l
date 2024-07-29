%{
#include <stdio.h>

int char_count = 0;
int word_count = 0;
int line_count = 0;

%}

%%

[a-zA-Z]+   { word_count++; char_count += yyleng; }
\n          { line_count++; char_count++; }
.           { char_count++; }
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

    printf("Number of characters (bytes): %d\n", char_count);
    printf("Number of words: %d\n", word_count);
    printf("Number of lines: %d\n", line_count);

    return 0;
}

int yywrap() {
    return 1;
}
