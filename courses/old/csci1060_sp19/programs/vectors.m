%David and Class
%Jan 18, 2019
%Starting vectors

%Scalars:
x = 10
y = x
z = sqrt( 100 )

%Creating vectors

%Create vector literals
v = [ 1 3 5 7 ]
u = [ 2 4 6 8 10 12 ]

%Creating larger vectors
%1) With iteration notation

a = 1:10
b = 5:12
c = 1:2:20
d = 2:2:20
e = 10:-1:1
f = 5: -0.5 : 1


%2) With constant values
%zeros function and ones function

g = zeros( 1, 100 )
h = ones( 20, 1 )

%3) With linearly spaced values
lin = linspace(0, 1, 4)
lin2 = linspace(0, 1, 57)


%%
% Working with vectors: accessing

u = [ 1 3 5 7 9 ]
v = [ 2 4 6 8 10 ]

u(3) %gives third element
u(1) %gives first, etc.
v( 2:4 ) %gives second, third, and fourth
v(1:2:5) %gives first, third, and fifth

w = [ 1 3 5 ]
v(w) %same as v(1:2:5)

%%
%Vector assignment

u = [ 1 3 5 7 9 ]
v = [ 2 4 6 8 10 ]
w = [ 1 3 5 ]

v(3) = 0
u(w) = 0

u(w) = 1:3 %LHS and RHS are the same size
%u(w) = [1 2] %ERROR, RHS has size 3 and LHS has size 2

%Valid to assign past the length of the vector
%which extends the length of the vector
u(6) = 99
u(10) = 101010


%%
%Vector operations

u = [ 1  3  5  7 ]
v = [ 10 20 30 40 ]

%Element-wise operations
u+v
v-u

%Be careful with * / 
%Elementwise multiplication is .*
u.*v
v./u

%Other element-wise operations
u.^2

%%
%Matrix/vector oriented operations
%u*v - error
%v*u - error

%Note- orientation matters!
%Convert V into a colum vector
v'
u*v'
u'*v

%%
%Scalar-vector operations

u
u+10
10+u

u*10
u.*10

u.^2
2.^u

%%
% Building vectors from vectors
%AKA vector concatenation

u = [ 1 3 5 7 ]
v = [ 10 20 30 40 ]
w = [ 100 200 ]

 V = [ u v ]
 U = [ u w ]
 
% W = [u w'] %error

%%
%Scalars functions on vectors

u = 10:10:100

sqrt( u )

%Relational operations on vectors

u

u < 50
u ~= 70

%%
%Functions only defined for vectors

%Length of longest dimension
length(u)
length(V)

x = 10
length(x)

%Shape of the vector
%return value is a vector
size(u)
size(u')

r = rand(1,10)
max(r)
min(r)
mean(r)
sum(r)

sort(r)

%Ask for two return values, get the position of the max
[ value index ] = max(r)

%The find function
u = [ 1 0 0 3 0 5 0 0 0 7 0 0 ]
find(u)

%Find values greater than 4
u > 4
find( u > 4 )