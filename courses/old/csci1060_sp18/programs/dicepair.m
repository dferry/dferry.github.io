% Simulate rolling a pair of dice
% David and class

trials = 10000;

%Generate two dice vectors
dice1 = randi(6,1, trials);
dice2 = rand(1,trials);
dice2 = dice2*6;
dice2 = ceil(dice2);

sums = dice1 + dice2;

%Let matlab plot our data with histogram
hist( sums, 2:12 )

%Plot analytic probability stems
hold on
x = 2:12;
numer = [ 1:6 5:-1:1 ];
probability = numer/36;
predicted = trials * probability;
stem( x, predicted, 'r' )

% Set up graph title/legend
grid on;
title('Throwing a pair of dice many times');
axis( [ 0 14 0 trials/4 ] );

hold off;