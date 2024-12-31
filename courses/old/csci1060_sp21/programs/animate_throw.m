% David and Class
% Feb 24, 2021
% Animating the throw of a ball

%Height equation for a ball going straight up and down
%H(t) = v0 * t - g * (t^2)/2
%Velocity equation for the same
%V(t) = v0 * g - t
%where g is the gravitation constant
%Distance over time
%D(t) = vx * t

g = 9.8; %m per second squared
v = 43.81; %m per second
angle = 60; %degrees above horizontal

vx = cosd(angle)*v;
vy = sind(angle)*v;

%Ending time given by solving H(t) = 0
endTime = 2*vy/g;

%The framerate is the number of animation frames per second
framerate = 30; %FPS of 24, 30 is common in TV, 60,120, or more
%The framerate fixes the delta-t of our simluation
dT = 1/framerate;

totalFrames = endTime / dT;
%Construct a time vector for every frame in the animation
time = 0:dT:endTime;

heights = vy .* time - g .* (time.^2)./2;
distances = vx .* time;

%elapsed time at 30fps is 16.743 sec
%extraTime = 16.743 - endTime;
%extraTimePerFrame = extraTime/totalFrames;
%estimated overhead per frame
overhead = 0.0291; %seconds per frame

%Now we want to animate the throw of this ball
tic
for i = 1:totalFrames
    plot( distances(i), heights(i), 'ko' );
    hold on;
    axis( [ 0 200 0 100 ] );
    pause( dT - overhead );
end
toc








