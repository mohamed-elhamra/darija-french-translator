%{
        #include "y.tab.h"
        void yyerror (char *s);
        int yylex();
        #include <stdio.h>
        #include <string.h>
        #include <ctype.h>
        #include <stdlib.h>

%}
%%
,                                                                                                                               {yylval.virgule = yytext[0];return VIRGULE;}
"Ceci"                                                                                                                          {yylval.string = strdup(yytext);return PRONOMDEMONSTRATIF;}
"prefere"|"est"|"attrape"|"mange"|"sort"|"boivent"                                                                              {yylval.string = strdup(yytext);return VERBEPRESENT;}
"un"|"le"|"la"|"les"|"une"|"l'"                                                                                                 {yylval.string = strdup(yytext);return ARTICLE;}
"armoire"|"poires"|"pomme"|"pommes"|"sport"|"velo"|"Manal"|"ballon"|"chien"|"balle"|"patients"|"medicamment"|"poterie"          {yylval.string = strdup(yytext);return NOM;}
"le mien"                                                                                                                       {yylval.string = strdup(yytext);return PRONOMPOSSESSIF;}
"arrivera"|"evitera"                                                                                                            {yylval.string = strdup(yytext);return VERBEFUTUR;}
"demain"|"aujourd'hui"                                                                                                          {yylval.string = strdup(yytext);return CCT;}
"petit"                                                                                                                         {yylval.string = strdup(yytext);return ADJECTIF;}
"du"|"aux"|"de"                                                                                                                 {yylval.string = strdup(yytext);return PREPOSITION;}
"courir"                                                                                                                        {yylval.string = strdup(yytext);return VERBEINFINITIF;}
"je"|"elle"                                                                                                                     {yylval.string= strdup(yytext);return PRONOMPERSONNEL;}
[ \n\t]+                                                                                                                        {;}
.                                                                                                                               {yyerror("Unexpected character\n");}
"point"                                                                                                                         {yylval.point = yytext[0];return POINT;}
%%

int yywrap()
{
        return 1;
}
