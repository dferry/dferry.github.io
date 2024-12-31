%David and class
%2/14/2020
%Homework4 problem 1
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

%Set up variables for finding each month
currentMonth = data( 1, MONTH );
currentMonthRow = 1;

%Set up variables for maximum finding algorithm
maxGain = 0;
maxStart = 0; %row
maxEnd = 0; %row

for i=1:length(data)
%for i=1:300
     
    %Detect when month changes
    if data( i, MONTH ) ~= currentMonth
       firstDay = currentMonthRow;
       lastDay = i - 1; %the value of i went one row too far
       
       openPrice = data(firstDay, OPEN);
       closePrice = data(lastDay, CLOSE);
       
       monthlyGain = ((closePrice/openPrice)-1)*100;
       
       if monthlyGain > maxGain
          maxGain = monthlyGain;
          maxStart = firstDay;
          maxEnd = lastDay;
       end
       
       %new current month
       currentMonth = data( i, MONTH );
       currentMonthRow = i;
       %i %for debugging
       
    end
    
end

    openYear = data( maxStart, YEAR );
    openMonth = data( maxStart, MONTH );
    openDay = data( maxStart, DAY );
    closeYear = data( maxEnd, YEAR );
    closeMonth = data( maxEnd, MONTH );
    closeDay = data( maxEnd, DAY );

    openPrice = data( maxStart, OPEN );
    closePrice = data( maxEnd, CLOSE );
    
    fprintf('Opening price on %d/%d/%d was %.1f\n', openYear, openMonth, openDay, openPrice);
    fprintf('Closing price on %d/%d/%d was %.1f\n', closeYear, closeMonth, closeDay, closePrice);
    fprintf('That is a gain of %.1f%%\n', maxGain );

