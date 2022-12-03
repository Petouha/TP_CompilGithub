#include<string.h>
#include<stdio.h>
typedef struct 
{
    char nomEntite[20];
    char codeEntite[50];
    char typeEntite[20];    
    int constant;
}TypeTS;

TypeTS ts[100];

int cptTS = 0;



int recherche(char entite[])
{
int i=0;
while(i<cptTS)
  {
    if (strcmp(entite,ts[i].nomEntite)==0) return i;
    i++;
  }
return -1;
}





void inserer(char entite[], char code[])
{

if ( recherche(entite)==-1)
        {
        strcpy(ts[cptTS].nomEntite,entite); 
        strcpy(ts[cptTS].codeEntite,code);
        cptTS++;
        }
}

void afficher ()
{
printf("\n/***************Table des symboles ******************/\n");
printf("______________________________________\n");
printf("\t| nomEntite |  codeEntite | TypeEntite \n");
printf("______________________________________\n");
int i=0;
  while(i<cptTS)
  {
    printf("\t|%10s |%12s  |%10s \n",ts[i].nomEntite,ts[i].codeEntite, ts[i].typeEntite);
     i++;
   }
}

void insererType(char entite[], char type[])
{
  int posEntite = recherche(entite);
    if (posEntite != -1)
    {
      strcpy(ts[posEntite].typeEntite,type);
    }
    
}


int doubleDec(char entite[])
{
  int posEntite = recherche(entite);
    if (strcmp(ts[posEntite].typeEntite,"")==0)
    {
      return 0;
    }
    else return 1;
    
}