%Control flow in MATLAB
% Feb 4, 2019
% David and Class

%IF statements allow us to execute code conditionally
a = 15
b = 10

if a > b
    disp('A is greater than B')
end

if b > a
    disp('B is greater than A')
end

%%
% Two things true simultaneously
a = 5
b = 10
x = 9
if x > a
   if x < b
      disp('X is between A and B')
   end
end

%Logically identical to above, uses logical AND
if (x > a) && (x < b)
    disp('X is between A and B')
end

%%
%If either of two this is true, use logical OR
a = 5
b = 10
x = 3

if (x < a) || (x > b)
   disp('X is less than A, OR X is greater than B'); 
end

%%
%Multiple if statements, if-elseif-else statements

a = 5
b = 10
c = 15
x = 3

if x < a
   disp('X is less than A') 
elseif x < b
   disp('X is less than B, AND X is greater or equal to A')
elseif x < c
   disp('X less than C, AND X greater or equal to A AND X is greater or equal to B')
else
   disp('X is greater than A, B, AND C')
end

%%
% FOR LOOPS

for x = [1 3 5 8]
    x
end

%%

for x = 1:5
    x
end

%%
%Execute in order

for x = 5:-1:1
   x 
end

%%
%Dice simulation from yesterday
N = 10;
%results = zeros(N,1);

for x = 1:N
    dice1 = randi(6);
    dice2 = randi(6);
    results(x) = dice1 + dice2; 
end

results

%%
%Combining an IF statement with a FOR loop
%Goal: Print out position and value of every element >= 5

values = randi(10,10,1)

N = 10;
for x = 1:N
   
    if values(x) >= 5
       disp('Position')
       disp(x)
       disp('Value')
       disp(values(x))
    end
    
end

%We can try to do this with vector ops... but it's hard

results = values >= 5
indices = find(results);

disp('Indicies of values >= 5')
indices
disp('Values >= 5')
values(indices)

%%
%WHILE LOOP
%Loops until a condition is false

x = 1;
while x < 10
disp(x)
x = x + 2;
end

%%

N = 10
index = 1
results = []

while index <= N

    dice1 = randi(6);
    dice2 = randi(6);
    results(index) = dice1 + dice2
    index = index + 1;
    
end

%%
%A while loop using break and continue

index = 1;
stop = 10;

while 1
   
    disp('My number is ');
    disp(index);
    
    if index == stop
        break;
    end
    
    index = index + 1;
    
    if index < 6 
       continue;
    end
    
    disp('This value is >= 5');
end



%%
% the SWITCH statement
a = 5
switch a+1
    case 1
        disp('Case a=1');
    case 2
        disp('Case a=2');
    case 5
        disp('Case a=5');
    otherwise
        disp('OTHERWISE executes');
end









