% David and class
% 1/29/2020
% Rolling pairs of dice simulation

N = 10000000;

d1 = rand(1,N); %Between 0 and 1
d1 = d1 .* 6; %Between 0 and 6
d1 = ceil( d1 ); %Whole numbers between 1 and 6

d2 = randi(6,1,N);

pair = d1 + d2;

%numberOfTwos = sum(pair == 2)

hist( pair, 2:12 )
hold on;
axis( [ 0 14 0 N*0.25 ] )
title( 'Observed pair of dice rolls')
xlabel( 'Value of dice pair' )
ylabel( 'Count of occurences' )

%Generate histogram stems
% to show analytic probability
x = 2:12;
probs = [ 1:6 5:-1:1 ] ./ 36;
y = N.*probs;

stem( x, y, 'r' );

hold off;


