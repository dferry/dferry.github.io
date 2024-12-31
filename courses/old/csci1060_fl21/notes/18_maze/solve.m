% solve.m
% Michael Goldwasser (14 Apr 2009)

function path = solve(maze, goal, start, animationDelay)
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
    [numRows numCols four] = size(maze);
    
    % table of directional movements
    delta = [-1  0;    % up one row
              0 -1;    % left one column
             +1  0;    % down one row
              0 +1;    % right one column
             ];
    
    path = start;
    
    crumbs = zeros(numRows, numCols);
    
    % motion
    while ~isempty(path) && any(path(:,end) ~= goal)
        % mark current position as visited
        row = path(1,end);
        col = path(2,end);
        crumbs(row, col) = 1;
        
        % find next available step, if any
        dir = 0;       % actual direction chosen
        option = 1;    % possible direction to consider
        while dir == 0 && option <= 4
            if maze(row, col, option) && ~crumbs(row+delta(option,1), col+delta(option,2))
                dir = option;
            else
                option = option + 1;
            end
        end
        
        if dir > 0
            % add to path
            path = [path [row + delta(dir,1); col + delta(dir,2)] ];
        else 
            % remove last step from the path
            path(:, end) = [];
        end
 
        if animationDelay
            visualize(maze, goal, start, path, crumbs, animationDelay);
        end
    end
    visualize(maze, goal, start, path, crumbs, animationDelay);
    
    
    function visualize(maze, goal, start, path, crumbs, animationDelay)
        [numRows numCols four] = size(maze);
        plotMaze(maze, goal, start);
        hold on;
        for r = 1:numRows
            for c = 1:numCols
                if crumbs(r,c)
                    plot(c,r, 'sr');
                end
            end
        end
        for entry = path
            plot(entry(2), entry(1), 'sb');
        end
        if ~isempty(path)
            plot(path(2, end), path(1, end), 'sb', 'MarkerFaceColor', 'b');   % plot current
        end
        hold off;
        pause(animationDelay);
