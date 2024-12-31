%Class discussion of vectors
%David Ferry
%Jan 24, 2018

%%
%Generating vectors
v = [ 5 10 15 20 ]
s = [ 5 5 7 7 9 9 ]
u = []

v100 = 1:100;
v1000 = 1:1000;

r = 5:2:13
q = 13:-2:5
t = 0:0.25:5

x = []; %Don't know size or contents
y = zeros(1,10) %Know the size but not contents
z = ones(1,5)

w = linspace(5, 12, 100)
w2 = linspace(0,10,4)

%%
%Indexing vectors
%

w2( 1 )
w2( 2 )
w2( 3 )
w2( 4 )

%Programmatically get end of vector
w2( end )
w2( length(w2) )

%Get vector slice
w2(2:4)

%%
% Permuting vectors

clc
clear

v = [2 4 6 8 10]
v(2) = 20
v(3:5) = [60 80 100]

v(1) = []

%%
% Something slightly complicated
clear
clc
evens = 2:2:100
neg_odds = -1:-2:-99
combined(1:2:99) = neg_odds
combined(2:2:100) = evens

combined

%%
% Vector Operations
clc
clear

x = 2;
y = 3;
v = [ 1 2 3 4 5 ];
u = [ 6 7 8 9 10 ];

%element-wise addition and subtraction
w = v + u
w2 = v - u

%element-wise multiplication and division
w3 = v .* u
w4 = u ./ v

%Transpose
v'

%mathematical vector multiplication
w5 = u * v'

%Scalar operations on vectors
v + 15
v * 5
v .^ 3

%Functions on vectors
sqrt(v)

%%
% relational and logical operations

clc
clear

v = [ 1 4 9 16 25 ]
v <= 10
v == 9
v ~= 9

v(3) == 9
v(4) == 9

%%
% A few data processing and vector functions

clc
clear

v = [ 1 2 3 4 5 ]
u = [ 6 7 8 9 10 ]

q = rand( 1, 8 )
r = randi( 10, 1, 8 ) %random integers between 1 and 10

sum(r)
meanr = mean(r)
medianr = median(r)
minr = min(r)
maxr = max(r)
sortR = sort(r)

s = [ 1 2 0 0 3 4 0 5 ]
findS = find(s)