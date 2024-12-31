function [successes avgBets] = gambler(goal, initial, p, trials)
   % Performs independent trials for a gambling simulation.
   % USAGE: [success round] = gambler(goal, initial, p, trials)
   %   A gambler begins with a bankroll designated as initial
   %   and repeatedly bets $1 with a winning percentage of p
   %   continuing until either meeting the goal or going broke.%
   %
   %   success will be the fraction of times in which goal was reached
   %   bets will be the average number of bets placed before the outcome
   %
   %   If not otherwise specified,
   %       initial = goal/2
   %       p = 0.5
   %       trials = 1

successes = 0;
totalBets = 0;

for i = 1:trials
    
    money = initial;
    bets = 0;
    
    while money > 0 && money < goal
        
        bets = bets + 1;
        result = game(p);
        
        if result == 1 %we win
            money = money + 1;
        else
            money = money - 1;
        end
        
    end
    
    if money >= goal
        successes = successes + 1;
    end
    
    totalBets = totalBets + bets;
    
end

successes = successes/trials;
avgBets = totalBets/trials;

end


function result = game( p )
%This is one play of the gambler's game,
% p is the probability of winning
% result is 0 if we lose, or 1 if we win

draw = rand();
if p >= draw
    result = 1;
else
    result = 0;
end

end
