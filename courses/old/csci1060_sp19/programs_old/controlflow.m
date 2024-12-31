%Control flow in Matlab
%David and class

%for loop control
for x = 1:10
    disp( x )
end

%%
% Indexing a vector

v = [ 4 6 8 10 12 11 9 7 5 3 ];
for x = 1:10
    v(x)
end

%% Assignment to vector

v = [ 4 6 8 10 12 11 9 7 5 3 ];
for x = 10:-1:2
    v(x) = v(x-1);
end
v

%%
% Vector element-wise operations with for loops

v = [ 4  6  8  10 12 11 9  7  5  3 ];
u = [ 10 20 30 40 50 60 70 80 90 100 ];

%Equivalent to "v+u"
for x = 1:length(v)
    v(x) = v(x) + u(x);
end
v

%%
% Vector scalar operations with for loops
v = [ 4 6 8 10 12 11 9 7 5 3 ];

%Equivalent to "v+5"
for x = 1:length(v)
    v(x) = v(x) + 5;
end
v

%%
% Computing factorial! with for loops 
clc; clear;

N = 5;
result = 1;
for x = 1:N
    result = result*x
end
result


%%
% while loops 
limit = 10;
x = 1;
while x <= limit
    disp( x )
    x = x + 1;
end

%%
% Vector element-wise subtraction with a while loop
% u = u-v

v = [ 4  6  8  10 12 11 9  7  5  3 ];
u = [ 10 20 30 40 50 60 70 80 90 100 ];

x = 1;
while x <= length(v)
    u(x) = u(x) - v(x);
    x = x + 1;
end
u

%%
% Example of a while loop that's hard to phrase as a
% for loop
clc; clear;

v = [ 4  6  8  10 12 11 9  7  5  3 ];
x = 1;

while( v(x) <= 10 )
    disp( v(x) );
    x = x + 1;
end

%%
% Conditional if-then statements
clc; clear;

value = 12; 

if value <= 5
    disp('First executed!');
end
if value > 10
    disp('Second executed');
end

%%
% More complex conditionals
clear; clc;

value = 12;

if value > 10
   if mod(value, 2) == 0 %Tells us "value" is even
       disp('Input is greater than 10 and even');
   end
end

%%
% Alternate version of above... probably not the best
% idea
clc; clear;

value = 8;

if (value > 10) && (mod(value, 2) == 0)
   disp('Value is greater than 10 and even'); 
end

%%
% If-then-else
clc; clear;

value = 3;
if value < 5
    disp('statement one');
elseif value < 10
    disp('statement two');
else
    disp('statement three');
end

%%
% SWITCH statement
clc; clear;
value = 3;

switch value
    case 1
        disp('Triggered case 1');
    case 2
        disp('Triggered case 2');
    case 3
        disp('Triggered case 3');
    case 4
        disp('Triggered case 4');
    case 5
        disp('Triggered case 5');
    otherwise
        disp('Triggered OTHERWISE');
end
    
