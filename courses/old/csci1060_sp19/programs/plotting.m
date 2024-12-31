%Plotting with MATLAB
%David and Class
%Jan 28, 2019

x = 0:pi/100:2*pi;
y = x.^2;
plot(x,y);
% Now label the axes and add a title. The characters \pi create the
% symbol ?. See "text strings" in the MATLAB Reference documentation for
% more symbols:
xlabel('x = 0:2\pi');
ylabel('X^2');
title('Plot of the X^2','FontSize',12);

%%
t = 0:pi/10:2*pi;
[X,Y,Z] = cylinder(4*cos(t));
subplot(2,2,1); mesh(X)
subplot(2,2,2); mesh(Y)
subplot(2,2,3); mesh(Z)
subplot(2,2,4); mesh(X,Y,Z)

%%

%Plotting from first principles
%y = x^2
x = -5:5
y = x.^2
plot( x, y )

%%
y = -5:5
x = y.^2
plot( x, y )

%%
%Parametric plot

t = 0:0.1:8*pi
x = cos(t).*t
y = sin(t).*t

plot( x, y )

%%
%Looking at axis commands

%y = x^2
x = linspace(-5,5,1000)
y = x.^2
plot( x, y )

%axis equal
%axis argument: [ xmin xmax ymin ymax ]
axis( [ -10 10 -25 50] )
%axis off
grid on
grid minor

%Labelling the graph
title('Parabola y=x^2, not \pi')
xlabel('This is the independent variable')
ylabel('This is x^2')

%%
%Plotting multiple data sets

x = linspace(0,2,1000);
y = [ sqrt(x); ...
      x; ...
      x.^2 ]

plot( x, y )

legend('y=sqrt(x)', 'y=x', 'y=x^2', ...
    'Location', 'northwest')

%%
%The hold command

x = linspace(0,2,1000);
%y = [ sqrt(x); ...
%      x; ...
%      x.^2 ]
y1 = sqrt(x);
y2 = x;
y3 = x.^2;

t = linspace(0, 8*pi, 1000);
x4 = t.*cos(t);
y4 = t.*sin(t);

plot( x, y1 );
hold on;
plot( x, y2 );
plot( x, y3, '-.g' );
plot( x4, y4, 'r--');
hold off;
axis( [-2 2 -2 2] )

%%
%Multiple plots on one canvas - subplot

x = linspace( 0, 4*pi, 1000 );
y1 = cos(x);
y2 = sin(x);

%plot(x, y1)
%hold on;
%plot(x, y2);
%hold off;

hold on;
subplot(2, 1, 1);
plot( x, y1);
title('Cos(x)')

subplot(3, 3, 8);
plot( x, y2);
title('Sin(x)');

hold off;



