%David and Class
% March 5th, 2021
% Finding monthly gain

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

currentMonth = data( 1, MONTH ); %has a value between 1 and 12
startRowOfCurrentMonth = 1;

for i=start:finish
   
    monthOfRowI = data( i, MONTH );
    
    if monthOfRowI ~= currentMonth
        lastRowOfCurrentMonth = i - 1;
        
        openOnFirstDay = data( startRowOfCurrentMonth, OPEN );
        closeOnLastDay = data( lastRowOfCurrentMonth, CLOSE );
        gainOfCurrentMonth = ( closeOnLastDay - openOnFirstDay )/ closeOnLastDay;
        
        fprintf('The month of %d/%d had a gain of %0.2f\n', ...
            data(i-1,MONTH), data(i-1, YEAR), gainOfCurrentMonth);
        
        %AFTER we use the gain, then we update currentMonth etc.
        %for computing the next month
        currentMonth = data( i, MONTH );
        startRowOfCurrentMonth = i;
        
    end
    
end













