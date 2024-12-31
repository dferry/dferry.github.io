%David and class
% 1/22/2020
% Two dimensional arrays - matrices

v = ones( 1, 5 )
u = zeros( 5, 1) 

M = ones( 2, 3 )

%Vector syntax still applies
M'

%Sum is not the same - sums each column
sum(M)

%Sum of all elements of M
sum(sum(M))

%Create literally 
A = [ 1 2 3; 4 5 6 ]

B = [ 1 2 3; 4 5 6; 7 8 9 ]

%Same as vectors - scalar functions
sqrt( B ) 

%Vector functions - behavior might change
sum( A )
min( A )
max( A ) 
sort( A )

%%

%indexing matrices
A = [ 1 2 3; 4 5 6 ]

B = [ 1 2 3; 4 5 6; 7 8 9 ]

B(1,2)
B(2,1)

B
B(3, 2:3)

B( 2:3, 2:3)

B
B( 2:3, 1:2 )

%%

%Concatenating matrices

% Recall - vector concatenation
v = [ 1 2 3 ]
u = [ 40 50 ]

w = [ v u ]
t = [ u v ]

A = [ 1 2 3; 4 5 6 ]
B = rand(2,2)

C = [ A B ] 

%D = [ A; B ] %Error - result must be a rectangle

E = [ A B; B A ]


%Scalar functions on matrices

sqrt( E ) %Applied to every element of the matrix

%Matrix functcions

E' %transpose
fliplr( E )
flipud( E )

%Vector functions can be tricky
E
max( E ) %max of each column
max( max( E ) )%Max element of whole matrix

%%
%Operations on matices - same as vectors

A = [ 1 2; 3 4 ]
B = [ 10 20; 30 40 ]

A + B
A - B

%Matrix multiplication
A * B

%Element-wise operations
A .* B
B .^ A








