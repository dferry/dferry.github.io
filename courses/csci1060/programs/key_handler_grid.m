%This program demonstrates combining a keypress handler with a drawing
% function to make a block move around a grid.

%You can use the arrow keys or WASD in order to move the block around the
% grid.

%WARNING: This code has problems if your block moves "off" the grid. You
% need to figure out what the correct behavior is in this case!

clear;
clc;

%Configuration data
gridRows = 7;
gridColumns = 7;
startRow = 4;
startCol = 4;

%If a variable or array is used inside the handler function, it needs to
% be declared as a global variable.
global grid blockRow blockCol;

%The grid has ones everywhere except where our block is. This causes the
% image(grid) function to 
grid = ones(gridRows, gridColumns);
blockRow = startRow;
blockCol = startCol;
grid(startRow,startCol) = 2;

%Create a new figure
fig = figure;
%Set the key press handler 
set(fig, 'KeyPressFcn', @keypressHandler)

%Make sure that we don't replace the figure when we call image()
hold on;

%Color values for grid value 1 and 2, with 1 being light grey and 2 being
% black. See homework 6 for another example of defining more colors in our
% grid.
colormap([0.8 0.8 0.8; 0 0 0])  
image(grid)


%This function draws the world. We call it every time the grid is updated.
function drawGrid()
    global grid;
    image(grid);
end

%This function is called when a user presses a key down.
function keypressHandler(fig, event)

    %Global variables have to be declared as global inside the callback
    %function as well. 
    global grid blockRow blockCol;

    disp(['You pressed: ', event.Key]);

    %Set the block position to 1 in anticipation of a change
    grid(blockRow, blockCol) = 1;

    %We need to give code for each individual key we want to handle.
    % Since two different keys have the same action, such uparrow and W, it
    % might make more sense to define a MoveUp() function and call that in
    % both places instead of replicating code.
    switch event.Key
        case 'downarrow'        
            blockRow = blockRow - 1
        case 'uparrow'
            blockRow = blockRow + 1
        case 'leftarrow'
            blockCol = blockCol - 1
        case 'rightarrow'
            blockCol = blockCol + 1
        case 'w'        
            blockRow = blockRow + 1
        case 'a'
            blockCol = blockCol - 1
        case 's'
            blockRow = blockRow - 1
        case 'd'
            blockCol = blockCol + 1
    end

    %Set the new value of grid to 2 based on new value
    grid(blockRow, blockCol) = 2;

    %Redraw the grid
    drawGrid()
end
