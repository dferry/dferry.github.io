function [root guesses] = directedRandSqrt( n, epsilon )

guess = 1;
guesses = [ guess ];

lower = 0;
upper = n;

while abs(guess*guess - n) > epsilon
    %Check if the guess is a lower or upper bound
    if guess*guess < n 
        lower = guess;
    else %guess*guess >= n
        upper = guess;
    end
    
    %Make a new guess
    range = upper - lower;
    guess = rand()*range + lower;
    guesses = [guesses guess];
end

root = guess;

end
