function maze = mazeFromObstacles(raw)
    % Usage: maze = mazeFromObstacles(raw)
    %
    % raw is an R x C table, with a 1 being an obstacle.
    %
    % Produces an R x C x 4 array for
    %   a maze with R rows and C columns, where
    %   the third dimension represents a direction
    %   of motion (1=up, 2=left, 3=right, 4=right)
    %   Entry maze(r,c,dir) is 1 if that motion is legal
    %     when at position (r,c), and 0 otherwise.
    [R C] = size(raw);
    for dim = 1:4
        maze(:, :, dim) = ~raw;
    end
    
    % upward
    maze(2:R, :, 1) = maze(2:R, :, 1) & ~raw(1:(R-1), :);
    maze(1, :, 1) = zeros(1,C);

    % leftward
    maze(:, 2:C, 2) = maze(:, 2:C, 2) & ~raw(:, 1:(C-1));
    maze(:, 1, 2) = zeros(1,R);
    
    % downward
    maze(1:(R-1), :, 3) = maze(1:(R-1), :, 3) & ~raw(2:R, :);
    maze(R, :, 3) = zeros(1,C);
    
    % rightward
    maze(:, 1:(C-1), 4) = maze(:, 1:(C-1), 4) & ~raw(:, 2:C);
    maze(:, C, 4) = zeros(1,R);
    
