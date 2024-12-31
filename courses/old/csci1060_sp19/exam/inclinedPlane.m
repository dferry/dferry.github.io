%This function computes the net forces acting on a block 
%sliding on an inclined plane, or states that the block 
%does not slide.
function force = inclinedPlane ( angle, mass, staticFrictionC, slidingFrictionC, animate )
	%Input: angle is the angle of incline
	%Input: mass is the mass of the block
	%Input: staticFrictionC is the coefficient of static
        %       friction between the block and the plane
	%Input: slidingFrictionC is the coefficient of sliding
	%       friction between the block and the plane
	%Input: if animate == 1, animate the block
	%Output: if the block slides, then this value is the
	%	     net force on the block parallel to the plane,
	%	     if the block does not slide, this is zero

	%DEFAULT VALUES:
	% staticFrictionC = 0.61
	% slidingFrictionC = 0.47
	% animate = 1
    
    
end

%This function draws a box on an inclined plane
%Input: position is the position of the box along the axis of the plane,
%       the given value must be between 0 and 2.
%Input: angle is the angle of the inclined plane
function plotBox( position, angle )

%Draw a two meter plane
hold off;
plot( [0 2*cosd(angle)], [0 2*sind(angle)], 'k-' );
hold on;

%Define the four corners of the box in an un-rotated frame of reference
bottomLeft  = [ position-0.1 0   ];
bottomRight = [ position+0.1 0   ];
topLeft     = [ position-0.1 0.2 ];
topRight    = [ position+0.1 0.2 ];

rotBL = rotatePoint( bottomLeft,  angle );
rotBR = rotatePoint( bottomRight, angle );
rotTL = rotatePoint( topLeft,     angle );
rotTR = rotatePoint( topRight,    angle );

plot( [ rotBL(1) rotBR(1) rotTR(1) rotTL(1) rotBL(1) ], ...
      [ rotBL(2) rotBR(2) rotTR(2) rotTL(2) rotBL(2) ], 'r-' );
  
  axis equal;
  axis( [ 0 2 0 2 ] );

end

%This is a helper function that rotates a point to a given angle
%relative to the x-axis.
function rotPoint = rotatePoint( point, angle )

rotPoint(1) = cosd(angle)*point(1) - sind(angle)*point(2);
rotPoint(2) = sind(angle)*point(1) + cosd(angle)*point(2);

end
