% A framework for doing a discrete simulation of a moving ball

g = 9.8;                       % gravity
iv = 43.81;                    % initial velocity (98 mph = 43.81 m/s)
angle = 60;
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

while px >= minX && px <= maxX && py >= minY && py <= maxY
    plot(px, py, 'o');
    axis equal;
    axis(window);
    grid on;
    
    px = px + vx * dt;    % velocity affects position
    py = py + vy * dt;
    vy = vy - g * dt;     % acceleration affects velocity
    
    pause(dt);
end
