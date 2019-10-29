%{
  #include <stdio.h>
  int yylex(void);
  int yyparse(void);
  int yyerror(char *);
  extern int yylineno;
  int brojacTacka=0;
  int brojacUpitnik=0;
  int brojacUzvicnik=0;
%}

%token  DOT
%token  CAPITAL_WORD
%token  WORD
%token UPITNIK
%token UZVICNIK

%%

text 
  : sentence
  | text sentence
  ;
          
sentence 
  : words DOT     {brojacTacka++;}
  | words UPITNIK {brojacUpitnik++;}
  | words UZVICNIK {brojacUzvicnik++;}
  ;

words 
  : CAPITAL_WORD
  | words WORD
  | words CAPITAL_WORD    
  ;

%%

int main() {
  yyparse();
  printf("\nBroj obavestajnih :%d",brojacTacka);
  printf("\nBroj upitnih :%d",brojacUpitnik);
  printf("\nBroj uzvicnih :%d",brojacUzvicnik);

}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
} 

