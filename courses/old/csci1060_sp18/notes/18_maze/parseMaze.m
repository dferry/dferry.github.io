function maze = parseMaze(filename)
    % Usage: maze = parseMaze(filename)
    %
    % Takes a file that describes a maze based
    % on two separate R x C tables, with the first
    % marking all legal upward movements with 1's
    % and the second marking possible leftward moves.
    %
    % Produces an R x C x 4 array for
    %   a maze with R rows and C columns, where
    %   the third dimension represents a direction
    %   of motion (1=up, 2=left, 3=down, 4=right)
    %   Entry maze(r,c,dir) is 1 if that motion is legal
    %     when at position (r,c), and 0 otherwise.
    raw = load(filename);
    [rawR rawC] = size(raw);
    R = rawR / 2;
    C = rawC;
    maze = zeros(R, C, 4);
    
    % upward
    maze(:, :, 1) = raw(1:R, :);           % verbatim from first half of raw version

    % leftward
    maze(:, :, 2) = raw(1+R:2*R, :);       % verbatim from second half of raw version
  
    % downward
    maze(1:R-1, :, 3) = maze(2:R, :, 1);   % can you move up from below?
    
  
    % rightward
    maze(:, 1:C-1, 4) = maze(:, 2:C, 2);   % can you move left from the right?
    
