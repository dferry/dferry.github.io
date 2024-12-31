%This variable holds the number of students in CSCI 1060-01
studentsInClass = 27;
StudentsInClass = 27;
students_in_class = 27;

StudentsInTotal = StudentsInClass;

%%
%in meters per second
gravity = -9.8; 
%in meters
height = 100;
time = 1;

%Using equation x = x' + 1/2*accel*time^2
resultHeight = height + (1/2)*gravity*time^2;

%These two are equivalent
height / gravity
gravity \ height

%%
%Logical operators
true && true %performs AND
true && false
true || true %performs OR
true || false 

%%
%Relational operators
clc;
10 < 5 %false
5 < 10 %true
5 >= 5 %true
5 > 5 %false
10 == 15 %false
15 == 15 %true
10 ~= 15 %true
15 ~= 15 %false

%% Relational Operator Example
clc;

x = 30
y = 20
limit = 35

x + y <= limit

%%
% Common Functions
% Call a function by name, put arguments in parenthesees
clc;

sq9 = sqrt( 9 )
sq25 = sqrt( 25 )
sq20 = sqrt( 20 )

%An example with two arguments
%nthroot takes an arbitrary root
cube64 = nthroot( 64, 3 )
cube100 = nthroot( 100, 3 )

%Absolute value
pos5 = abs( 5 )
neg5 = abs( -5 )

%Rounding
input = 2.7
regular = round( input )
ceiling = ceil( input )
myFloor = floor( input )

%%
% A bit of fun with number representation
%
% MATLAB cannot simultaneously work on very small
% and very large numbers
clc;

verySmall = 1e-16; %0.0000000000000001
verySmall + 1 %Result is 1, verySmall component is lost
              %because computer cannot represent decimal
              %numbers with perfect accuracy
          
(1 + verySmall - 1)/verySmall %Result is zero, but should
                              %be one. This is due to
                              %operator precedence plus
                              %the above effect
                              
%Reordered sequence of operations, gives one as expected
(1 - 1)/verySmall + verySmall/verySmall 