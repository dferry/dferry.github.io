%This program demonstrates how to recognize a mouse click and hold action.

%If you click and hold the mouse on a grey block, it will start coloring
% the blocks black as long as you hold the mouse button. If you click and
% hold the mouse on a black block, it will start coloring blocks grey as
% long as you hold the mouse down. 

clear;
clc;

%If a variable or array is used inside the handler function, it needs to
% be declared as a global variable.
global grid mouseDown gridRows gridColumns

%Configuration data
gridRows = 20;
gridColumns = 20;

%Locations with a value of 1 will be drawn as grey while locations with a
%value of 2 will be drawn as black. 
grid = ones(gridRows, gridColumns);
mouseDown = 0;


%Create a new figure
figure;
hold on;
%Set the color map for the figure, we have the following colors:
colormap([0.8 0.8 0.8; 0 0 0])  

%We register the button callback to the image rather than the figure, so
% this only responds when we click on the plot area rather than the figure
% area outside of the plot. 
image(grid, 'ButtonDownFcn',@clickHandler)

%This function draws the world. We call it every time the grid is updated.
% This gets significantly more complicated when handling mouse motion
% instead of just mouse clicks.
function drawGrid()
    global grid
    %We have to re-register the click handler every time we redraw the
    % image.
    image(grid, 'ButtonDownFcn',@clickHandler);
    % Here gca refers to the image() we just drew above
    fig = gcf;
    set( fig,'WindowButtonMotionFcn',@motionCallback);
    set( fig,'WindowButtonUpFcn', @mouseReleased);

end


%This function is called when a user presses a key down.
function clickHandler(fig, event)
    global grid setValue mouseDown

    mouseDown = 1;

    point = get( gca, 'CurrentPoint');
    col = round(point(1,1));
    row = round(point(1,2));

    %Swap the grid value between 1 and 2.
    % The setValue variable is used by the click-drag handler to know
    % what color it is making the grid. 
    if grid(row, col) == 1
        grid(row, col) = 2;
        setValue = 2;
    else
        grid(row, col) = 1;
        setValue = 1;
    end

    %Redraw the grid
    drawGrid()
end

%This callback function ALWAYS fires when we move the mouse over the 
% figure, regardless of whether we have clicked or not. Thus, we need
% to combine this with a mousedown and mouseup handler to detect if the
% user is currently holding down the mouse button.
function  motionCallback(source, event)
global grid setValue mouseDown gridRows gridColumns

point = get( gca, 'CurrentPoint');
clc;
row = round(point(1,2))
col = round(point(1,1))
mouseDown

if mouseDown && (row >= 1) && (row <= gridRows) && (col >= 1) && (col <= gridColumns)
    grid(row,col) = setValue;
end

drawGrid();
end

%These handlers manage the state of whether or not the user is currently
% holding down the mouse button.
function mouseReleased( src, event )
    global mouseDown
    mouseDown = 0;
end
