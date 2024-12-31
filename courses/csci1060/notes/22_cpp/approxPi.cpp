/**
 * approximate pi using N terms of the Taylor series 4(1/1 - 1/3 + 1/5 - ...)
 */ 
double approxPi(int N) {                        // Must declare return type and parameter type
    double total = 0;                           // Must declare variable type
    for (int k = 1;  k <= N; k++) {             // C++ for loop
        double term = 1.0 / (2 * k - 1);        // Must force floating point arithmetic
        if (k % 2 == 1)                         // The % operator is modulus
	  total += term;                        // += operator is shorthand
        else
	  total -= term;                        // -= operator for subtraction
    }                                           // Note use of {  } for demarking compound loop body
    return 4 * total;                           // Note use of 'return' keyword
}
