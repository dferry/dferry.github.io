%Dice simulation
%David and class
%Feb. 1, 2019

clear;
clc;

%Number of trials
N = 1000000;

%Hard, general way of rolling a dice
dice1 = rand(N,1);
dice1 = dice1.*6;
dice1 = ceil( dice1 );
%We could just say dice1 = ceil( rand() * 6 )

%Easy way of rolling a dice
dice2 = randi(6,N,1);

outcomes = dice1 + dice2;

%Generate output graph
hist( outcomes, 2:12 );

axis( [ 0 14 0 N/4 ] )

%Plot stems
hold on;

x = 2:12;
numer = [ 1:5 6:-1:1 ];
probabilities = numer./36;
expected = probabilities .* N;
stem( x, expected, 'r' );

%Set up asthetics
grid on

hold off;






