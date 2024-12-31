function [ result ] = approxPi( N )
%This function approximates pi by throwing darts
%at the unit square.
% N = number of darts

count = 0;

for i = 1:N
   %1) Pick a point (throw a dart) in unit square
   [ x y ] = pickPoint(); 
   %2) Determine if that point is in unit circle
   inCircle = inUnitCircle( x, y ); 
   %3) Update count
    if inCircle
        count = count + 1;
    end
end
result = 4*(count/N);
end


function [ x y ] = pickPoint()
%This function picks an x-y point inside the unit square
x = rand()*2 - 1;
y = rand()*2 - 1;
end

function [ result ] = inUnitCircle( x, y )
%This function determines if the point x,y is in the
%unit circle centered at (0,0)
distOrigin = sqrt( x*x + y*y );
if distOrigin <= 1
    result = true;
else
    result = false;
end
end