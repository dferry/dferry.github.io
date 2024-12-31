%Stock market analysis
%David and class
%2/7/2020
clear;clc;

data = load( 'djia.txt' );

YEAR = 1;
MONTH = 2;
DAY = 3;
OPEN = 4;
HIGH = 5;
LOW = 6;
CLOSE = 7;
VOLUME = 8;

%Maximum finding algorithm
maxGain = 0;
maxRow = 1;

for i = 1:length(data)
   gain = data( i, CLOSE ) - data( i, OPEN ); 

   if gain > maxGain
      maxGain = gain;
      maxRow = i;
   end
   
end

maxGain
maxRow

%Minimum finding algorithm
minRow = 0;
minGain = 0;

for i = 1:length(data)
   gain = data( i, CLOSE ) - data( i, OPEN ); 

   if gain < minGain
      minGain = gain;
      minRow = i;
   end
   
end

minGain
minRow

maxPctGain = 0;
maxPctRow = 0;

%Largest percentage gain
for i = 1:length(data)
    %Absolute gain
    %gain = data( i, CLOSE ) - data( i, OPEN ); 
    %Percentage gain
    gain = 100*(data(i,CLOSE)-data(i,OPEN))/data(i,OPEN)
    
   if gain > maxPctGain
      maxPctGain = gain;
      maxPctRow = i;
   end
   
end

maxPctGain
maxPctRow

thisYear = data( maxPctRow, YEAR );
thisMonth = data( maxPctRow, MONTH );
thisDay = data( maxPctRow, DAY );

fprintf('The maximum percent gain was %.1f on %d/%d/%d\n', maxPctGain, thisYear, thisMonth, thisDay );



%Find number of days of gain loss and no change
%Find average gain and average loss

positiveCount = 0;
negativeCount = 0;
noChangeCount = 0;
totalGain = 0;
totalLoss = 0;

for i = 1:length(data)
   gain = data( i, CLOSE ) - data( i, OPEN ); 

   if gain > 0
       positiveCount = positiveCount + 1;
       totalGain = totalGain + gain;
   elseif gain < 0
       negativeCount = negativeCount + 1;
       totalLoss = totalLoss + gain;
   elseif gain == 0
       noChangeCount = noChangeCount + 1;
   end
   
end

avgGain = totalGain/positiveCount;
avgLoss = totalLoss/negativeCount;

fprintf('There were %d days of gain, %d days of loss,\nand %d days of no change\n', positiveCount, negativeCount, noChangeCount );
fprintf('The average gain was %.1f and the average loss was %1.f', avgGain, avgLoss);

