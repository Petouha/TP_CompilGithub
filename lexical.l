%{
#include "synt.tab.h"
#include <stdio.h>
extern int numLigne;
%}
lettre [a-zA-Z]
chiffre [0-9]
symbole chiffre | lettre 
idf {lettre}({lettre}|{chiffre}|_({chiffre}|{lettre}))*
L "LANGAGE"
cst [+-]([1-9][0-9]*|0)
/*Basically, si je mets la possibilité de faire un chiffre avec le moins, 
ça va poser problème avec l'instruction li fiha moins.
exemple : X=5*6-2 hadi au lieu de la voir comme un {6 "moins" 2}, ça
sera 6(-2) sans opérateur*/
%%
{L} return mc_langage;
VAR return mc_var;
INT return mc_int;
FLOAT return mc_float;
BOOL return mc_bool;
BEGIN return mc_begin;
END return mc_end;
CONST return mc_const;
IF return mc_if;
WHILE return mc_while;
{idf} return idf;
{cst} return cst;
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

