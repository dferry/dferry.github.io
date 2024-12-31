%The gambler simulation
%David and class
%March 15th, 2021

% A gambler walks into a casino, and makes repeated
% one dollar bets until they go broke or meet their goal.
function [ success bets ] = gambler( goal, initial, p, graph )
% INPUT goal - the amount of money the gambler wants to walk
%              away with
% INPUT initial - the amount of money the gambler starts with
% INPUT p - the probability of the gambler winning each
%           individual bet
% INPUT graph - if true we plot our money over time
% OUTPUT success - true if the gambler met their goal, false otherwise
% OUTPUT bets - the number of bets it took to go broke or meet goal

if nargin < 4
   graph = false; 
end

money = initial;
bets = 0;
moneyOverTime = [ initial ];
wins = 0;

while money > 0 && money < goal

    bets = bets + 1;
    draw = rand(); %A value between 0 and 1
    
    
    if draw <= p %win
        money = money + 1;
        wins = wins + 1;
    else %lose
        money = money - 1;
    end
    moneyOverTime = [ moneyOverTime money ];
end

if graph == true
    fprintf('The win percentage was %0.2f\n', wins/bets*100);
   plot(moneyOverTime); 
end

if money == goal
    success = true;
else
    success = false;
end

end
