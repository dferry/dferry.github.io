%This function finds a square root by randomly guessing
% values between 0 and the input N

function [ root guesses ] = directedRandSqrt( n, epsilon )

root = 1;
guesses = [];
index = 1;
low = 0;
high = n;

while abs(root*root - n) > epsilon
    
    if (root*root < n) && (root > low)
        low = root;
    end
    if (root*root > n) && (root < high)
        high = root;
    end
    
    range = high - low;
    guess = rand()*range + low; %Picks a number between low and high
    root = guess;
    
    guesses( index ) = root;
    index = index + 1;
end

plot(guesses)
hold on
plot( [0 length(guesses)], [ sqrt(n) sqrt(n) ], '-r' );
hold off;


end