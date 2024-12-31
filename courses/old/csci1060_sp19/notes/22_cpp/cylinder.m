function area = cylinder(height, radius)
% function to compute the surface area of a cylinder
% Usage:  area = cylinder(height, radius)
% If not specified, radius is assumed to be 1
  if (nargin == 1)
    radius = 1;                 % default value for second parameter
  end
  base = pi .* radius.^2;
  area = 2 .* pi .* radius .* height + 2 .* base;    % the first result
