function [soln numIterations] = iterativeSolver(initial, updateFunc, params, callback, error, limit)
% General solver using successive approximations.
% USAGE:  [soln numIterations] = iterativeSolver(initial, updateFunc, params, callback, error, limit)
% Input arguments:
%    initial is an initial guess at the solution.  It can be a
%       scalar, vector or array.
%    updateFunc is a handle to a function that can be used to
%       provide an updated approximation based on an existing one.
%       It will be called with syntax oracle(existing, params)
%    params is auxillary information to be sent to updateFunc
%    callback can be function handle that is called once per iteration
%       It will be called with syntax callback(approx, iterationNum, params)
%       (default: no callback)
%    error is the acceptable error tolerance (default: 1e-10)
%    limit is an absolute bound on number of iteration (default: inf)
%
% Output arguments:
%    soln will be the final approximation
%    numIterations is the number of iterations computed
    if nargin < 6
        limit = inf;
        if nargin < 5
            error = 1e-10;
        end
    end
    doCallback = (nargin >= 4 && isa(callback, 'function_handle'));
    
    soln = initial;
    numIterations = 0;
    solved = false;
    while numIterations <= limit && ~solved
        prev = soln;
        soln = updateFunc(prev, params);
        solved = all(abs(soln-prev) <= error);
        numIterations = numIterations + 1;
        if doCallback
            callback(soln, numIterations, params);
        end
    end
