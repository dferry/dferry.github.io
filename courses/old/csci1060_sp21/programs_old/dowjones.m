%Analyzing DJIA.txt
%David and Class

clear; clc;
djia = load('djia.txt');

YEAR = 1;
MONTH = 2;
DAY = 3;
OPEN = 4;
HIGH = 5;
LOW = 6;
CLOSE = 7;
VOLUME = 8;

firstDayGain = djia(1,CLOSE) - djia(1,OPEN)

%Find the maximum gain over all data
maxGain = firstDayGain;
maxLocation = 1;
for i = 1:length(djia)
   dayGain = djia(i,CLOSE) - djia(i,OPEN);
   if dayGain > maxGain
      maxGain = dayGain; 
      maxLocation = i;
   end
end
%%
fprintf('Maximum gain over data set is %f at location %d\n', maxGain, maxLocation);

%Find the maximum gain over all data
maxLoss = firstDayGain;
lossLocation = 1;
for i = 1:length(djia)
   dayGain = djia(i,CLOSE) - djia(i,OPEN);
   if dayGain < maxLoss
      maxLoss = dayGain; 
      LossLocation = i;
   end
end

fprintf('Maximum loss over data set is %f at location %d\n', maxLoss, LossLocation);
%%

firstRelDayGain = 100*((djia(1,CLOSE)/djia(1,OPEN))-1)

%Find the maximum and minimum gain over all data
maxGain = firstRelDayGain;
minGain = firstRelDayGain;
maxLocation = 1;
minLocation = 1;
for i = 1:length(djia)
   dayRelGain = 100*((djia(i,CLOSE)/djia(i,OPEN))-1)
   if dayRelGain > maxGain
      maxGain = dayRelGain; 
      maxLocation = i;
   end
   if dayRelGain < minGain
       minGain = dayRelGain;
       minLocation = i;
   end
end

fprintf('Maximum gain over data set is %f at location %d\n', maxGain, maxLocation);
fprintf('Maximum loss over data set is %f at location %d\n', minGain, minLocation);

%%

gainCounter = 0;
lossCounter = 0;
evenCounter = 0;

for i = 1:length(djia)
    daysGain = djia(i,CLOSE) - djia(i,OPEN);
    if daysGain > 0
        gainCounter = gainCounter + 1;
    elseif daysGain < 0
        lossCounter = lossCounter + 1;
    else
        evenCounter = evenCounter + 1;
    end
end

fprintf('Days of gain:      %d\n', gainCounter);
fprintf('Days of loss:      %d\n', lossCounter);
fprintf('Days of no change: %d\n', evenCounter);

%%

gainCounter = 0;
lossCounter = 0;
gainTotal = 0;
lossTotal = 0;

for i = 1:length(djia)
    daysGain = 100*((djia(i,CLOSE)/djia(i,OPEN))-1);
    if daysGain > 0
        gainCounter = gainCounter + 1;
        gainTotal = gainTotal + daysGain;
    elseif daysGain < 0
        lossCounter = lossCounter + 1;
        lossTotal = lossTotal + daysGain;
    end
end

fprintf('Average relative gain is %f\n', gainTotal/gainCounter);
fprintf('Average relative loss is %f\n', lossTotal/lossCounter);