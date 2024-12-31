%David and Class
%1/17/2020
%Notes on creating and using vectors

%Scalar
x = 10

%Vector - square bracket notation
v = [ 2 4 6 8 10 ]
u = []

%Using the : operator, I call this iterator notation
v = 1:5
v = 2.5:7.5
v = 2.5:7

%Use two colons to specify an increment

v = 1:2:10
v = 2:2:10
v = 1:4:100

v = 2:0.25:4

v = 10:-2:2

%%
% Creating vectors with functions

%Note - arguments are row followed by column
v = zeros(1,10)
u = zeros(10,1)

M = zeros(2,4)

v = ones(1, 10)

%Random numbers
v = rand(1, 5)

%Linearly spaced elements between a start and end
v = linspace(1, 5, 10)

start = 7
finish = 12
u = linspace( start, finish, 1000 )

%%

% Indexing vectors

v = [ 6 3 1 0 2 ]
v(1)
v(2)
v(5)

%Errors:
%v(0)
%v(6)

%Other useful accessing modes
v(end)
v(length(v))
length(v)

%Assign to vectors as well

v %v= [ 6 3 1 0 2 ]
v(2) = 9 %v= [ 6 9 1 0 2 ]

v(end) = -10 %v= [ 6 9 1 0 -10 ]

%We can also assign off the end of a vector
v(6) = 99
v(8) = 11

%Deleting elements
v(5) = [] %removes fifth element

%%

%indexing vectors with vectors

v = primes(25)
v(1)
v(2)
v(3)

1:3
v(1:3) 

v(1:2:9)
1:2:9

v(5:end)

%Also assignment
v(1:4) = [ 1 2 3 4 ]
v(1:4) = 99

%%
%Vector operations

clc
clear

a = [ 1 2 3 4 5 ]
b = [ 2 4 6 8 10 ]

c = a + b
d = b - a

e = -a

%Element-wise multiplication
f = a .* b

%Transposition
g = b'

%Matrix multiplication
h = g * b
i = b * g

j = a ./ b

k = a .^ b 

%Error - not same length
%l = [ 1 2 3 ] + [ 4 5 6 7 ]

%Concatenation

m = [ 1 2 3 ]
n = [ 4 5 6 ]

o = [ m n ]
p = [ n m ]
q = [ [ 1 2 3 ] [ 10 11 12 13 14 15 ] ]

% Error - not a rectangle
%r = [ m n' ]

%%
% Vector functions
clear
clc

%First type: scalar functions applied to vectors
a = (1:5).^2

b = sqrt( a )

%Second type: apply specifically to vectors

len = length( a )
vectorSize = size( a )
transposeSize = size( a' )

sum(a)
min(a)
max(a)
mean(a)

%Still works on scalars
x = 10
size( x )

%%
%Logical operators

a = 1:5
b = (a < 3)
c = (a == 4) %Does vector contain element

%How many fours?
d = [ 1 4 2 3 4 5 6 4 7 4 8 9 4 ]
e = ( d == 4 )
totalFours = sum( e )





