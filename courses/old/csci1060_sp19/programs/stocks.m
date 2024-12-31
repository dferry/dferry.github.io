%Stock market analysis
% Feb 13, 2019
% David and class

data = load('djia.txt');

YEAR   = 1;
MONTH  = 2;
DAY    = 3;
OPEN   = 4;
HIGH   = 5;
LOW    = 6;
CLOSE  = 7;
VOLUME = 8;

rows = length(data);

%%
% Find the day with largest gain
% gain = (closing price) - (opening price)

maxGain = 0;
maxLocation = 0;

for index = 1:rows
    %disp('The current day is');
    %disp(index);
    gain = data(index,CLOSE) - data(index,OPEN);
    %disp('which has gain');
    %disp(gain);
    
    if gain > maxGain
       maxGain = gain;
       maxLocation = index;
       fprintf('Found new max gain: %f0.2 on %d/%d/%d\n', gain, ...
           data(index,YEAR), data(index,MONTH), data(index,DAY));
    end
end

disp('The maximum gain is');
disp(maxGain);
disp('Which occurred on');
data(maxLocation,YEAR)
data(maxLocation,MONTH)
data(maxLocation,DAY)


%%
% Find the day with largest loss
% gain = (closing price) - (opening price)

maxLoss = 0;
maxLocation = 0;

for index = 1:rows
    %disp('The current day is');
    %disp(index);
    loss = data(index,CLOSE) - data(index,OPEN);
    %disp('which has gain');
    %disp(gain);
    
    if loss < maxLoss
       maxLoss = loss;
       maxLocation = index;
       fprintf('Found new max loss: %f0.2 on %d/%d/%d\n', loss, ...
           data(index,YEAR), data(index,MONTH), data(index,DAY));
    end
end

disp('The maximum loss is');
disp(maxLoss);
disp('Which occurred on');
data(maxLocation,YEAR)
data(maxLocation,MONTH)
data(maxLocation,DAY)

%%
% Find the day with largest percentage gain
% gain = ((closing price) - (opening price))/(opening price)

maxGain = 0;
maxLocation = 0;

for index = 1:rows
    %disp('The current day is');
    %disp(index);
    gain = (data(index,CLOSE) - data(index,OPEN))/data(index,OPEN);
    %disp('which has gain');
    %disp(gain);
    
    if gain > maxGain
       maxGain = gain;
       maxLocation = index;
       fprintf('Found new max gain: %f0.2 on %d/%d/%d\n', gain, ...
           data(index,YEAR), data(index,MONTH), data(index,DAY));
    end
end

disp('The maximum gain is');
disp(maxGain);
disp('Which occurred on');
data(maxLocation,YEAR)
data(maxLocation,MONTH)
data(maxLocation,DAY)




%%
% Find and report when the month changes

startOfMonthRow = 1;
currentMonth = data( startOfMonthRow, MONTH );
for index = 1:length(data)
   
    if currentMonth ~= data( index, MONTH )
       %We have switched month values
       endOfMonthRow = index - 1;
       fprintf('Found a new month starting on row %d and ending on row %d\n',...
           startOfMonthRow, endOfMonthRow);
       
       %Set up values for next for-loop iteration
       startOfMonthRow = index;
       currentMonth = data( index, MONTH );
    end
    
end



%%
%Outline for question 3 on HW4

highSoFar = 0;
for index  = 1:length(data)
   
    %Keep track of the highest HIGH value ever seen
    if data(index, HIGH) > highSoFar
        %...?
    end
    
    todaysLow = data(index, LOW);
    
    %Keep track of the biggest downturn
    %1) Compute downturn versus today
    %   todaysDownturn = highSoFar / todaysLow;
    %2) if this downturn is the smallest ratio we've ever seen,
    %   then it is a new minimum
    
end


%%
% The bad way to do Q3 on HW4
% double for loop

maxDownturn = 100;
startRow = 0;
endRow = 0;
for a = 1:length(data)
    for b = 1:length(data)
        if a < b
            downturn = data(a, HIGH)/data(b,LOW);
            if( downturn < maxDownturn )
                maxDownturn = downturn;
                startRow = a;
                endRow = b;
            end
        end
    end
end

fprintf('Biggest downturn between rows %d and %d is %0.2f\n', startRow, endRow, maxDownturn*100);







