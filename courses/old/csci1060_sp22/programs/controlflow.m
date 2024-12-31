%David and class
%Feb 19, 2021
%Control Flow

clc;
clear;

%Simplest control structure is an if-statement
x = 3;
if x < 10
    disp( 'The statement is true' );
end

if x == 40
    disp('The variable is equal to 40')
end

if x ~= 40
    disp('The variable is not equal to 40')
end

%Note- zero is considered false, and anything nonzero
% is considered true

if 0
    disp('This will not print');
end

if 1
    disp('This will print');
end

if 7
    disp('This will also print');
end

if false
    disp('This statement will also not print');
end

if true
    disp('This statement is the third that will print');
end

x = true

if x == true
    disp('The variable evaluates to true');
end

%%

%Other types of if-statements

x = 10;
%Would be long-winded to say
if x < 7
    disp('X less than seven');
end
if x >= 7
    disp('X is greater or equal to seven');
end

x = 10;

%More concise, preferred form
if x < 7
    disp('X less than seven');
else
    disp('X greater than or equal to seven');
end
  
a = 47
%There are also if-elseif-else 
%Be careful- only ONE of the following statements executes
if a < 10
    disp('Statement 1');
elseif a < 15
    disp('Statement 2');
elseif a < 20
    disp('Statement 3');
else
    disp('Statement 4');
end
    
%%
    
%Second big form: loops
%Vector operations are pretty unique to MATLAB, e.g.:
v = 1:10;

%In most languages, we'd use a loop
for index=1:10
    %disp('Loop iteration:');
    %disp(index); 
    v(index) = index+index;
end

v

for i = 2:2:20
    disp(i);
end

for i = [ 10 7 1 3 7 9 ]
    disp(i)
end


%%

%While loops
%A combination of an if-statment with a loop

x = 0;
y = 10;
while x < y
    disp('Loop iteration');
    disp(x);
    x = x + 1;
    if x == 7
        y = 15;
    end
end

disp('Finished while loop')
disp('Final value of x:');
disp(x);










