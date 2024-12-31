function maze = mazeFromWalls(upward, leftward)
    % Usage: maze = mazeFromWalls(upward, leftward)
    %
    % upward is an R x C table, with a 1 meaning that
    %     it is legal to move upward from that location.
    %     (top row is assumed to be all zeros).
    %
    % leftward is an R x C table, with a 1 meaning that
    %     it is legal to move leftward from that location.
    %     (left column is assumed to be all zeros).
    %
    % Produces an R x C x 4 array for
    %   a maze with R rows and C columns, where
    %   the third dimension represents a direction
    %   of motion (1=up, 2=left, 3=right, 4=right)
    %   Entry maze(r,c,dir) is 1 if that motion is legal
    %     when at position (r,c), and 0 otherwise.
    [R C] = size(upward);
    maze = zeros(R,C,4);
    
    % upward
    maze(:, :, 1) = upward;

    % leftward
    maze(:, :, 2) = leftward;
  
    % downward
    maze(1:R-1, :, 3) = maze(2:R, :, 1);   % can you move up from below
  
    % rightward
    maze(:, 1:C-1, 4) = maze(:, 2:C, 2);   % can you move left from the right?    
