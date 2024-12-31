function [x guess] = mySqrt(n)
   % compute the square of n.
   % USAGE:  [x guess] = mySqrt(n)
   %    x is the resulting sqrt
   %    guess is vector representing the history of guesses leading to x
   guess = [1];
   while abs(guess(end) - n/guess(end)) > .00000000001 && length(guess) < 1000
       guess(1+end) = (guess(end) + n/guess(end))/2;
   end
   x = guess(end);
