function x = newSqrt(n, animate)
%    Compute the square root of n.
%    USAGE:  newSqrt(n, animate)
%    n is the value whose square root we want.
%    animate is an integer designating the number of successive iterations
%       between plots. For example 10 would plot every tenth iteration.
%       If 0, no animation (default: 0)
    if nargin < 2
        animate = 0;
    end
    if animate > 0
        global animateFreq
        animateFreq = animate;
        hook = @newtonPlot;
        initializePlot(n);
    else
        hook = false;
    end

    x = iterativeSolver(1, @newtonUpdate, n, hook);


function val = newtonUpdate(x, n)
    val = (x + n/x) / 2;


function initializePlot(n)
    plot([0 1e10], [sqrt(n) sqrt(n)]);
    title(sprintf('Computing sqrt(%f) with Newton''s method',n));
    ylabel(sprintf('approximation',n));
    xlabel('Iteration');

function newtonPlot(x, iteration, n)
    hold on;
    plot(iteration, x, 'ro');
    curAxis = axis;
    axis([0 iteration curAxis(3) curAxis(4)]);
    pause(.001);
    hold off;
    
