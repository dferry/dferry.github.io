%#ok<*NOPTS>
%
% Welcome to the wonderful world of MATLAB
%
% Highlight a cell with your mouse and press CTRL+Enter to run that cell

%%
% Using MATLAB as a calculator
% Declare variables x and y, then compute variable z

x = 10 
y = 20
z = x + y


%%
% Using MATLAB as a data processor
% Declare a vector of integers (whole numbers) and sort it
% Also compute the average value

data = [ 7 5 9 12 41 68 100 48 ]
sorted = sort(data)
mean = mean(data) %compute the average values

%%
% Using MATLAB to plot information
% One of the big benefits of MATLAB is the huge array of built-in tools

%cities format: each row gives name, latitude, longitude, population
cities = { 'St. Louis'   38.635699 -90.244582 316000;
           'Kansas City' 39.0997   -94.5786   481000;
           'Springfield' 37.2090   -93.2923   164000
           'Columbia'    38.9517   -92.3341   121000;
           'Kirksville'  40.1948   -92.5832   18000}

figure
state = 'Missouri';
usamap(state)
statehi = shaperead('usastatehi', 'UseGeoCoords', true,...
            'Selector',{@(name) strcmpi(name,state), 'Name'});
geoshow(statehi, 'FaceColor', 'none')

%Draw each city, plus a 3d bar showing population, plus a 2d circle on the
%map at that location
citiesMat = cell2mat(cities(:, 2:4));
lats = citiesMat(:,1);
lons = citiesMat(:,2);
pops = citiesMat(:,3);
stem3m(lats, lons, pops, 'r-', 'LineWidth', 3);
for i = 1:length(citiesMat)
    lat = citiesMat(i, 1);
    lon = citiesMat(i, 2);
    [clat, clon] = scircle1( lat, lon, 10, [], earthRadius('km') );
    patchm( clat, clon, 'k' );
    textm(lat, lon+0.2, cities(i,1));
end

%Set the default camera position
defaultPos = [ -1.868393318732374  -0.147983933404255   5.046145021095360 ] .* 1.0e+06;
campos(defaultPos);

%Set title
title('Population of Missouri Cities');

%%
% Using MATLAB as a general purpose programming environment
% 
clc;
target = randi(10);

while( true )
    guess = input('Guess a number between 1 and 10: ');
    if( guess < target )
        disp('Too low!');
    elseif( guess > target )
        disp('Too high!');
    elseif( guess == target )
        disp('Got it!');
        break;
    end
end