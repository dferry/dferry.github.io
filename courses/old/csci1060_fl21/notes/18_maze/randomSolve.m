% randomSolve.m
% Michael Goldwasser (14 Apr 2009)
% Based on original code by
% Brody Dylan Johnson (6 Mar 2009)

function path = randomSolve(maze, goal, start, animationDelay)
    % Usage:  path = robotmaze(maze, start, goal, animateDelay)
    %
    % maze should be an R x C x 4 array for
    %   a maze with R rows and C columns, where
    %   the third dimension represents a direction
    %   of motion (1=up, 2=left, 3=down, 4=right)
    %   Entry maze(r,c,dir) is 1 if that motion is permissible
    %     when at position (r,c), and 0 otherwise.
    %
    % goal is a 2 x 1 array designating the goal [r; c]
    %
    % start is a 2 x 1 array designating the starting [r; c]
    %
    % animateDelay, if given, designates that animation
    %    of each step should be given with specified pause
    %
    % path is a 2 x k array describing the eventual path
    %    from the start (first column) to the end (last column).
    if nargin == 3
        animationDelay = 0;
    end
    
    % table of directional movements
    delta = [-1  0;    % up one row
              0 -1;    % left one column
             +1  0;    % down one row
              0 +1;    % right one column
             ];
         
    row = start(1);
    col = start(2);
    path = start;
    
    % motion
    while row ~= goal(1) || col ~= goal(2)
        test = 0;
        while test == 0
            dir = ceil(4 * rand);
            test = maze(row, col, dir);
        end
        row = row + delta(dir,1);
        col = col + delta(dir,2);
        path = [path [row; col] ];
        if animationDelay
            visualize(maze, goal, start, path, animationDelay);
        end
    end

    
function visualize(maze, goal, start, path, animationDelay)
    [numRows numCols four] = size(maze);
    plotMaze(maze, goal, start);
    hold on;
    plot(path(2,end), path(1,end), 'sb');
    hold off;
    pause(animationDelay);
