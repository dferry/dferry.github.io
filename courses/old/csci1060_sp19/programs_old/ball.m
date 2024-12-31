%Simulating a ball thrown into the air
%David and class
clc; clear;

v = 43.81;
g = 9.8;
frames = 100;

endtime = 2*v/g;
timestep = endtime/frames;
t = 0:timestep:endtime;

%Calculate heights with the first equation of motion
heights = v.*t - g.*(t.^2)./2;

for h = heights
   %hold on;
   plot( 0, h, 'or' );
   axis( [ -1 1 0 max(heights)*1.1 ] );
   pause(timestep);
end

%%
% Version 2.0 - throw at an angle

clc; clear;

v = 43.81;
%v = 10;
g = 9.8;
angle = 60;
frames = 100;
filename = 'ball.gif'

vy = v*sind(angle);
vx = v*cosd(angle);

endtime = 2*vy/g;
timestep = endtime/frames;
t = 0:timestep:endtime;

%Calculate heights with the first equation of motion
heights = vy.*t - g.*(t.^2)./2;
distances = vx.*t;

for i = 1:length(heights)
   
   plot( distances(1:i), heights(1:i), '--r' ); 
   hold on;
   plot( distances(i), heights(i), 'or' );
   title('Ballistic Trajectory of a Ball');
   axis equal;
   axis( [ 0 max(distances)*1.1 0 max(heights)*1.1 ] );
   text( max(distances)*0.2, max(heights)*0.8, strcat('Time=',num2str(t(i))) )
   
       %Image code from MATLAB doc for imwrite
    %begin image write
    drawnow
    frame = getframe(1);
    im = frame2im(frame);
    [A, map] = rgb2ind(im,256);
    if i == 1;
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',timestep);
    else
    	imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',timestep);
    end
    %end image write
   
   pause(timestep);
   hold off;
end