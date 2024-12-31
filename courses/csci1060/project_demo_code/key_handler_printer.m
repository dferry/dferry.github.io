%This program demonstrates how to do keypress handling in MATLAB. This
% allows your program to react to inputs such as arrow keys or WASD
% keys while a script is running.
%
%We need to define a "callback function" that tells MATLAB what to do when
% the user presses a key and then "register" that callback with our
% script. These functions are also sometimes called "event handlers" and
% this style of programming is called event handling.
%
%This program just prints the name of the key that is pressed. 
%
%Note that there is a difference between key presses and characters.
% In particular, we can detect key presses from keys that don't print, such
% as the arrow keys, backspace, f4, etc. It also means that MATLAB can't
% directly detect a capital letter, because if you press SHIFT+A you'll get
% the shift keypress and the A keypress as separate events.
%
%Event handlers can only be used with a MATLAB figure that has focus.
% When you press a key you will see the output in the MATLAB console. If
% you don't see any output, then find the blank figure and click it with
% your mouse to give focus to that figure.

clear;
clc;

%Create a new figure
fig = figure;
%Set the key press handler 
set(fig, 'KeyPressFcn', @keypressHandler)


%This function is the callback function that gets called whenever a user
% presses a button. It prints the name of the key that is pressed.
function keypressHandler(fig, event)
    disp(['You pressed: ', event.Key]);
end