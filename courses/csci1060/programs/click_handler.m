%This program demonstrates a click handler to detect clicks on a MATLAB
% figure.

clear;
clc;

%Configuration data
gridRows = 7;
gridColumns = 7;

%If a variable or array is used inside the handler function, it needs to
% be declared as a global variable.
global grid;

%Locations with a value of 1 will be drawn as grey while locations with a
%value of 2 will be drawn as black. 
grid = ones(gridRows, gridColumns);


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
function drawGrid()
    global grid;
    %We have to re-register the click handler every time we redraw the
    % image.
    image(grid, 'ButtonDownFcn',@clickHandler);
end

%This function is called when a user presses a key down.
function clickHandler(fig, event)

    %Global variables have to be declared as global inside the callback
    %function as well. 
    global grid;

    %Point gives us the coordinates of the button click on the x-y axes.
    % Watch the console for these values to update when you click. 
    point = get( gca, 'CurrentPoint');
    clc;

    xPoint = point(1,1)
    yPoint = point(1,2)

    %Round these x-y points to the nearest integer
    col = round(xPoint)
    row = round(yPoint)

    %Swap the grid value between 1 and 2
    if grid(row, col) == 1
        grid(row, col) = 2;
    else
        grid(row, col) = 1;
    end

    %Redraw the grid
    drawGrid()
end
