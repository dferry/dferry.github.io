function plotMaze(maze,goal, start)
    % maze should be an R x C x 4 array for
    %   a maze with R rows and C columns, where
    %   the third dimension represents a direction
    %   of motion (1=up, 2=left, 3=down, 4=right)
    %   Entry maze(r,c,dir) is 1 if that motion is permissible
    %     when at position (r,c), and 0 otherwise.
    %
    % goal, if given  is a 1 x 2 array designating the goal (r,c)
    %     it will be drawn in green
    %
    % start, if given, is a 1 x 2 array designating the starting (r,c)
    %     it will be drawn in red
    if nargin < 3
        goal = [0 0];
        if nargin < 2
            start = [0 0];
        end
    end
    
    incomingHold = ishold;
    [R C four] = size(maze);

    % forcibly draw right wall and bottom wall
    plot([0.5 C+0.5 C+0.5], [0.5, 0.5, R+0.5], 'k');
    axis ([0.5  C+0.5 0.5 R+0.5]);
    axis ij;   % plot with (1,1) at top-left
    hold on;

    
    temp = ones(R,C,3);
    for r = 1:R
        for c = 1:C
            if ~any(maze(r,c,:))     % dead spot
                temp(r, c, :) = 0;   % turn to black
            end
        end
    end

    if goal
        temp(goal(1), goal(2), [1 2]) = 0;  % set red/green channels to 0
    end
    if start
        temp(start(1), start(2), [1 3]) = 0; % set red/blue channels to 0
    end

    alpha(0.5);
    image(temp);

    for r = 1:R
        for c = 1:C
            if maze(r,c,1) == 0    % an upward wall
                plot( [c - 0.5, c + 0.5], [r - 0.5, r - 0.5], 'k');
            end
            if maze(r,c,2) == 0    % a leftward wall
                plot( [c - 0.5, c - 0.5], [r - 0.5, r + 0.5], 'k');
            end
        end
    end

    % restore incoming hold state
    if incomingHold
        hold on;
    else
        hold off;
    end

