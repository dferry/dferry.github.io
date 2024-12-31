%David and class
%Finding downturns
%March 5th, 2021

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

start = 1;
finish = length(data);

highestHighSoFar = 0;
hightestRow = 0;

%We want the previous high price compared to today's low price
for i = start:finish
   
    highOnRowI = data( i, HIGH );
    if highOnRowI > highestHighSoFar
        highestHighSoFar = highOnRowI;
        highestRow = i;
    end
   
    biggestDownturnToRowI = data(i, LOW) / highestHighSoFar;
    
    fprintf('The high price on %d/%d/%d was %0.2f\n', ...
        data(highestRow, MONTH), data(highestRow, DAY), ...
        data(highestRow, YEAR), highestHighSoFar );
    fprintf('The low price on %d/%d/%d was %0.2f\n', ...
        data(i, MONTH), data(i, DAY), ...
        data(i, YEAR), data(i,LOW) );
    fprintf('That is %0.2f of the previous high\n\n\n', biggestDownturnToRowI );
    
    
    
end





















