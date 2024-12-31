%David and class
% Feb 10th, 2021
% Notes on plotting

%We need data to plot before we can plot
X = 0:0.01:2*pi;
Y = sin( X );

plot( X, Y )
title( 'Plot of Sine Function', 'FontSize', 18 );
xlabel( 'Independent Variable' );
ylabel( 'Dependent Variable', 'FontSize', 14 );

%%

t = 0:pi/10:2*pi;
[X,Y,Z] = cylinder(4*1./t);
subplot(2,2,1); mesh(X)
subplot(2,2,2); mesh(Y)
subplot(2,2,3); mesh(Z)
subplot(2,2,4); mesh(X,Y,Z)


%%

%We don't need a second parameter for a plot
Y = [ 1 2 4 8 16 32 64 128 10 7 5 0]
plot(Y)



%%

x = 0:0.5:5
y = x.^2
plot(x,y)
%axis( [ xmin xmax ymin ymax ] )
axis( [-5 5 -50 50 ] )
grid on
grid minor

%%

%Big note: MATLAB will plot anything x-y that you want
y = -5:0.1:5
x = y.^2

plot(x,y)

%%

%parmetric plots

t = 0:0.001:8*pi
x = sin(t).*(t.^2)
y = cos(t).*t
plot(x,y)

%%

%Plotting multiple lines on a plot

x = 0:0.1:5
y1 = sqrt(x)
y2 = x
y3 = x.^2

plot(x,y1,x,y2,x,y3)

%%

x = 0:0.1:5
y1 = sqrt(x)
y2 = x
y3 = x.^2

X = [x' x' x']
Y = [y1' y2' y3']

plot( X, Y )

%%

%This is the most "programmatic" way to do multiple lines

x = 0:0.1:5
y1 = sqrt(x)
y2 = x
y3 = x.^2

plot(x,y1)
hold on;
plot(x,y2)
plot(x,y3)
hold off;


%%

%Controlling the axes

x = 0:0.1:5
y = x.^2
plot(x,y)
axis equal;

%%

%Explicit axes
x = 0:0.1:5
y = x.^2
plot(x,y)
% axis( [ xmin xmax ymin ymax ] )
axis( [ 0 7 -25 25 ] )

%%

x = 0:0.1:5
y1 = sqrt(x)
y2 = x
y3 = x.^2

plot(x,y1)
hold on;
plot(x,y2)
plot(x,y3)
hold off;

legend( 'sqrt', 'linear', 'squared' )

%%

%Line styles

x = 0:0.25:5
y = x.^2
y2 = sqrt(x);
%Optional third parameter controls line style
%See "help plot" for more options
plot(x, y, 'md--')
hold on;
plot( x, y2, 'kx:' )
hold off;

legend( 'squared', 'square root' );

%%

%Subplots and plotting more than one graph at a time

x = 0:0.25:5
y = x.^2
y2 = sqrt(x);

%Subplots always have two parameters: row and column
subplot( 2, 1, 1 ) %two rows, one column, position 1
plot(x, y, 'md--')
subplot( 2, 1, 2 ) %two rows, one column, position 2
plot( x, y2, 'kx:' )

%%

%A lot of subplot variations are possible

x = 0:0.25:5
y = x.^2
y2 = sqrt(x);

%Subplots always have two parameters: row and column
subplot( 1, 2, 1 ) %one row, two columns, position 1
plot(x, y, 'md--')
subplot( 1, 2, 2 ) %one row, two columns, position 2
plot( x, y2, 'kx:' )

%%

%We don't have to fill in every position

x = 0:0.25:5
y = x.^2
y2 = sqrt(x);

%Subplots always have two parameters: row and column
subplot( 2, 2, 1 ) %two rows, two column, position 1
plot(x, y, 'md--')
subplot( 2, 2, 4 ) %two rows, two column, position 4
plot( x, y2, 'kx:' )

%%

%We can also combine different row/column specificiations
% for different effects

x = 0:0.25:5
y = x.^2
y2 = sqrt(x);
y3 = x;

%Subplots always have two parameters: row and column
subplot( 2, 2, 1 ) %two rows, two column, position 1
plot(x, y, 'md--')
subplot( 2, 2, 4 ) %two rows, two column, position 2
plot( x, y2, 'kx:' )
subplot( 2, 1, 2 ) %two rows, one column, position 2
plot( x, y3, 'co-' )






