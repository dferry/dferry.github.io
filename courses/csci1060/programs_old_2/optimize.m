%Optimziation
%David and Class
%March 6, 2019

X = linspace( -5, 6, 100000 );
Y = -X.*(X-3).*(X+5).*(X-2).*(X+3).*(X-6);
%Derivative:
% -6*x^5 + 15*x^4 + 148*x^3-261*x^2-504*x+540

f = @(X) -X.*(X-3).*(X+5).*(X-2).*(X+3).*(X-6);
derivative = @(x) -6.*x.^5 + 15.*x.^4 + 148.*x.^3-261.*x.^2-504.*x+540;

plot( X, Y )
axis( [-7 7 -1250 2750] )

%%

[ trueMax index ] = max(Y);
trueLocation = X(index);

%%
N = 10
maxY = -Inf;
minX = -5;
maxX = 6;
range = maxX - minX;
for index = 1:N
    x = rand()*range+minX;
    y = -x*(x-3)*(x+5)*(x-2)*(x+3)*(x-6);
    if y > maxY
        maxY = y;
        maxLocation = x;
    end
    
    plot(x, y, 'ro')
    hold on;
end

plot( X, Y )
axis( [-7 7 -1250 2750] )

plot( maxLocation, maxY, 'go')
hold off;

maxY
maxLocation

%%

%f = @(X) -X.*(X-3).*(X+5).*(X-2).*(X+3).*(X-6);
%derivative = @(x) -6.*x.^5 + 15.*x.^4 + 148.*x.^3-261.*x.^2-504.*x+540;

f = @(X) (X-2).^2 .* -(X+2).^2;
derivative = @(X) -4*X^3 + 16*X;

X = linspace( -5, 6, 100000 );
Y = f(X);
%Derivative:
% -6*x^5 + 15*x^4 + 148*x^3-261*x^2-504*x+540

plot( X, Y )
hold on;
axis( [-5 5 -20 10] )

guess = -0.25;
lastGuess = 1;
guesses(1) = guess;
epsilon = 0.001;

plot( guess, f(guess), 'ro');

while abs( guess - lastGuess ) > epsilon
    
    lastGuess = guess;
    guess = guess - f(guess)/derivative(guess);
    
    guesses( end + 1 ) = guess;
    plot( guess, f(guess), 'ro' );
    
    pause(1)
    
end

hold off;
optimum = guess;
