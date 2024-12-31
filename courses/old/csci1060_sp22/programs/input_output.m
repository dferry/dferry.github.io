%Basic input and output and text representation
%David and Class
% 2/10/2020

%Text data
words = 'Hello, world!'

%Stored as an array of characters
sort(words)

%Get numeric values of characters
asNumbers = double( words )

%Get characters from numeric values
asChars = char( asNumbers )

%Build strings just from numbers
SLU = [ 83 76 85 ]
char( SLU )

%Anything we can do with numbers, we can do
%with characters

aCharacter = 'a'

char( aCharacter + 5 )

char( aCharacter - 5 )

%Converting numbers to strings
x = 83
int2str(x)

%Converting non-integers
num2str(pi, 9)

%Converting strings to numbers
stringWithNum = '345'
str2num( stringWithNum )

%This is an error- returns []
%str2num( 'forty-five' )

%%

%Formatted output with fprintf()

low = 1;
high = 10;

%Clunky way:
disp('Pick a value between')
disp(low)
disp(' and ')
disp(high)

%Elegant solution:
%Integers
fprintf('Pick a value between %d and %d\n', low, high );

%strings
firstName = 'David'
lastName = 'Ferry'

fprintf('My name is %s %s\n', firstName, lastName );

%Decimal numbers
fprintf('The value of pi is: %.4f\n', pi )

%%

%For homework 4:

year = 2008
month = 5
day = 29

value = 20

fprintf('The stock had value %d on %d/%d/%d\n', value, year, month, day);








