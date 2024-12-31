function [root guesses] = randSqrt( n, epsilon )

guess = 1;
guesses = [ guess ];

%Semantically, we're saying "guess*guess == n"
while abs(guess*guess - n) > epsilon
    guess = rand() * n;
    guesses = [guesses guess];
end

root = guess;

end
