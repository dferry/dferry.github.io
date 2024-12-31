%David and Class
%Feb 26, 2021
% Simulating a ball in a room

%Height equation for a ball going straight up and down
%H(t) = v0 * t - g * (t^2)/2
%Velocity equation for the same
%V(t) = v0 * g - t
%where g is the gravitation constant
%Distance over time
%D(t) = vx * t

g = -9.8; %m per second squared
v = 43.81; %m per second
angle = 60; %degrees above horizontal

%Velocity
vx = cosd(angle)*v;
vy = sind(angle)*v;

%Position
px = 0;
py = 0;

%Bounding box
xMin = 0;
xMax = 150;
yMin = 0;
yMax = 100;

%Damping
damping = 0.8;

%The timestep of the simulation
dt = 0.1;


%Iterative simulation
while px >= xMin && px <= xMax && py >= yMin && py <= yMax
    
    plot( px, py, 'ko' );
    axis( [ xMin xMax yMin yMax ] );
    
    %compute the change in velocity over time
    vy = vy + g*dt;
    
    %compute the change in position over time
    px = px + vx*dt;
    py = py + vy*dt;
    
    if px > xMax
        px = xMax;
        vx = -vx*damping;
    end
    
    if py < yMin
        py = yMin;
        vy = -vy*damping;
    end
    
    if px < xMin
        px = xMin;
        vx = -vx*damping;
    end
    
    if py > yMax
        py = yMax;
        vy = -vy*damping;
    end
    
    pause( dt );
end



