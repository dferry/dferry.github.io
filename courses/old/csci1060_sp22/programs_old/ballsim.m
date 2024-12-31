% A framework for doing a discrete simulation of a moving ball
clear; clc;

g = 9.8;                       % gravity
iv = 43.81;                    % initial velocity (98 mph = 43.81 m/s)
angle = 60;
yDamping = 0.5;
xDamping = 0.5;
minV = 0.01;


ivx = iv * cosd(angle);        % initial velocity's x-component
ivy = iv * sind(angle);        % initial velocity's y-component

minX = 0; maxX = 150;          % setup bounds for a workspace window
minY = 0; maxY = 100;          % setup bounds for a workspace window
window = [minX maxX minY maxY];

px = minX;                     % current position's x-component
py = minY;                     % current position's y-component
vx = ivx;                      % current velocity's x-component
vy = ivy;                      % current velocity's y-component
dt = 0.1;                      % simulate 1/10 second per iteration

% ------------ begin the simulation -------------
%hold on;

while px >= minX && px <= maxX && py >= minY && py <= maxY
    plot(px, py, 'o');
    axis equal;
    axis(window);
    grid on;
    
    px = px + vx * dt;    % velocity affects position
    py = py + vy * dt;
    vy = vy - g * dt;     % acceleration affects velocity
    
    if px > maxX
        px = maxX;
        vx = -vx;
    end
    
    if px < minX
        px = minX;
        vx = -vx;
    end
    
    if py < minY
        py = minY;
        vx = vx*xDamping; %damp x velocity
        vy = vy*yDamping; %damp y velocity
        vy = -vy; %reverse velocity
    end
    
    if vx < minV && vy < minV && py < 0.5
       break; 
    end
    
    pause(dt/2);
end

disp('Simulation end');