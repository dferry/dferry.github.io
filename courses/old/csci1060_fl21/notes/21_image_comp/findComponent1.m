% findComponent.m
% Michael Goldwasser (17 Apr 2009)

function component = findComponent1(A, r, c, animationDelay)
    % Usage:  component = findComponent1(A, r, c, animationDelay)
    %
    % Determines all positions of A that have same value as A(r,c)
    % and are connect to (r,c) using only horizontal or vertical
    % movements throuugh other positions with value equal to A(r,c).
    %
    % A is an array of values.
    % r is the index of the reference row
    % c is the index of the reference column
    %
    % animateDelay, if given, designates that animation
    %    of each step should be given with specified pause
    if nargin == 3
        animationDelay = 0;
    end

    % table of directional movements
    delta = [-1  0;    % up one row
              0 -1;    % left one column
             +1  0;    % down one row
              0 +1;    % right one column
             ];

    numRows = size(A,1);
    numCols = size(A,2);
    component = zeros(numRows, numCols);
    component(r,c) = 1;
    fringe = [r;c];                  % our starting point
   
    while ~isempty(fringe)
        % consider LAST entry of fringe
        r = fringe(1,end);
        c = fringe(2,end);
        
        % add ONE unvisited neighbor to the fringe (if any)
        dir = 0;       % actual direction chosen
        option = 1;    % possible direction to consider
        while dir == 0 && option <= length(delta)
            newR = r + delta(option,1);
            newC = c + delta(option,2);
            if newR >= 1 && newR <= numRows && newC >= 1 && newC <= numCols && ...
                      A(newR,newC) == A(r,c) && ~component(newR,newC)
                dir = option;
            else
                option = option + 1;
            end
        end
        
        if dir > 0
            % add neighbor to our fringe
            fringe = [fringe [newR;newC] ];
            component(newR,newC) = 1;
        else 
            % last entry is a dead end
            fringe(:, end) = [];
        end
 
        if animationDelay
            visualize(A, component, animationDelay, fringe);
        end
    end
    visualize(A, component, animationDelay, fringe);
    
   
    function visualize(A,component, animationDelay, fringe)
        hold off;
        colormap(gray);
        imagesc(A);
        axis equal;
        axis tight;
        alpha(0.5);
        temp = component;
        temp(:,:,2) = 0;
        temp(:,:,3) = 0;
        for f = fringe
            temp(f(1),f(2),1:2) = 1;   % fringe is yellow
        end
        hold on;
        image(temp);
        alpha(0.5);
        pause(animationDelay);
