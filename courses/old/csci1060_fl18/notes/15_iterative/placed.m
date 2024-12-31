function [soln numIterations] = placed(goal, start, p, animate, error)
% Computes histogram of bets placed for gambler's problem.
% USAGE:  [soln iterations] = placed(goal, p, animate, error)
% Input arguments:
%    goal is the amount at which the gambler wins
%    start is the starting bankroll
%    p is the probability of winning an individual bet
%    animate an integer designating the number of successive iterations
%       between plots. For example 10 would plot every tenth iteration.
%       If 0, no animation (default: 0)
%    error is the acceptable error tolerance (default: 1e-10)
%
% Output arguments:
%    soln will be vector with expected number of bets placed with each
%       intermediate bankroll from 0 to goal.  Note well that as a vector,
%       soln(k) represents the result for bankroll k-1, since
%       soln(1) starts with bankroll 0
%    numIterations is the number of iterations computed
    if nargin < 5
        error = 1e-10;
        if nargin < 4
            animate = 0;
        end
    end
    if animate > 0
        global animateFreq
        animateFreq = animate;
        hook = @placedPlot;
    else
        hook = false;
    end

    initial = zeros(1, goal+1);
    initial(start) = 1;
    [soln numIterations] = iterativeSolver(initial, @placedUpdate, [p start], hook, error);
    
function new = placedUpdate(old, params)
    p = params(1);
    start = params(2);
    new = zeros(1, length(old));
    new(1) = 0;                      % never places a bet with bankroll 0
    new(end) = 0;                    % never places a bet with bankroll goal
    for k = 2:(length(new)-1)
        new(k) = p * old(k-1) + (1-p) * old(k+1); % must have recently won from index-1
    end                                           % or lost from index+1
    new(start) = new(start)+1;                    % initial bankroll gets one extra

function placedPlot(state, iteration, params)
    global animateFreq
    if mod(iteration, animateFreq)==0
        plot(0:(length(state)-1), state);
        grid on;
        title(sprintf('Approximation for Gambler''s Problem with goal=%d, start=%d, p=%.3f (iteration %d)', ...
                      length(state)-1, params(2), params(1), iteration));
        ylabel('Expected number of bets placed');
        xlabel('Intermediate bankroll');
        pause(.001);
    end
