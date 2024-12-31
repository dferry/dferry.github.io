function [soln numIterations] = bets(goal, p, animate, error)
% Computes the expected number of bets for gambler's problem.
% USAGE:  [soln iterations] = bets(goal, p, animate, error)
% Input arguments:
%    goal is the amount at which the gambler wins
%    p is the probability of winning an individual bet
%    animate an integer designating the number of successive iterations
%       between plots. For example 10 would plot every tenth iteration.
%       If 0, no animation (default: 0)
%    error is the acceptable error tolerance (default: 1e-10)
%
% Output arguments:
%    soln will be vector with expected number of bets for each
%       initial bankroll from 0 to goal.  Note well that as a vector,
%       soln(k) represents the result for bankroll k-1, since
%       soln(1) starts with bankroll 0
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
        hook = @betsPlot;
    else
        hook = false;
    end
    % guess linear for initial state
    initial = linspace(0, 1, goal+1);      
    [soln numIterations] = iterativeSolver(initial, @betsUpdate, p, hook, error);
    
function new = betsUpdate(old, p)
    new = zeros(1, length(old));
    new(1) = 0;                     % no more betting with bankroll 0
    new(end) = 0;                   % no more betting with bankroll goal
    for k = 2:(length(new)-1)
        new(k) = 1 + (1-p) * old(k-1) + p * old(k+1);  % one bet plus more...
    end

function betsPlot(state, iteration, p)
    global animateFreq
    if mod(iteration, animateFreq)==0
        plot(0:(length(state)-1), state);
        grid on;
        title(sprintf('Approximation for Gambler''s Problem with goal=%d, p=%.3f (iteration %d)', ...
                      length(state)-1, p, iteration));
        ylabel('Expected number of bets');
        xlabel('Initial bankroll');
        pause(.001);
    end
