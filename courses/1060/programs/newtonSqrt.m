function [ root guesses ] = newtonSqrt( n, epsilon )

guesses(1) = [ 1 ];
guess = 1;

while abs( guess*guess - n ) > epsilon

    guess = (guess + n/guess)/2;
    guesses(end+1) = guess;
    
end

root = guess;

end
