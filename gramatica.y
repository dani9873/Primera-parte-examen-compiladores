%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(char *mensaje);
int yylex();
%}


%token MAIN DEC INPUT OUTPUT
%token CI CF COMA PCOMA PI PF
%token IGUAL SUMA RESTA MULTI DIV
%token IDENTIFICADOR NUMERO
%token COMENTARIO
%token IGUALDAD DIFERENTE MENOR MAYOR MENORIGUAL MAYORIGUAL AND OR NEQ
%token IF ELSE

%%

programa: MAIN CI bloque CF 
        ;

bloque: declara sentencia PCOMA otra_sentencia
        ;

declara: DEC lista_factors PCOMA
        | vacio
        ;
lista_factors: var otra_factors
        ;

otra_factors: COMA var otra_factors
        |vacio
        ;
if_stmt: IF PI condition PF CI otra_sentencia CF ELSE CI otra_sentencia CF sentencia
        ;

otra_sentencia: sentencia PCOMA otra_sentencia 
        | vacio
        ;
var: IDENTIFICADOR;
sentencia: asignacion
        |lectura
        | COMENTARIO
        | if_stmt
        | escritura
        ;

condition: expresion comparacion expresion
        ;

comparacion: IGUALDAD
        | DIFERENTE
        | MENOR
        | MAYOR
        | MENORIGUAL
        | MAYORIGUAL
        | NEQ
        | AND
        | OR
        ;

asignacion: IDENTIFICADOR IGUAL expresion
        ;

expresion: expresion SUMA termino
        | expresion RESTA termino
        | termino
        ;

termino: termino MULTI factor
        | termino DIV factor
        | factor
        ;

factor: NUMERO
        |IDENTIFICADOR
        ;
lectura: INPUT factor 
        ;
escritura: OUTPUT factor
        ;  

vacio:
        ;

%%

int main() {
        yyparse();
        return 0;
}

void yyerror(char *mensaje) {
        fprintf(stderr,"Error de sintaxis: %s\n", mensaje);
}