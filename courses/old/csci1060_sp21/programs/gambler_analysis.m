%The gambler analysis
%David and Class
%March 15th, 2021

TRIALS = 5000;
goal = 60;
initial = 50;
p = .49;

totalBets = 0;
wins = 0;

for i = 1:TRIALS
   [success bets] = gambler( goal, initial, p );
   if success == true
       wins = wins + 1;
   end
   totalBets = totalBets + bets;
end

winPct = wins / TRIALS * 100;
avgBets = totalBets / TRIALS;

fprintf('\nThe gambler had a %0.2f probability of winning.\n', winPct );
fprintf('The average number of bets was %0.2f.\n', avgBets );

%%

%Bankroll analysis over different starting money values

clear;clc;

TRIALS = 5000;
goal = 100;
p = .49;

bankrollValues = 0:5:100;
winResults = [];
betResults = [];

for j = bankrollValues
   
   wins = 0;
   totalBets = 0;
    
   for i = 1:TRIALS
   [success bets] = gambler( goal, j, p );
   if success == true
       wins = wins + 1;
   end
   totalBets = totalBets + bets;
   end
    
   winPct = wins / TRIALS;
   avgBets = totalBets / TRIALS;
   
   winResults = [ winResults winPct ];
   betResults = [ betResults avgBets ];
   
end

subplot(3, 1, 1);

hold off;
plot( bankrollValues, winResults );
grid on;
hold on;
xlabel('Initial Bankroll');
ylabel('Chance of winning');
titleString = sprintf('Bankroll analysis for goal=%d and p=%0.3f', goal, p);
title(titleString);

subplot(3, 1, 2);
plot( bankrollValues, betResults );
grid on;
xlabel('Initial Bankroll');
ylabel('Average number of bets');

%Recall: Expected value = prob of event 1 * value of event
%        + prob of event 2 + value of event 2 + ...

expected = winResults.*(goal - bankrollValues) - (1-winResults).*bankrollValues;
subplot(3,1,3);
plot( bankrollValues, expected );
grid on;
xlabel('Initial Bankroll');
ylabel('Expected value for gambler');

%%

%Bankroll analysis over different starting money values

clear;clc;

TRIALS = 5000;
initial = 50;
goal = 100;

pValues = .45:0.001:.55;
winResults = [];
betResults = [];

for j = pValues
   
   wins = 0;
   totalBets = 0;
    
   for i = 1:TRIALS
   [success bets] = gambler( goal, initial, j );
   if success == true
       wins = wins + 1;
   end
   totalBets = totalBets + bets;
   end
    
   winPct = wins / TRIALS;
   avgBets = totalBets / TRIALS;
   
   winResults = [ winResults winPct ];
   betResults = [ betResults avgBets ];
   
end

subplot(3, 1, 1);

hold off;
plot( pValues, winResults );
grid on;
hold on;
xlabel('Chance of coinflip');
ylabel('Chance of winning');
titleString = sprintf('Win percent analysis for goal=%d and initial=%d', goal, initial);
title(titleString);

subplot(3, 1, 2);
plot( pValues, betResults );
grid on;
xlabel('Chance of coinflip');
ylabel('Average number of bets');

%Recall: Expected value = prob of event 1 * value of event
%        + prob of event 2 + value of event 2 + ...

expected = winResults.*(goal - initial) - (1-winResults).*initial;
subplot(3,1,3);
plot( pValues, expected );
grid on;
xlabel('Chance of coinflip');
ylabel('Expected value for gambler');

