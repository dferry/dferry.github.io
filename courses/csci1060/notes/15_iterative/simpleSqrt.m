function x = simpleSqrt(n)
%    Compute the square root of n.
%    USAGE:  simpleSqrt(n)
    guess = 1;
    x = simpleIterative(guess, @newtonUpdate, n);

function val = newtonUpdate(x, n)
    val = (x + n/x) / 2;
