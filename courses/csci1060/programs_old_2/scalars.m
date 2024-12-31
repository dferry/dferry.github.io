%David and Class
%1/ 15/ 2020
%Notes on scalars, order of operations, functions,etc.

%Define scalar values
x = 10
y = 20
z = x + y

accelerationOfGravity = 9.8 %m per sec squared
gravity = 9.8

noSpace=40;

%Scalars are single data values, as opposed to what?
% Vector:

v = [ 2 4 6 8 10 ]

%Scalars can be whole numbers, decimal, etc.
numStudents = 27
gravity = 9.8
oneMillion = 1e6

%%

%Predefined constants
pi
i
j
Inf
NaN

1e400
5/0
Inf-Inf

%Note- no predefined e, use exp() instead
% exp(1) == e

%%
%Operators: everything you expect is there

5 + 5
10 - 5
5 * 5
50 / 10
2^3

%Also includes operators you don't expect
50 / 10
10 \ 50 


%%
%Order of operations
% P E (MD) (AS)

%Example - not clear
9 + 6 / 3

%Answer - always just use parentheses
(9 + 6) / 3

%%

%Logical operators

3 < 8
8 > 13
5 == 10 
5 ~= 10 
5 <= 5
10 >= 5

%logical negation
~1
~0

%Order of operations is important

5 > 3 < 10
(5 > 3) < 10

%%

%Functions - stored procedures
sqrt(100)
sqrt(49)
abs(-7) %absolute value

help sin
doc sin
doc plot

%To get exponential constant
% exp(1) == e^1
e = exp(1)
% exp(2) == e^2

%%
factorial(5)

log(10)
log10(10)
log2(10)

sin(0)
cos(0)
tan(0)

sind(180)
cosd(180)
tand(180)

round(4.5)
ceil(4.2)
floor(4.7)

