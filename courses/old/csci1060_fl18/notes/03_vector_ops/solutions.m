
N = 10;                       % for use in later series
format short g;               % controls display of precision


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercise i)
% We use a basic colon range
exercise_i = 100:100:1500;
exercise_i                    % display to screen




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercise ii)
% We use vector concatenation to compose the result
exercise_ii = [ 1:20 19:-1:1];
exercise_ii                   % display to screen





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercise iii)
% One approach is to use colon slice to set half the values
exercise_iii = ones(1,N);     % all ones initially
exercise_iii(2:2:N) = -1;     % then reset every other element
exercise_iii                  % display to screen





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercise iv)
exercise_iv = 2 .^ (0:N-1);        % note carefully the operator precedence
exercise_iv




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercise v)
exercise_v = 1 ./ 2 .^ (0:N-1);   % note carefully the operator precedence
exercise_v





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercise vi)
exercise_vi = cumsum(exercise_v);
exercise_vi





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercise vii)
% We're cheating a bit by using a for loop to get the repetion
% We will talk more about for loops sometime soon.
N = 20;
approxE = cumsum(1 ./ factorial(0:N-1));
exercise_vii = approxE - exp(1);
exercise_vii





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercise viii)
% We're cheating a bit by using a for loop to get the repetion
% We will talk more about for loops sometime soon.
N = 100000;
terms = 1:N;
approx = cumsum(1 ./ ((2 .* terms - 1) .* (2 .* terms)));
errors = approx - log(2);
samples = [10 100 1000 10000 100000];
exercise_viii = [samples; errors(samples)]'






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercise ix)
p = [3 0 -5 2];
x = 10;                          % p(x) = 2952
exponents = length(p)-1:-1:0;    % exponents for this polynomial
exercise_ix = sum(p .* x .^ exponents);
exercise_ix





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercise x)
% We're cheating a bit by using a for loop to get the repetion
% We will talk more about for loops sometime soon.
printf("\n");
for N = [10 100 1000 10000 100000 1000000 10000000]
  data = rand(1,N);
  percentage = sum(data < 0.1) ./ N;
  printf("With N = %8d, observed percentage was %7.4f\n", N, percentage*100);
end
printf("\n");





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exercise xi)
% We're cheating a bit by using a for loop to get the repetion
% We will talk more about for loops sometime soon.
printf("\n");
for N = [10 100 1000 10000 100000 1000000 10000000]
  data = randn(1,N);
  percentage = sum(data >= 1.0) ./ N;
  printf("With N = %8d, observed percentage was %7.4f\n", N, percentage*100);
end
printf("\n");

