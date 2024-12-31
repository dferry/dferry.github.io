%Structures
%David and Class
% 4/4/2020

%Struct - a collection of data, a struct has fields of data

person = struct()
person.name = 'Alice Anyone'
person.age = 22;
person.zip = 63103;
person.work = 'Simon Rec Center'

a = person

%Access and modify
person.name

person.name = 'Bob Banyone'

%Note all the values of person were copied to a when a was made
a

%%

%In traditional MATLAB we can create an array element by assigning values
array = 5;
array(2) = 10

%%
%Creating an array of structs

%person(2) = struct(); %Error, does not work

%MATLAB wants to make sure that arrays always have the same data type as
%every element in the array

person(2).name = 'Claire'
person(3).name = 'David'
person(4).name = 'Erica'

person(2).age %empty vector

person(2).age = 25;
person(3).age = 30;
person(4).age = 35;

%What's the sum of all their ages:

totalAge = 0;
for i = 1:length(person)
    totalAge = totalAge + person(i).age;
end

totalAge


