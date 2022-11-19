%{
int numLigne=1;
int opr=0;
%}

%union{
int entier;
}

%token idf mc_langage mc_var dp pvg mc_int mc_float mc_bool vg mc_begin mc_end aff <entier>cst mc_const mc_if pt plus err mult division moins
par_ouvrante par_fermante sup inf mc_while mc_func mc_return;
%%
S:mc_langage idf mc_var ListeDec ListeFonction mc_begin ListeInsts mc_end {printf("syntaxe correcte\n"); YYACCEPT;}
;
ListeDec: Dec ListeDec
	  |Dec
;
ListeFonction: Fonction ListeFonction | Fonction
;
Fonction: Type mc_func idf mc_var ListeDec mc_begin ListeInsts mc_return idf pvg mc_end
;
Dec :DecSimple | DecConst
;
DecSimple: ListeIdfs dp Type pvg
;
DecConst: ConstInt | ConstFloat /* essayer de faire une liste de DecConst*/
;
ConstInt: idf aff cst dp mc_const mc_int pvg
;
ConstFloat : idf aff cst pt cst dp mc_const mc_float pvg
;
Type: mc_int
      |mc_float
      |mc_bool
;
ListeIdfs:  idf vg ListeIdfs
	    | idf
;
ListeInsts : INST ListeInsts
	    | INST
;
INST: Affectation | Condition_IF | Condition_WHILE |/*ajouter après le while et le if ..*/
;
Affectation : idf aff EXP pvg 
;
EXP: idf | idf OPERATEUR EXP | cst OPERATEUR EXP | cst
;
OPERATEUR: plus | | division | moins 
;
Condition_IF: mc_if par_ouvrante COND par_fermante mc_begin ListeInsts mc_end
;
Condition_WHILE: mc_while par_ouvrante COND par_fermante mc_begin ListeInsts mc_end
;
COND: EXP OPERATEUR_RELATIONEL EXP
;
/*EXP2:  cst | idf OPERATEUR EXP2 | cst OPERATEUR EXP2 | idf
;*/
OPERATEUR_RELATIONEL: aff aff | sup | inf | inf sup | sup aff | inf aff
;
%%
main()
{
printf("C'est le compilateur du langage miniAlgo:\n");
yyparse();
}
yywrap()
{}
int yyerror(char* msg)
{
printf("Erreur syntaxique à la ligne: %d\n", numLigne);
}
