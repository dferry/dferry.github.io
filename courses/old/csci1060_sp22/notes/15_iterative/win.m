function [soln numIterations] = win(goal, p, animate, error)
% Computes the winning percentage for the gambler's problem.
% USAGE:  [soln iterations] = win(goal, p, animate, error)
% Input arguments:
%    goal is the amount at which the gambler wins
%    p is the probability of winning an individual bet
%    animate an integer designating the number of successive iterations
%       between plots. For example 10 would plot every tenth iteration.
%       If 0, no animation (default: 0)
%    error is the acceptable error tolerance (default: 1e-10)
%
% Output arguments:
%    soln will be vector with win percentage for each
%       bankroll from 0 to goal.  Note well that as a vector,
%       soln(k) represents winning percentage for bankroll k-1,
%       since soln(1) represents bankroll 0
%    numIterations is the number of iterations computed
    if nargin < 4
        error = 1e-10;
        if nargin < 3
            animate = 0;
        end
    end
    if animate > 0
        global animateFreq
        animateFreq = animate;
        hook = @winPlot;
    else
        hook = false;
    end
    % guess linear for initial state
    initial = linspace(0, 1, goal+1);      
    [soln numIterations] = iterativeSolver(initial, @winUpdate, p, hook, error);
    
function new = winUpdate(old, p)
    new = zeros(1, length(old));
    new(1) = 0;                    % gambler loses with bankroll 0
    new(end) = 1;                  % gambler wins with bankroll goal
    for k = 2:(length(new)-1)
        new(k) = (1-p) * old(k-1) + p * old(k+1);
    end

function winPlot(state, iteration, p)
    global animateFreq
    if mod(iteration, animateFreq)==0
        plot(0:(length(state)-1), state);
        grid on;
        title(sprintf('Approximation to Gambler''s Problem with goal=%d, p=%.3f (iteration %d)', ...
                      length(state)-1, p, iteration));
        ylabel('Chance of win');
        xlabel('Initial bankroll');
        pause(.001);
    end
