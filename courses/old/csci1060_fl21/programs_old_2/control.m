%David and class
% 1/31/2020
% Control structures

%If/then

x = 5;

if x < 10
    disp( 'This statement prints' );
end
disp('This statemtent also prints' );

%%
clear;clc;

x = 55;

if x < 10
    disp( 'This statement does not print' );
end
disp('This statemtent also prints' );


%%
clear;clc;

A = 30;

if A < 20
    disp( 'The upper statement prints' );
else
    disp( 'The lower statement prints' );
end

%%

%Logical negation

p = 0.5;

if ~( p < 0.25 )
   disp( 'P is not less than 0.25' ); 
end
    
%%
clear;
clc;

x = 15;

if x < 5
    disp('X is less than 5');
elseif x > 10
    disp('X is greather than 10');
end

%Could be written as

if x < 5
   disp('X is less than 5');
end

if x > 10
   disp('X is greater than 10');
end

%%

%Elseif with multiple variables
clear;clc;

a = 5;
b = 10;
c = 15;

if a > 10
   disp('Condition 1'); 
elseif b < 20
   disp('Condition 2'); 
elseif c < 50
   disp('Condition 3');
else
    disp('No conditions triggered');
end

%%
clear;clc;

for x = 1:10 %X is called a LOOP variable
    disp('Iteration')
    disp(x)
end

%%

clear; clc;

for x = [ 1 2 3 8 10 ]
    x*x
end

%%

clear; clc;

for x = 2:2:10
   x*x 
end

%%

%Second type of loop - while loop

%While loop - checks conditional

x = 0;

while x < 10
    x = x + 1;
    disp(x)
end

%%
clear; clc;

x = 2

while x <= 10
   disp(x) 
    x = x + 2;
end

%%
    
%When to use WHILE vs FOR loops?

% FOR LOOPS - iteratate over a finite vector
% WHILE LOOPS - checks a condition

%%

%Two special loop control statatements
% break - Stop the loop, jump to END
clear;clc;
for x = 1:10
    if x > 5 
        break;
    end
    disp(x)
end

%%

%continue statement - starts next iteration
% immediately

clear;clc;
x = 0;
while x <= 10
    x = x + 1;
    disp('Before')
    disp(x)
    if x <= 5
        continue;
    end
    disp('After')
end















