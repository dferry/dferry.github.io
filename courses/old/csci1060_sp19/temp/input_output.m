%Input/Output and text data
% David and class
% Feb, 15, 2019

myText = 'Scientific Programming';

disp( myText )

sorted = sort( myText );

disp( sorted )

string = 'SLU';
disp( string )
uint8( string )

%%
% Treating text as a vector

str1 = 'David'
str2 = 'Ferry'

%Concatenation
join = [ str1 ' ' str2 ]
stack = [ str1; str2 ]

%Access
V = stack(1,3) %should be v
E = stack(2,2) %should be e
join( 3:7 )

%Assignment
join(6) = '!'

%Caution!!!!
number = '123'
number = number + 5 %don't do this
char( number )


%%
%Converting between text data and integer data

text_form = '73'
numeric_form = str2num( text_form )

numeric_form = numeric_form + 20

disp( [ 'My result is ' numeric_form ] ) %doesn't do what we want

%to convert back...
new_text = num2str( numeric_form )

disp( [ 'My new result is ' new_text ] )

%Also these functions do floating point

pi_text = num2str(pi);

disp( [ 'Value of pi: ' pi_text ] )

%%
%Formatted output

%ex:
fprintf('This is a formatted output string\n');

x = 10
y = 20

fprintf('String with variables. x: %d   y: %d  pi: %0.3f\n',x, y, pi)

%Printing floating point (decimal point) numbers

fprintf('Many faces of pi: %0.1f   %0.3f   %0.5f   %0.15f\n',pi,pi,pi,pi);

%Controlling leading spacing

fprintf('Pi again: %0.1f, %3.1f, %5.1f\n', pi,pi,pi);

a = 1000.5
b = 22.2
c = 1.159

fprintf('%6.1f\n%6.1f\n%6.1f\n', a, b, c )

%%
% Creating strings with sprintf

message = 'My result is'
value = 42;

myStr = sprintf('%s: %d', message, value);

disp( myStr )


%%
%Getting user input

choice = input('Please enter a number between 1 and 5')

fprintf('The user entered %d\n', choice );

if choice <= 1 || choice >= 5
    fprintf('That is an invalid value\n'); 
end


%%
%A little safer form
choice = input('Please enter a number between 1 and 5', 's')

fprintf('The user entered %s\n', choice );

%if choice <= 1 || choice >= 5
%    fprintf('That is an invalid value\n'); 
%end
