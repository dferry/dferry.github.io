% findComponent2.m
% Michael Goldwasser (17 Apr 2009)
% this example uses recursion to explore various directions

function component = findComponent2(A, r, c, animationDelay)
    % Usage:  component = findComponent2(A, r, c, animationDelay)
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

    component = 0 .* A;  % all zeros originally
    component = explore(component, A, r, c, animationDelay);
    
    
    
function component = explore(component, A, r, c, animationDelay)
    % recursive function.
    component(r,c) = 1;  % this is a new discovery
      
    if animationDelay
        visualize(A, component, animationDelay);
    end
    
    % table of directional movements
    delta = [-1  0;    % up one row
        0 -1;    % left one column
        +1  0;    % down one row
        0 +1;    % right one column
        ];

    numRows = size(A,1);
    numCols = size(A,2);
    for option = 1:length(delta)
        newR = r + delta(option,1);
        newC = c + delta(option,2);
        if newR >= 1 && newR <= numRows && newC >= 1 && newC <= numCols && ...
                A(newR,newC) == A(r,c) && ~component(newR,newC)
            component = explore(component, A, newR, newC, animationDelay);
        end
    end


 
   
function visualize(A,component, animationDelay)
    hold off;
    colormap(gray);
    imagesc(A);
    axis equal;
    axis tight;
    alpha(0.5);
    temp = component;
    temp(:,:,2) = 0;
    temp(:,:,3) = 0;
    hold on;
    image(temp);
    alpha(0.5);
    pause(animationDelay);
