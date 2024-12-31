% Performs one of five possible analyses of stock data.
% Choices are:
%   1) Best calendar month (% gain)
%   2) Most consecutive days with gain
%   3) Biggest historical downturn (% loss)
%   4) Year end analysis (geometric mean)
%   5) Daily analysis (geometric mean)
%
% The stock data is assumed to have one row per market day
% with each row designating the fields
% [year month date open high low close volume]

filename = 'djia.txt';
stock = load(filename);

YEAR=1;
MONTH=2;
DATE=3;
OPEN=4;
HIGH=5;
LOW=6;
CLOSE=7;
VOLUME=8;

choice = 0;
while choice ~= 6
    
    fprintf('\n');
    choice = menu('Stock Market Analysis', ...
        'Best calendar month (% gain)', ...
        'Most consecutive days with gain', ...
        'Biggest historical downturn (% loss)', ...
        'Year end analysis (geometric mean)', ...
        'Daily analysis (geometric mean)', ...
        'Quit');
    fprintf('\n');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Question 1 - Greatest monthly gain
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if choice == 1
        %Set up variables for finding each month
        currentMonth = stock( 1, MONTH );
        currentMonthRow = 1;
        
        %Set up variables for maximum finding algorithm
        maxGain = 0;
        maxStart = 0; %row
        maxEnd = 0; %row
        
        for i=1:length(stock)            
            %Detect when month changes
            if stock( i, MONTH ) ~= currentMonth
                firstDay = currentMonthRow;
                lastDay = i - 1; %the value of i went one row too far
                
                openPrice = stock(firstDay, OPEN);
                closePrice = stock(lastDay, CLOSE);
                
                monthlyGain = ((closePrice/openPrice)-1)*100;
                
                if monthlyGain > maxGain
                    maxGain = monthlyGain;
                    maxStart = firstDay;
                    maxEnd = lastDay;
                end
                
                %new current month
                currentMonth = stock( i, MONTH );
                currentMonthRow = i;
                
            end
            
        end
        
        openYear = stock( maxStart, YEAR );
        openMonth = stock( maxStart, MONTH );
        openDay = stock( maxStart, DATE );
        closeYear = stock( maxEnd, YEAR );
        closeMonth = stock( maxEnd, MONTH );
        closeDay = stock( maxEnd, DATE );
        
        openPrice = stock( maxStart, OPEN );
        closePrice = stock( maxEnd, CLOSE );
        
        fprintf('Opening price on %d/%02d/%02d was %.1f\n', openYear, openMonth, openDay, openPrice);
        fprintf('Closing price on %d/%02d/%02d was %.1f\n', closeYear, closeMonth, closeDay, closePrice);
        fprintf('That is a gain of %.1f%%\n', maxGain );
        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Question 2 - Longest Streak
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if choice == 2
        gainStart = 1;
        gainEnd = 1;
        gainNum = 0;
        day = 1;
        while day <= length(stock)
            count = 0;
            curStart = day;
            while day <= length(stock) && stock(day,CLOSE) > stock(day,OPEN)
                count = count + 1;
                day = day + 1;
            end
            if count > gainNum
                gainStart = curStart;
                gainEnd = day - 1;
                gainNum = count;
            end
            day = day + 1;
        end
        fprintf('Found %d consecutive days of gain\n', gainNum);
        fprintf('starting on %d/%02d/%02d and continuing through %d/%02d/%02d.\n', ...
            stock(gainStart, YEAR), stock(gainStart, MONTH), stock(gainStart, DATE), ...
            stock(gainEnd, YEAR), stock(gainEnd, MONTH), stock(gainEnd, DATE));
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Question 3 - Maximum Downturn
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if choice == 3
        worstStart = 1;
        worstEnd = 1;
        worstDrop = 1;   % percentage drop
        saveHigh = 1;
        for day = 2:length(stock)
            pctDrop = stock(day, LOW) / stock(saveHigh, HIGH);
            if pctDrop < worstDrop
                worstStart = saveHigh;
                worstEnd = day;
                worstDrop = pctDrop;
            end
            if stock(day, HIGH) > stock(saveHigh, HIGH)
                saveHigh = day;
            end
        end
        fprintf('High price on %d/%02d/%02d was %.2f.\n', ...
            stock(worstStart, YEAR), stock(worstStart, MONTH), ...
            stock(worstStart, DATE), stock(worstStart, HIGH));
        fprintf('Low price on %d/%02d/%02d was %.2f.\n', ...
            stock(worstEnd, YEAR), stock(worstEnd, MONTH), ...
            stock(worstEnd, DATE), stock(worstEnd, LOW));
        fprintf('That is %.2f%% of the previous high.\n', 100 * worstDrop);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Question 4 - Market Trends
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if choice == 4
        firstMean = 1.0;
        allMean = 1.0;
        lastMean = 1.0;
        yrCount = 0;
        yr = stock(1, YEAR);
        count = 0;
        
        for day = 1:length(stock)
            daily = stock(day, CLOSE) / stock(day, OPEN);
            allMean = allMean * daily;
            if stock(day,1) ~= yr
                yr = stock(day, YEAR);
                yrCount = yrCount + 1;
                lastMean = lastMean * stock(day-1, HIGH) / stock(day-1, CLOSE);
                firstMean = firstMean * daily;
            end
        end
        firstMean = firstMean ^ (1/yrCount);
        lastMean = lastMean ^ (1/yrCount);
        allMean = allMean ^ (1/length(stock));
        
        fprintf('%-14s    %14s\n', 'Day type', 'Geometric Mean');
        fprintf('%-14s    %14s\n', '-------------', '--------------');
        fprintf('%-14s    %14.6f\n', 'first of year', firstMean);
        fprintf('%-14s    %14.6f\n', 'last of year', lastMean);
        fprintf('%-14s    %14.6f\n', 'typical', allMean);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Extra Credit - Day of Greatest Gain
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if choice == 5
        count = zeros(12,31);
        mean = ones(12,31);
        for day = 1:length(stock)
            daily = stock(day, CLOSE) / stock(day, OPEN);
            count(stock(day, MONTH), stock(day, DATE)) = ...
                count(stock(day, MONTH), stock(day, DATE)) + 1;
            mean(stock(day, MONTH), stock(day, DATE)) = ...
                mean(stock(day, MONTH), stock(day, DATE)) * daily;
        end
        
        geom = mean .^ (1 ./ count);
        [colmax ind] = max(geom);
        [theMax bestCol] = max(colmax);
        
        fprintf('Overall geometric means is %.6f.\n', prod(prod(mean)) ^ (1 / sum(sum(count))));
        fprintf('Best historic date is %02d/%02d with geometric mean %.6f.\n', ...
            ind(bestCol), bestCol, theMax);
    end
    
end

