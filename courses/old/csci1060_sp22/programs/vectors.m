%David and class
% Feb 5th, 2021
% Vectors and vector operations

%Declaring a scalar
x = 15

%Declaring a vector
fib = [ 1 3 5 8 13 21 ]

%Access a scalar
x

%Accessing a vector
fib
%Indexing into a vector
fib(1)
fib(5)

%Special properties of vectors
length(fib)
fib(end)

%A more general size function
size(fib)
fib' %transpose vector
size(fib')

%Modify vectors
fib
fib(3) = 99

%Delete elements
fib(3) = [] %This is the empty vector

%Automtically extend vectors
fib(10) = 10

%delete the entire vector
fib = []


%%

%Generating vectors

%Declaring a vector explicitly
fib = [ 1 3 5 8 13 21 ]

%Creating a vector with iterating notation
1:10
v = 1:15

u = 7:12

%The full incremental form is
v = 1:1:15
p = 1:2:15
p = 1:2:16 %Note this is identical to above statement

%Different increments can used
1:0.25:5
5:-1:1
1.5:1:6.5

%You can specify an empty vector
q = 5:3:-5

%%

%Creating vectors with functions

zeros( 1, 10 ) %One row, 10 columns
ones(4, 1)
rand(1, 10)
randi( 5, 1, 10 )

%More specific vector generation
primes(15)

%Equally spaced values between a start and end
l = linspace(1, 5, 20)


%%

%Accessing vectors with other vectors (array slicing)

fib = [ 1 1 2 3 5 8 13 21 34 55 ]
fib( 3:5 )
fib( [3 7] )
fib( 1:2:9 )
fib( 2:2:length(fib) )
fib( 2:2:end )
fib( 1:3:end )

%Can also use this iterating notation to modify vector
fib( 1:3:end ) = 11:11:44


%%

%Vector operations
v = 1:5
v + 1
v - 2

%NOTE: We should specify element-wise multiplication and division
v .* 2
v ./ 2
v .^ 2

%Multiplying vectors
u = 6:10
%v*u %error - not well defined
v.*u %Element by element multiplication 
v*u' %Matrix multiplication - dot product

%Concatenating vectors
w = [ u v ]
w = [ u v u ]






















