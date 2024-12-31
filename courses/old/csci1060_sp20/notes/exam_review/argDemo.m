function [ x y z ] = argDemo( a, b, c )

if nargin < 2
   b = 1; 
end
if nargin < 3
    c = 10;
end

x = a ^ 2;

if nargout >= 2
   y = b + 20; 
end
if nargout == 3
    z = a + b;
end 

end