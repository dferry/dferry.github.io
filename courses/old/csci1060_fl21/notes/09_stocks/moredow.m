%Author: David and Class
%Feb 15th, 2017
%Find which year in the djia.txt had the most trading days

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

firstYear = 1928;
lastYear = 2009;

daysInYear = zeros(1, lastYear);

for i = 1:length(dow)
   thisYear = dow(i, YEAR);
   daysInYear(thisYear) = daysInYear(thisYear) + 1;
end

minYearDays = min(daysInYear(firstYear+1:lastYear-1));
minYear = find( daysInYear == minYearDays );

for i = firstYear:lastYear
   fprintf('Year %d had %d days\n', i, daysInYear(i)); 
end

fprintf('The smallest trading year was %d year with %d days\n',...
    minYear, minYearDays);

%Another way to solve this same problem
%Rather than counting each year in the data set
%We identify the start and ends of each year, and subtract

daysInYear2 = zeros(1,lastYear);
currYear = -1;
startOfYear = -1;
endOfYear = -1;
minYear = -1;
minYearDays = 365;

for i = 1:length(dow)
    %Check to see if we're in a new year
    if( currYear ~= dow(i,YEAR) )
        %Process the last year
        endOfYear = i-1;
        if( currYear ~= -1 )
            daysInYear2(currYear) = endOfYear - startOfYear + 1;
        end
        
        if( currYear ~= -1 && currYear ~= 1928 && daysInYear2(currYear) < minYearDays )
           minYear = currYear;
           minYearDays = daysInYear2(currYear);
           fprintf('Found new minimum: %d days in year %d\n', minYearDays, minYear);
        end
        
        %Update variables for new year
        %fprintf('Found new year %d on line %d\n', dow(i,YEAR), i);
        startOfYear = i;
        currYear = dow(i,YEAR);
    end
end

%Fix up the last year in the data set
daysInYear2(currYear) = length(dow) - startOfYear + 1;

%for i = firstYear:lastYear
%   fprintf('Year %d had %d days\n', i, daysInYear2(i)); 
%end