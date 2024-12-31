% David and class
% Feb 12, 2021
% Simulating rolling pairs of dice

%Simulate rolling a pair of dice, and sum the answer
%roll one die
die1 = randi(6,1,1)

%What if we only have rand()?
die2 = rand() %value between 0 and 1
die2 = ceil(die2*6)

%The sum of both random dice is
sum = die1 + die2

%%

%rather than rolling one pair, let's do that process
%a lot of times

N = 1000000
die1 = randi(6, N, 1);
die2 = randi(6, N, 1);
sums = die1 + die2;

%How many 7's do we have in this sums array?
sums == 7; %gives an array with 0's and 1's
twos = sum( sums == 2 )
threes = sum( sums == 3 )
fours = sum( sums == 4 )
fives = sum( sums == 5 )
sixes = sum( sums == 6 )
sevens = sum( sums == 7 )
eights = sum( sums == 8 )
nines = sum( sums == 9 )
tens = sum( sums == 10 )
elevens = sum( sums == 11 )
twelves = sum( sums == 12 )

results = [ twos threes fours fives sixes sevens ...
    eights nines tens elevens twelves ]

%sum(results) 

analytic = [ 1:6 5:-1:1 ];
analytic = analytic ./ 36;
predicted = N .* analytic

xValues = 2:12

bar( xValues, results );
hold on;
stem( xValues, predicted, "r");
hold off;
axis( [1 13 0 N/4] );
title('Observed vs. analytic probabilities for rolling dice');



