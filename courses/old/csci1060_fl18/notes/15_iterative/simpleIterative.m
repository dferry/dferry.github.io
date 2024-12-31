function soln = simpleIterative(initial, updateFunc, params)
% General simple solver using successive approximations.
% USAGE:  soln = simpleIterative(initial, updateFunc, params)
% Input arguments:
%    initial is an initial guess at the solution.  It can be a
%       scalar, vector or array.
%    updateFunc is a handle to a function that can be used to
%       provide an updated approximation based on an existing one.
%       It will be called with syntax oracle(existing, params)
%    params is auxillary information to be sent to updateFunc
    error = 1e-10;
    soln = initial;
    solved = false;
    while ~(solved)
        prev = soln;
        soln = updateFunc(prev, params);
        solved = all(abs(soln-prev) <= error);
    end
