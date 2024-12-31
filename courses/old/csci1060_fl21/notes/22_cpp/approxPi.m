function pi = approxPi(N)
    % approximate pi using N terms of the Taylor series 4(1/1 - 1/3 + 1/5 - ...)
    total = 0;
    for k = 1:N
        term = 1 / (2 * k - 1);
        if mod(k,2) == 1
            total = total + term;
        else
            total = total - term;
        end
    end
    pi = 4 * total;
