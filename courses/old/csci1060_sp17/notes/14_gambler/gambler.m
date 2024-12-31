function [success, avgBets] =  gambler(goal, initial, p, trials)
% Performs independent trials for a gambling simulation.
% USAGE: [success round] = gambler(goal, initial, p)
%   A gambler begins with a bankroll designated as initial
%   and repeatedly bets $1 with a winning percentage of p
%   continuing until either meeting the goal or going broke.
%
%   If not otherwise specified,
%       initial = goal/2
%       p = 0.5
%       trials = 1000

if nargin == 3
    trials = 1000;
elseif nargin == 2
    p = 0.5;
    trials = 100;
elseif nargin == 1
    initial = goal / 2;
    p = 0.5;
    trials = 1000;
end


wins = 0;
totalSteps = 0;

for i = 1:trials
    [a b] = gamblerHelper( goal, initial, p );
    if a == 1
        wins = wins + 1;
    end
    totalSteps = totalSteps + b;
end

success = wins / trials;
avgBets = totalSteps / trials;

end
   
   
   
function [ success bets ] = gamblerHelper(goal, initial, p)
   %Called by the gambler function, executes a single
   %trial

   money = initial;
   bets = 0;
   
   while money > 0 && money < goal
       bets = bets + 1;
       x = rand();
       if x > 1 - p %we win
           money = money + 1;
       else %we lose
           money = money - 1;
       end
   end
   
   if money == 0 %We went bust
       success = 0;
   else %We met the goal
       success = 1;
   end
end



