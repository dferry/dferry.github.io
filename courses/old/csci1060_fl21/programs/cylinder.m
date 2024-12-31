%This function computes the surface area of a cylinder

function [ surfaceArea, volume ] = cylinder( height, radius )

%nargin - tells us how many variables someone passed into function
%if nargin < 2
%   disp('Error, function requires a height and radius');
%   return;
%end

if nargin == 0
   height = 1;
   radius = 1;
elseif nargin == 1
   radius = 1;
end

areaOfCap = pi * radius * radius; %area of the top and bottom
perimeterOfCap = 2*pi*radius;
areaOfWall = perimeterOfCap * height;

surfaceArea = 2*areaOfCap + areaOfWall;

if nargout == 2
   volume = areaOfCap * height;
else 
   disp('Volume not computed') 
end

end
