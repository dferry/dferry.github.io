%Animate a ball thrown in the air
%David and class
%Feb 6, 2019

tic

g = 9.8;
v0 = 43.81;

endtime = 2*v0/g;
overhead = 0.7; %over head in seconds
overhead_per_frame = overhead / (20*9);
timestep = 1/20; %Number of seconds between
                 %animation frames
                 
t = 0:timestep:endtime;
% height = v0 * t - (g * t^2)/2
% velocity = v0 - g*t

%Evaluate heights
heights = v0 .* t - (g .* (t.^2))./2

%%
%Animate the height over time

maxheight = max(heights);

for h = heights
   
    plot( [ 0 ], h, 'bo' );
    axis( [ -1 1 0 maxheight+10] );
    pause( timestep - overhead_per_frame );
    
end

toc
