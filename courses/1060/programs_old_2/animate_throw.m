%David and class
%2/3/2020
% Simulating/animating the motion of a ball

frames = 60;
gravity = 9.8; % meters per second squared
v0 = 43.81; % meters per second

endTime = (2*v0)/gravity;

time = linspace(0, endTime, frames);
height = v0.*time - (gravity.*(time.*time))./2

deltaT = time(2) - time(1);

%Sanity check
%plot(height);

%Animate
for h = height
   plot(0,h,'bo');
   axis( [-1 1 0 100 ] );
   pause( deltaT );
end


%%

%Ball simulation with horizontal movement

v0 = 43.81; % meters per second
angle = 60; % degrees

vx = cosd(angle)*v0;
vy = sind(angle)*v0;

frames = 60;
gravity = 9.8; % meters per second squared

endTime = (2*vy)/gravity;

time = linspace(0, endTime, frames);
height = vy.*time - (gravity.*(time.*time))./2
distance = vx.*time;

deltaT = time(2) - time(1);

horzDistance = max(distance)

%Animate
for i = 1:length(time)
   plot(distance(i),height(i),'bo');
   axis( [0 250 0 100 ] );
   pause( deltaT );
end





