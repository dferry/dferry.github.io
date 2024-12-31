%David and Class
% March 1st, 2021
% Stock market analysis 

YEAR = 1;
MONTH = 2;
DAY = 3;
OPEN = 4;
HIGH = 5;
LOW = 6;
CLOSE = 7;
VOLUME = 8;

data = load('djia.txt');

%%

%Compute the day with largest absolute GAIN

%gain = closing price - opening price
%gain1000 = data( 1000, CLOSE ) - data( 1000, OPEN )

start = 1;
finish = length( data );

largestGain = 0;
largestGainRow = 0;

for i = start:finish
    gainOfDayI = data( i, CLOSE ) - data( i, OPEN );
    
    if gainOfDayI > largestGain
        largestGain = gainOfDayI;
        largestGainRow = i;
    end
    
end

largestGainRow
largestGain
gainYear = data( largestGainRow, YEAR )
gainMonth = data( largestGainRow, MONTH )
gainDay = data( largestGainRow, DAY )

%%

%Find the largest absolute LOSS

start = 1;
finish = length( data );

%Remember- "gain" can be either positive or negative
largestGain = 0;
largestGainRow = 0;

for i = start:finish
    gainOfDayI = data( i, CLOSE ) - data( i, OPEN );
    
    if gainOfDayI < largestGain
        largestGain = gainOfDayI;
        largestGainRow = i;
    end
    
end

largestGainRow
largestGain
gainYear = data( largestGainRow, YEAR )
gainMonth = data( largestGainRow, MONTH )
gainDay = data( largestGainRow, DAY )

%%

%Find the largest percentage GAIN

%gain = closing price - opening price
%percentageGain = ( closing price - opening price ) / opening price


start = 1;
finish = length( data );

largestGain = 0;
largestGainRow = 0;

for i = start:finish
    %Percentage gain at each day
    gainOfDayI = (data( i, CLOSE ) - data( i, OPEN ))/data(i, OPEN);
    
    if gainOfDayI > largestGain
        largestGain = gainOfDayI;
        largestGainRow = i;
    end
    
end

largestGainRow
largestGain
gainYear = data( largestGainRow, YEAR )
gainMonth = data( largestGainRow, MONTH )
gainDay = data( largestGainRow, DAY )

fprintf('The largest relative gain was %0.2f on %d/%d/%d\n', ...
    largestGain ,gainMonth, gainDay, gainYear );


%%

start = 1;
finish = length(data);

positiveGain = 0; %Three counters
negativeGain = 0;
noChange = 0;

for i = start:finish
    gainOfDayI = data( i, CLOSE ) - data( i, OPEN );
    
    if gainOfDayI > 0
        positiveGain = positiveGain + 1;
    elseif gainOfDayI < 0
        negativeGain = negativeGain + 1;
    else
        noChange = noChange + 1;
    end
        
end

fprintf('There were %d days of increase\n', positiveGain );
fprintf('There were %d days of decrease\n', negativeGain );
fprintf('There were %d days of no change\n', noChange );

%%

start = 1;
finish = length(data);

runningTotal = 0;
numberOfDays = length(data);

for i = start:finish
    gainOfDayI = (data( i, CLOSE ) - data( i, OPEN ))/data(i, OPEN);
    
    runningTotal = runningTotal + gainOfDayI;
end

%Compute the average
averageGain = runningTotal / numberOfDays

%%

%compound interest formulat

%final value = initial value * (1+interest rate)^number of days compounded

1 * (1+0.0001748)^(365*40)


