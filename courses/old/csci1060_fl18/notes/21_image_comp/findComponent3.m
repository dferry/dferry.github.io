% findComponent.m
% Michael Goldwasser (17 Apr 2009)

function component = findComponent3(A, r, c, animationDelay)
    % Usage:  component = findComponent3(A, r, c, animationDelay)
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
        % remove LAST entry of fringe and add to component
        r = fringe(1,end);
        c = fringe(2,end);
        fringe(:,end) = [];  
        
        % add ALL unvisited neighbors to the fringe
        for dir = 1:length(delta)
            newR = r + delta(dir,1);
            newC = c + delta(dir,2);
            if newR >= 1 && newR <= numRows && newC >= 1 && newC <= numCols && ...
                      A(newR,newC) == A(r,c) && ~component(newR,newC)
                fringe = [fringe [newR;newC] ];
                component(newR,newC) = 1;
            end
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
