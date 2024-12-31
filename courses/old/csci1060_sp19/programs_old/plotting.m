% Plotting and finishing vectors
% Jan 29, 2018

%First, a few vector operations
clc;
clear;

%%
E1 = 100:100:1500
%%
part1 = 1:20;
part2 = 19:-1:1;
E2 = [ part1 part2 ]

%Also:
E2 = [  1:20 19:-1:1 ]

%% Answer 1 for E3
N = 4;

base = ones(1,N);
base = base .* -1
exponents = (2:N+1)
E3 = base .^ exponents

%%
N = 10

base = ones(1,N);
base( 2:2:N ) = -1;
E3ver2 = base

%%
N = 10
exponents = 0:N-1
E4 = 2.^exponents

%as a one liner
E4 = 2.^(0:N-1)

%%
N = 10
E4 = 2.^(0:N-1)
E5 = 1./E4

%%
% Plotting!
clc;
clear;

%From the plotting notes:
x = 0:pi/100:2*pi;
y = sin(x);
plot(x,y);
% Now label the axes and add a title. The characters \pi create the
% symbol ?. See "text strings" in the MATLAB Reference documentation for
% more symbols:
xlabel('x = 0:2\pi');
ylabel('Sine of x');
title('Plot of the Sine Function','FontSize',12);


%%
%Example plot 2 from notes

t = 0:pi/10:2*pi;
[X,Y,Z] = cylinder(4);
subplot(2,2,1); mesh(X)
subplot(2,2,2); mesh(Y)
subplot(2,2,3); mesh(Z)
subplot(2,2,4); mesh(X,Y,Z)

%%
% Basic plotting

data = (-5:5).^2
plot( (-5:5).^2 ); %Plots y = x^2

%%
x = linspace(-5, 5, 100)
y = x.^2
plot( x, y, '-m', 'LineWidth', 2 )
title('Plot of f(x) = x^2')
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')

%%
%Plots don't need to be proper functions
plot( y, x )

%%
%Parametric plotting
t = linspace(0, 8*pi, 500)
x = t.*cos(t)
y = t.*sin(t)
plot(x, y)

%%
% Multiple plots with one plot()

x = linspace(0, 2, 100);
y1 = x.^0.5;
y2 = x;
y3 = x.^2;

plot(x, y1, x, y2, x, y3)

legend('x^0.5','x', 'x^2', 'Location', 'NorthWest');

%% Multiple plotting again

x = linspace(0, 2, 100);
y1 = x.^0.5;
y2 = x;
y3 = x.^2;

plot( [x; x; x]', [y1; y2; y3]' )

legend('x^0.5','x', 'x^2', 'Location', 'NorthWest');

%%
% Plotting with multiple plots

x = linspace(0, 2, 100);
y1 = x.^0.5;
y2 = x;
y3 = x.^2;

plot(x, y1, ':g', 'LineWidth', 1);
hold on;
plot(x, y2, '--r', 'LineWidth', 2);
plot(x, y3, '.-b', 'LineWidth', 3);
hold off;

%%
      dice = ceil( rand(2,8) * 6);
      image(dice);
      colormap(lines);    % better choice of colors
      axis equal;         % make squares
      axis off;           % don't bother labeling the axis