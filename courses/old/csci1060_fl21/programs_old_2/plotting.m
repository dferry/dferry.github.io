x = 0:pi/100:2*pi;
y = sin(x);
plot(x,y);
% Now label the axes and add a title. The characters \pi create the
% symbol π. See "text strings" in the MATLAB Reference documentation for
% more symbols:
xlabel('x = 0:2\pi');
ylabel('Sine of x');
title('Plot of the Sine Function','FontSize',12)


%%

t = 0:pi/10:2*pi;
[X,Y,Z] = cylinder(4);
subplot(2,2,1); mesh(X)
subplot(2,2,2); mesh(Y)
subplot(2,2,3); mesh(Z)
subplot(2,2,4); mesh(X,Y,Z)

%%

%Basic plotting function: plot

y = [ 7 5 3 8 6 8 10 ]
plot( y ) 

%%

x = [ 0 1 2 5 6 7 8 ]
y = [ 7 5 3 5 6 8 10 ]
plot( x, y ) 

%%
x = [ 0 1 2 5 0 1 2 ]
y = [ 7 5 3 5 6 8 10 ]
plot( x, y ) 

%%

x = linspace( -5, 5, 100 ); % for smoother curve
y = x.^2;
plot( x, y )

%%

y = -5:5
x = y.^2
plot( x, y )


%%

%Parametric plotting

t = linspace(0,3*2*pi, 1000);

x = t.*cos(t);
y = t.*sin(t);

plot( x, y )

%Control plot extents
axis( [ -30 30 -30 30 ] )

%Add labels to the x and y axis
xlabel('t from 0 to 6*\pi')
ylabel('x = t*cos(t)')

title('Paramteric spiral')

grid on;

%%

%Plotting multiple lines

x = linspace( 0, 5, 100 );
y1 = sqrt(x);
y2 = x;
y3 = x.^2

plot( x, y1, x, y2, x, y3 )
%Xmin, Xmax, Ymin, Ymax
axis( [ 0, 5, 0, 10 ] )

%add a legend, labels apply to lines in the
%order they are added
legend( 'y=sqrt(x)', 'y=x', 'y=x^2' )

%%
%More general approach to multiple plots

x = linspace( 0, 5, 100 );
y1 = sqrt(x);
y2 = x;
y3 = x.^2

bar( x, y1 );
hold on;
plot( x, y2 );
plot( x, y3 );

hold off;


%%
%Subplots - multiple plots adjacent

x = linspace( 0, 5, 100 );
y1 = sqrt(x);
y2 = x;
y3 = x.^2

subplot( 2, 2, 1 )
plot( x, y1 )

subplot( 2, 2, 4 )
plot( x, y2 )


