function pi = approxPiVectorized(N)
    % approximate pi using N terms of the Taylor series 4(1/1 - 1/3 + 1/5 - ...)
    alternate = ones(1,N);
    alternate(2:2:end) = -1;
    terms = 4 .* alternate .* (1 ./ (2 .* (1:N) - 1));
    pi = sum(terms);
