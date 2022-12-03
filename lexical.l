%{
#include "synt.tab.h"
#include <stdio.h>
#include"lib.h"
extern int numLigne;
extern YYSTYPE yylval;
%}
lettre [a-zA-Z]
chiffre [0-9]
idf {lettre}({lettre}|{chiffre}|_({chiffre}|{lettre}))*
L "LANGAGE"
cst {chiffre}+
/*Basically, si je mets la possibilité de faire un chiffre avec le moins, 
/*ça va poser problème avec l'instruction li fiha moins.
/*exemple : X=5*6-2 hadi au lieu de la voir comme un {6 "moins" 2}, ça
/*sera 6(-2) sans opérateur*/
%%
{L} return mc_langage;
VAR return mc_var;
INT {yylval.str=strdup(yytext); return mc_int;}
FLOAT  {yylval.str=strdup(yytext); return mc_float;}
BOOL {yylval.str=strdup(yytext); return mc_bool;}
BEGIN return mc_begin;
END return mc_end;
CONST return mc_const;
IF return mc_if;
WHILE return mc_while;
FUNCTION return mc_func;
RETURN return mc_return;
{idf} {if (yyleng <=12){ 
        yylval.str=strdup(yytext);
        inserer(yytext,"idf",str_type);
        return idf ;}

      else printf ("erreur lexicale : idf %s trop long\n",yytext) ;
        }

{cst} { yylval.entier=atoi(yytext);
        return cst;
		}
: return dp;
; return pvg;
, return vg;
= return aff;
\. return pt;
\+ return plus;
\* return mult;
\/ return division;
\- return moins;
\( return par_ouvrante;
\) return par_fermante;
\> return sup;
\< return inf;
[ \t]
[\n] numLigne++;
. {printf("Erreur Lexical à la ligne %d sur l'entite %s\n",numLigne,yytext);
return err;}

