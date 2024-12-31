function stockAnalysis(stock, choice)
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
  global YEAR MONTH DATE OPEN HIGH LOW CLOSE VOLUME   % share with other functions
  YEAR=1; MONTH=2; DATE=3; OPEN=4; HIGH=5; LOW=6; CLOSE=7; VOLUME=8;

  switch choice
   case 1
    bestCalendarMonth(stock)
   case 2
    consecutiveGains(stock)
   case 3
    historicDownturn(stock)
   case 4
    yearEnd(stock)
   case 5
    dailyMean(stock)
  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dateString = formatDate(stock, row)
    % Create a string of the form YYYY/MM/DD for a given row of the stock data.
    global YEAR MONTH DATE
    dateString = sprintf('%d/%02d/%02d', ...
                         stock(row, YEAR), stock(row, MONTH), stock(row, DATE));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bestCalendarMonth(stock)
    % Find a single month with the biggest open to close percentage gain.
    global YEAR MONTH DATE OPEN HIGH LOW CLOSE VOLUME

    yearMonth = stock(:, YEAR) + stock(:, MONTH)/12;   % convenient choice for call to peaks
    [numMonths months] = peaks(yearMonth);    % each peak is index of a new month beginning
    bestGain = 0;
    for m = 1:(numMonths-1)    % ignore last month in case it is partial
      mStart = months(m);
      mEnd = months(m+1)-1;
      gain = stock(mEnd, CLOSE) / stock(mStart, OPEN);
      if gain > bestGain
        bestGain = gain;
        bestStart = mStart;
        bestEnd = mEnd;
      end
    end
    fprintf('Opening price on %s was %.2f.\n', formatDate(stock, bestStart), stock(bestStart, OPEN));
    fprintf('Closing price on %s was %.2f.\n', formatDate(stock, bestEnd), stock(bestEnd, CLOSE));
    fprintf('That is a gain of %.2f%%.\n', 100 * (bestGain-1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function consecutiveGains(stock)
% Find the longest streak of daily gains.
    global YEAR MONTH DATE OPEN HIGH LOW CLOSE VOLUME

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
    fprintf('starting on %s and continuing through %s.\n', ...
            formatDate(stock, gainStart), formatDate(stock, gainEnd));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function historicDownturn(stock)
% Find the biggest ever percentage downturn.
    global YEAR MONTH DATE OPEN HIGH LOW CLOSE VOLUME

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
    fprintf('High price on %s was %.2f.\n', ...
            formatDate(stock, worstStart), stock(worstStart, HIGH));
    fprintf('Low price on %s was %.2f.\n', ...
            formatDate(stock, worstEnd), stock(worstEnd, LOW));
    fprintf('That is %.2f%% of the previous high.\n', 100 * worstDrop);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function yearEnd(stock)
% Analyze the geometric mean of the first and last market days,
% relative to a typical day.
    global YEAR MONTH DATE OPEN HIGH LOW CLOSE VOLUME

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dailyMean(stock)
% Analyze the geometric mean of all calendar dates.
    global YEAR MONTH DATE OPEN HIGH LOW CLOSE VOLUME

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
