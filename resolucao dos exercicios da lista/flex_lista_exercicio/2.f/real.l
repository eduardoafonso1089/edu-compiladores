%{
#include <stdio.h>
#include <string.h>

#define MAX_VALUES 100
#define MAX_LENGTH 50

char values[MAX_VALUES][MAX_LENGTH];
int value_count = 0;

void store_value(const char *text);

%}

%%

R\$[ \t]*[0-9]+(\.[0-9]{3})*,[0-9]{2}  { store_value(yytext); }
[ \t\n]                               { /* Ignora espaços, tabs e novas linhas */ }
.                                     { /* Ignora outros caracteres */ }
%%

void store_value(const char *text) {
    if (value_count < MAX_VALUES) {
        strncpy(values[value_count], text, MAX_LENGTH);
        values[value_count][MAX_LENGTH - 1] = '\0'; // Garantir terminação
        value_count++;
    } else {
        fprintf(stderr, "Buffer de valores cheio.\n");
    }
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Não foi possível abrir o arquivo");
            return 1;
        }
        yyin = file;
    }

    printf("Por favor, insira o texto (CTRL+D para encerrar a entrada):\n");
    yylex();

    printf("Valores encontrados:\n");
    for (int i = 0; i < value_count; i++) {
        printf("%s\n", values[i]);
    }

    return 0;
}

int yywrap() {
    return 1;
}
