%Author: David & Class
%Simulates a pair of dice N times

hold off;
clear;
N = 10000;

%One Dice
oneDice = randi( 6, 1 ); %One way
oneDice = ceil( rand*6 ); %Another way

%TwoDice
twoDice = randi(6,1) + randi(6,1);
twoDice = ceil(rand()*6) + ceil(rand()*6);
twoDice = sum( randi(6,1,2) );

%Throw N dice
dice1 = randi(6, 1, N);
dice2 = randi(6, 1, N);
sumDice = dice1 + dice2; %There are other ways too

%Generate histogram graph
hist(sumDice, 2:12);

%Generate stems showing predicted value
hold on;
predicted = N.*[ 1:6 5:-1:1]./36;
stem( 2:12, predicted, 'g');

%Format the graph nicely
grid on;
title('Throwing a pair of dice 10000 times');
legend('Observed', 'Predicted');
axis( [ 0 14 0 N/4 ] );

