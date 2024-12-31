%This function finds a square root by randomly guessing
% values between 0 and the input N

function [ root guesses ] = newtonSqrt( n, epsilon )

root = 1;
guesses(1) = 1;
guess = 1;

while abs(root*root - n) > epsilon
    guess = (guess + n/guess)/2;
    root = guess;
    
    guesses( end + 1 ) = root;
end

plot(guesses)
hold on
plot( [0 length(guesses)], [ sqrt(n) sqrt(n) ], '-r' );
hold off;

end