% findComponent.m
% Michael Goldwasser (17 Apr 2009)

function component = findComponent5(A, map, r, c, animationDelay)
    % Usage:  component = findComponent5(A, map, r, c, animationDelay)
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
    if nargin == 4
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
        % remove FIRST entry of fringe and add to component
        r = fringe(1,1);
        c = fringe(2,1);
        fringe(:,1) = [];  
        
        % add ALL unvisited neighbors to the fringe
        for dir = 1:length(delta)
            newR = r + delta(dir,1);
            newC = c + delta(dir,2);
            if newR >= 1 && newR <= numRows && newC >= 1 && newC <= numCols && ...
                      match(A,map,r,c,newR,newC) && ~component(newR,newC)
                fringe = [fringe [newR;newC] ];
                component(newR,newC) = 1;
            end
        end
 
        if animationDelay
            visualize(A, component, animationDelay, fringe);
        end
    end
    visualize(A, component, animationDelay, fringe);
    
    function good = match(A,map,r1,c1,r2,c2)
        % assumes that A uses indices 0 to 255 for map(1:256)
        first = map(1 + A(r1,c1));    % first rgb color
        secod = map(1 + A(r2,c2));    % second rgb color
        good = all(abs(first-second) < 0.07 );
   
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
