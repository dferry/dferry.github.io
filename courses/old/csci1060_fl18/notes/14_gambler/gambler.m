function [success, bets] = gambler(goal, initial, p, trials)
    %Performs a specified number of independent trials for a gambling
    %simulation.
    
    % USAGE: [success round] = gambler(goal, initial, p, trials)
   %   A gambler begins with a bankroll designated as initial
   %   and repeatedly bets $1 with a winning percentage of p
   %   continuing until either meeting the goal or going broke.
   %
   %   If not otherwise specified,
   %       initial = goal/2
   %       p = 0.5
   %       trials = 1000
    
   %Argument validation
   if nargin < 1
       disp('The Gambler function needs at least one argument');
       return;
   elseif nargin == 1
       initial = goal/2;
       p = 0.5;
       trials = 1000;
   elseif nargin == 2
       p = 0.5;
       trials = 1000;
   elseif nargin == 3
       trials = 1000;
   end
   
   wins = 0;
   losses = 0;
   total_bets = 0;
   
   for i = 1:trials
     [ result, this_bet ] = gambler_helper( goal, initial, p );
     if result == 1
         wins = wins + 1;
     else
         losses = losses + 1;
     end
     total_bets = this_bet + total_bets;
   end
   
   bets = total_bets / trials;
   success = wins/trials;
end


function [success, bets] = gambler_helper(goal, initial, p)
   % Performs independent trials for a gambling simulation.
   % USAGE: [success round] = gambler(goal, initial, p)
   %   A gambler begins with a bankroll designated as initial
   %   and repeatedly bets $1 with a winning percentage of p
   %   continuing until either meeting the goal or going broke.
  
       
   %Set initial bankroll
   bankroll = initial; 
   bets = 0;
   
   %history = [];
   
   %Keep executing until we make our goal or go bust
   while bankroll > 0 && bankroll < goal
       
       bets = bets + 1;
       %history(bets) = bankroll; 
       result = rand();
       if result < p
           %We win
           bankroll = bankroll + 1;
       else
           %We lose
           bankroll = bankroll - 1;
       end
   end
   
   if bankroll == goal
       success = 1;
   else
       success = 0;
   end
   
   %plot(history);
end
