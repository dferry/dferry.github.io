function caesar_cipher( input_file, output_file, key )
%Implements a caesar cipher, all lowercase are converted to
% uppercase, all punctuation, spaces, and non-alphabet characters
% are ignored.
%Arg 1: Input file to encipher or decipher
%Arg 2: Output file to hold results, all lowercase are converted
%       to uppercase
%Arg 3: The encryption key shift, between  +25 and -25

%Encryption in three steps:
% Step 1: Read in input data
% Step 2: Compute encrypted form of input data
% Step 3: Write out ouput data

%Open the input file
[ inFID, message ] = fopen( input_file, 'r' );
if inFID == -1
   fprintf( 2, 'Error, could not open input file: %s\n', message );
   return;
end

%Open the output file
[ outFID, message ] = fopen( output_file, 'w' );
if outFID == -1
   fprintf( 2, 'Error, could not open output file: %s\n', message );
   fclose( inFID );
   return;
end

input = fread( inFID, 1 );
while length( input ) > 0
    input = upper(char(input));
    
    %How do we compute output from input?
    if input >= 'A' && input <= 'Z'
    output = input + key;
    if output < 'A'
       output = output + 26;
    end
    if output > 'Z'
        output = output - 26;
    end
    else %If input is not in the range A..Z
        output = input;
    end
    
   fprintf( outFID, '%c', output ); 
   input = fread( inFID, 1 ); 
end

fclose( inFID );
fclose( outFID );

end
