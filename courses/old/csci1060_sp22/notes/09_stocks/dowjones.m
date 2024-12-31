%Author: David and Class
%Feb 10th, 2017
%Analyze historical Dow Jones data

clear;
clc;

dow = load('djia.txt');

YEAR   = 1;
MONTH  = 2;
DAY    = 3;
OPEN   = 4;
HIGH   = 5;
LOW    = 6;
CLOSE  = 7;
VOLUME = 8;

%First, compute the largest day with single point gain
%Point gain: close - open

%For example, the point gain on the first day
gain = dow(1, CLOSE) - dow(1, OPEN);

%Now we compute the maximum gain on a per-day basis
maxGain = gain;
maxIndex = 1;
for i = 1:length(dow)
   dayGain = dow(i, CLOSE) - dow(i, OPEN); 
   if dayGain > maxGain
      maxGain = dayGain; 
      maxIndex = i;
   end
end

fprintf('Highest gain is %0.2f on %d/%d/%d\n', maxGain,...
    dow(maxIndex,MONTH), dow(maxIndex,DAY), dow(maxIndex,YEAR));

%Now we'd like to compute the single day largest loss
%Now we compute the maximum loss on a per-day basis
maxLoss = gain;
lossIndex = 1;
for i = 1:length(dow)
   dayLoss = dow(i, CLOSE) - dow(i, OPEN); 
   if dayLoss < maxLoss
      maxLoss = dayLoss; 
      lossIndex = i;
   end
end

fprintf('Greatest loss is %0.2f on %d/%d/%d\n', maxLoss,...
    dow(lossIndex,MONTH), dow(lossIndex,DAY), dow(lossIndex,YEAR));

%Now we compute the greatest relative gain over time
relGain = 0;
relIndex = 1;
for i = 1:length(dow)
   dayRelGain = dow(i, CLOSE)/dow(i, OPEN); 
   if dayRelGain > relGain
      relGain = dayRelGain; 
      relIndex = i;
   end
end

fprintf('Highest percent gain is %0.1f%% on %d/%d/%d\n', (relGain - 1)*100,...
    dow(relIndex,MONTH), dow(relIndex,DAY), dow(relIndex,YEAR));

%Now we count the number of days of gain and loss
daysGain = 0; %number of days of gain in market
daysLoss = 0; %number of days of loss in market
totalGain = 0; %total number of points gained
totalLoss = 0; %total number of points lost
washDays = 0;

for i = 1:length(dow)
   diff = dow(i, CLOSE) - dow(i, OPEN);
   if( diff > 0 )
      daysGain = daysGain + 1;
      totalGain = totalGain + diff;
   elseif ( diff < 0 )
       daysLoss = daysLoss + 1;
       totalLoss = totalLoss + diff;
   else
       washDays = washDays + 1;
   end
end

fprintf('Total days of gain: %d days and %0.2f points\n',...
    daysGain, totalGain);
fprintf('  with an average gain of %0.2f\n', totalGain/daysGain);
fprintf('Total days of loss: %d days and %0.2f points\n',...
    daysLoss, totalLoss);
fprintf('  with an average loss of %0.2f\n', totalLoss/daysLoss);
fprintf('Total days of no change: %d\n', washDays);