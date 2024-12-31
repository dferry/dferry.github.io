%This program is like key_handler_printer except it detects the difference
% between pressing a key down and releasing a key.

clear;
clc;

%Create a new figure
fig = figure;
%Set the key press handler 
set(fig, 'KeyPressFcn', @keypressHandler)
set(fig, 'KeyReleaseFcn', @keyReleaseHandler)


%This function is called when a user presses a key down.
function keypressHandler(fig, event)
    disp(['You pressed: ', event.Key]);
end

%This function is called when a user releases a key.
function keyReleaseHandler(fig, event)
    disp(['You released: ', event.Key]);
end