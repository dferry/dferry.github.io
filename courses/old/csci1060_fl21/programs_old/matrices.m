%Class discussion of matrices
%David Ferry Jan 26, 2018

clc;
clear;

m = [ 1 2 3; 4 5 6; 7 8 9; 10 11 12 ]

v1 = zeros( 1, 8); % one row, eight columns
v2 = zeros( 8, 1); % eight rows, one column
m1 = zeros( 5, 6);

u1 = ones( 1, 8); % one row, eight columns
u2 = ones( 8, 1); % eight rows, one column
m2 = ones( 5, 6);

randMat = randi(20, 7, 7 );

%%
%Vector indexing

clc;
clear;

m = magic(4)

%Assign a row
v = [-10 -20 -30 ]
m( 3, 2:4 )
m( 3, 2:4 ) = v

%assign a column
u = [ 10; 20; 30 ]
m( 1:3, 1 )
m( 1:3, 1 ) = u

%Flipping, transposing
%transpose
m'
%flip up-down
flipud(m)
%flip left-right
fliplr(m)

%%
% Matrix operations

A = [ 1 2; 3 4 ]
B = [ 5 6; 7 8 ]

%Element-wise
A.*B

%Matrix mult
A*B

%%
% MATLAB Secret

clc;
clear;

%This is a a 2-D Thing
m = magic(4)

%Stored in one dimension
m( 2, 2) %accesses row 2, column 2
m(6) %accesses the same location- element 6 
     %in column-major order

%Reshape m to be an 8-row, 2-column matrix
reshape(m, 8, 2)

