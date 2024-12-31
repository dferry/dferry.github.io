%Gambler investigation
%David and Class
%March 1st, 2019


successes = zeros(101, 1);
bets = zeros(101, 1);
for bankroll = 0:100
    [thisSuccess thisBets ] = gambler( 100, bankroll, 0.48, 1000 );
    successes(bankroll+1) = thisSuccess;
    bets(bankroll+1) = thisBets;
end

subplot( 2, 1, 1 );
plot( 0:100, successes );
subplot( 2, 1, 2 );
plot( 0:100, bets );

%%

size = 100;
range = linspace( .47, .53, size );

successes = zeros(size, 1);
bets = zeros(size, 1);
for i = 1:size
    [thisSuccess thisBets ] = gambler( 100, 75, range(i), 1000 );
    successes(i) = thisSuccess;
    bets(i) = thisBets;
end

subplot( 2, 1, 1 );
plot( 1:size, successes );
subplot( 2, 1, 2 );
plot( 1:size, bets );
