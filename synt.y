%{
int numLigne=1;
int opr=0;
char sauvType[20];
%}

%union{
int entier;
char* str
}

%token <str>idf mc_langage mc_var dp pvg <str>mc_int <str>mc_float mc_bool vg mc_begin mc_end aff <entier>cst mc_const mc_if pt plus err mult division moins
par_ouvrante par_fermante sup inf mc_while mc_func mc_return;
%%
//axiome principale S
S:mc_langage idf mc_var ListeDec ListeFonction mc_begin ListeInsts mc_end {printf("syntaxe correcte\n"); YYACCEPT;}
;

//Les déclarations de variables / constantes

ListeDec: Dec ListeDec | Dec
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

//les déclarations des fonctions

ListeFonction: Fonction ListeFonction | Fonction | //epsilon
;
Fonction: Type mc_func idf mc_var ListeDec mc_begin ListeInsts mc_return idf pvg mc_end
;

// les types
Type: 		mc_int {strcpy(sauvType,$1);}
 			| mc_float {strcpy(sauvType,$1);}
 		 	| mc_bool {strcpy(sauvType,$1);}

;

//les variables 
ListeIdfs:  idf vg ListeIdfs {}
			 | idf
;

//les instructions
ListeInsts : INST ListeInsts | INST
;
INST: Affectation | Condition_IF | Condition_WHILE |/*ajouter après le while et le if ..*/
;

Affectation : idf aff EXP pvg 
;

//expressions arithmétiques
EXP: idf | idf OPERATEUR EXP | cst OPERATEUR EXP |cst
	 				{if($1==0 && opr==3) 
 					{	printf("divison par 0\n");
					return err;
					}
					}
;
OPERATEUR: plus {opr=1;} | mult {opr=2;} | division {opr=3;} | moins {opr=4;}
;

//boucles itératives
Condition_IF: mc_if par_ouvrante COND par_fermante mc_begin ListeInsts mc_end
;

Condition_WHILE: mc_while par_ouvrante COND par_fermante mc_begin ListeInsts mc_end
;

//les conditions
COND: EXP OPERATEUR_RELATIONEL EXP
;
OPERATEUR_RELATIONEL: aff aff | sup | inf | inf sup | sup aff | inf aff
;


%%
main()
{
printf("C'est le compilateur du langage miniAlgo:\n");
yyparse();
afficher();
}
yywrap()
{}
int yyerror(char* msg)
{
printf("Erreur syntaxique à la ligne: %d\n", numLigne);
}
