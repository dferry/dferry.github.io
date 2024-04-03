/* debug me */
%{
#include <stdio.h>
#include <stdlib.h>
int lnumber =0, cnumber =0, wnumber=0; /*count number of lines, chars and words */
%}
character [a-zA-Z]
digit [0-9]
word ({character}|{digit})+
line \n
%%
{line} { lnumber++; cnumber++; }
{word} { wnumber++; cnumber += strlen(yytext); }
. { cnumber++; }  /* count all other chars */
%%
void main() {
yylex();
fprintf(stderr,"Number of characters: %d; number of words: %d; number of lines: %d",cnumber,wnumber,lnumber);
return;
}
