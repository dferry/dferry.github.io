function x = plotMySqrt(n)
  [x guesses] = mySqrt(n);
  plot(guesses,'ro');
  hold on;
  plot([1 length(guesses)], [sqrt(n) sqrt(n)]);
  hold off;
