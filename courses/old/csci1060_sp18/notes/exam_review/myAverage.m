function [ result ] = myAverage( v )
%This function computes the average of v, and returns it

mySum = 0;
for i=1:length(v)
   mySum = mySum + v(i); 
end
elements = length(v);
result = mySum/elements;

end