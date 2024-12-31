function [success bets] = gambler(goal, initial, p, trials)
% Performs independent trials for a gambling simulation.
% USAGE: [success round] = gambler(goal, initial, p)
%   A gambler begins with a bankroll designated as initial
%   and repeatedly bets $1 with a winning percentage of p
%   continuing until either meeting the goal or going broke.
%
%   If not otherwise specified,
%       initial = goal/2
%       p = 0.5

totalBets = 0;
success = 0;

for n = 1:trials
    money = initial;
    bets = 0;
    moneyOverTime = zeros(10000,1);
    moneyOverTime(1) = initial;

    while money > 0 && money < goal
        %    while money != 0 && money != goal
        
        roll = rand();
        if roll < p %we win
            money = money + 1;
        else %we lose
            money = money - 1;
        end
        bets = bets + 1;
        moneyOverTime( bets + 1 ) = money;
    end
    
    if trials == 1 
        plot( moneyOverTime );
        axis( [ 0 bets 0 goal ] );
    end
    %After a gambler wins or loses
    if money == goal %We lost overall
        success = success + 1;
    end
    
    totalBets = totalBets + bets;
    
end

bets = totalBets / trials;
success = (success / trials)*100;

end


