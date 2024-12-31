%David and class
%2/5/2020
%Implicitly simluating a ball in a room

v0 = 45; %meters per second
angle = 60; %degrees

vx = v0 * cosd( angle );
vy = v0 * sind( angle );

px = 0;
py = 0;

ay = -9.8; %meters per second squared

deltaT = 0.1;

minX = 0;
maxX = 100;
minY = 0;
maxY = 100;

while (px >= minX) && (px <= maxX) && (py >= minY) && (py <= maxY) 

    plot( px, py, 'bo' );
    axis equal;
    axis( [ minX maxX minY maxY ] );
    grid on;

    %Position update
    px = px + vx*deltaT;
    py = py + vy*deltaT;
    
    %Velocity update
    vx = vx;
    if px > maxX
       vx = -vx;
       px = maxX
    end
    vy = vy + ay*deltaT;
    
    pause( deltaT );
    
end








