
#include <stdio.h>

int main( int argc, char* argv[] ){

char *string_literal = "Hello world!\n";

printf("My string: %s", string_literal);
printf("String is at: %p\n", string_literal);

//Does this work? No!
//string_literal[0] = "W";

string_literal = "New string entirely!\n";

printf("My new string: %s", string_literal);
printf("String is now at: %p\n", string_literal);


//printf("printing by address: %s\n", 0x400650);

//Character array
char string[100] = "This is a character array!\n";
printf("My array: %s", string);
printf("Location of string: %p\n", string);
printf("Printing just a character: %c\n", string[0]);

string[0] = 'H';
string[1] = 'e';
string[2] = 'r';
string[3] = 'e';

printf("Modified string: %s", string);
}
