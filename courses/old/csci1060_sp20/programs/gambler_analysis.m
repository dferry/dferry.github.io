%Gambler analysis
%David and Class
%Feb 28, 2020


trials = 10000;
initial = 0:10;
goal = 10;
p = .45;

results = []

for j=initial

    wins = 0;
    
for i=1:trials
    result = gambler( goal, j, p );

    if result == 1 %that gambler won
        wins = wins + 1;
    end 
end

chanceOfWinning = wins/trials*100;

results = [ results chanceOfWinning ];

end


plot( initial, results )
title([ 'Chance of winning with goal=10, p=' num2str(p) ] )

%%

initial = 50;
goal = 100;
p = linspace(.48,.52,30);

results = []

for i = p
   
    successes = gambler( goal, initial, i, 1000 );
    results = [ results successes ]
end

plot( p, results )
title([ 'Chance of winning with varying p' ] )

