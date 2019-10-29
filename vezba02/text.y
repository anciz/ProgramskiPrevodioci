%{
  #include <stdio.h>
  int yylex(void);
  int yyparse(void);
  int yyerror(char *);
  extern int yylineno;
  int brojacTacka=0;
  int brojacUpitnik=0;
  int brojacUzvicnik=0;
	int brojacPasusa=0;
%}

%token  DOT
%token  CAPITAL_WORD
%token  WORD
%token UPITNIK
%token UZVICNIK
%token ZAREZ
%token NOVIRED

%%

text 
  : pasus NOVIRED { brojacPasusa++;}
  | text pasus NOVIRED {brojacPasusa++;}
	| NOVIRED {brojacPasusa++;}
	;

pasus
	: sentence 
	| pasus sentence 
	;

sentence 
  : words DOT     {brojacTacka++;}
  | words UPITNIK {brojacUpitnik++;}
  | words UZVICNIK {brojacUzvicnik++;}
  
  ;

words 
  : CAPITAL_WORD
  | words WORD
  | words ZAREZ WORD
  | words ZAREZ CAPITAL_WORD
  | words CAPITAL_WORD    
  ;

%%

int main() {
  yyparse();
  printf("\nBroj obavestajnih :%d",brojacTacka);
  printf("\nBroj upitnih :%d",brojacUpitnik);
  printf("\nBroj uzvicnih :%d",brojacUzvicnik);
  printf("\nBroj pasusa :%d \n",brojacPasusa);


}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
} 

