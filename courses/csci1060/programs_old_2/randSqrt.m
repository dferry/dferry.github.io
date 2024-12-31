%This function finds a square root by randomly guessing
% values between 0 and the input N

function [ root guesses ] = randSqrt( n, epsilon )

root = 1;
guesses(1) = 0;
index = 1;

while abs(root*root - n) > epsilon
    guess = rand()*n; %Picks random numbers between 0 and n
    root = guess;
    
    guesses( end + 1 ) = root;
end

end