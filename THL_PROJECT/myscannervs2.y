%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include <ctype.h>
void yyerror (char *s);
int yylex();
//#include <stdio.h>     /* C declarations used in actions */
//#include <stdlib.h>
//#include <ctype.h>
extern int yylineno;
extern FILE *yyin;
extern char *yytext;
char *concat(char *s1,char *s2);
char *search(char *symbol);

%}

          /* Yacc definitions */
%union {char virgule ;char* string;char point;}
%start PHRASE
%token <string> ARTICLE
%token <string> NOM
%token <string> ADJECTIF
%token <string> VERBEINFINITIF
%token <string> PRONOMPERSONNEL
%token <string> PRONOMDEMONSTRATIF
%token <string> PRONOMPOSSESSIF
%token <string> VERBEPRESENT
%token <string> VERBEFUTUR
%token <string> CCT
%token <string> PREPOSITION
%token <virgule> VIRGULE
%token <point> POINT
%type<string> PHRASE 
%type<string> SUJET 
%type<string> VERBE 
%type<string> COMPLEMENT 
%type<string> PRONOM 
%type<string> COD
%type<string> COI



        /*description of expected inputs*/

%%
       /*SYNTAXE PHRASES AFFIRMATIVES SIMPLES*/
PHRASE : SUJET VERBE COMPLEMENT POINT                {$$ = concat(concat($1,$2),$3);printf(" %s",$$);}
       | CCT SUJET VERBE COMPLEMENT POINT            {$$ = concat(concat(concat(search($1),$2),$3),$4);printf(" %s",$$);}    
       | SUJET VERBE CCT COMPLEMENT POINT            {$$ = concat(concat(concat($1,$2),search($3)),$4);printf(" %s",$$);}
       | SUJET VERBE COMPLEMENT CCT POINT            {$$ = concat(concat(concat($1,$2),$3),search($4));printf(" %s",$$);}
       | CCT SUJET VERBE POINT                       {$$ = concat(concat(search($1),$2),$3);printf(" %s",$$);}
       | SUJET VERBE CCT POINT                       {$$ = concat(concat($1,$2),search($3));printf(" %s",$$); }
       | SUJET VERBE POINT                           {$$ = concat($1,$2);printf(" %s",$$);}
       | PHRASE PHRASE                              
       ;

       /*SYNTAXE DE SUJET*/
SUJET  : ARTICLE NOM                                 {$$ = concat(search($1),search($2));}
       | ARTICLE ADJECTIF NOM                        {$$ = concat(concat(search($1),search($2)),search($3));}
       | PRONOM                                  
       | VERBEINFINITIF                              {$$ = search($1);}
       ;

       
       /*SYNTAXE DE TYPES PRONOMS*/
PRONOM : PRONOMPERSONNEL                             {$$ = search($1);}                              
       | PRONOMDEMONSTRATIF                          {$$ = search($1);}
       | PRONOMPOSSESSIF                             {$$ = search($1);}
       ;

       /*SYNTAXE DES COMPLEMENTS*/
COMPLEMENT : COD                                 
           | COD COI                                {$$ = concat(search($1),search($2));} 
           | COI                                 
           ;

COD : ARTICLE NOM                                   {$$ = concat(search($1),search($2));}
    | ARTICLE ADJECTIF NOM                          {$$ = concat(concat(search($1),search($2)),search($3));}
    ;
   
COI : PREPOSITION NOM                               {$$ = concat(search($1),search($2));}
    ;

       /*SYNTAXE DES VERBES*/
VERBE : VERBEPRESENT                                {$$ = search($1);}
      | VERBEFUTUR                                  {$$ = search($1);}
      ;


   

%%
void yyerror (char *s) {fprintf (stderr, "%s\n", s); exit(1);}

char* concat(char* s1, char* s2)
{
    char* result = (char*)malloc(strlen(s1) + strlen(s2) + 1);
    
    strcpy(result, s1);
    strcat(result, " ");
    strcat(result, s2);
    return result;
}

char* search(char *symbol) {
    FILE *yyin;
    yyin = fopen("/Users/pro/Desktop/test.in", "r");
    char* symb=(char*)malloc(sizeof(char)*10+1);
    char* equivalent=(char*)malloc(sizeof(char)*10+1);
    if (yyin==NULL)
    {
        printf("no such file.");
    }
    
    while( fscanf(yyin, "%s %s", symb, equivalent) != EOF)
    {
        
        if(strcmp(symbol,symb)==0) break;
        
    }
    
    fclose(yyin);
    
    
    return equivalent;
}

int main(){
    yyparse();
    exit(0);
    return 0;
}
