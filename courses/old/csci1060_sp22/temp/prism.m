%Functions
%Feb 25, 2019
%David and class
%This function computes the volume and surface area for a
% a rectangular prism.
% INPUT length = the length of the prism
% INPUT width  = the width of the prism, defaults to 1
% INPUT height = the height of the prism, defaults to 1
% OUTPUT volume = the volume of the prism
% OUTPUT surfaceArea = the surface area of the prism

function [ volume, surfaceArea ] = prism( length, width, height)

%Use nargin to control behavior of function
if nargin == 1
    width = 1;
    height = 1;
elseif nargin == 2
    height = 1;
end

%disp('Called prism function')

volume = length * width * height;

if nargout >= 2
    disp('Computing second output parameter')
    surfaceArea = 2*length*width + 2*length*height + 2*width*height;
end

end