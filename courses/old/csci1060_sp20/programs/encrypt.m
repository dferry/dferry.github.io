function encrypt( input_file, output_file, key, mode )
%Implements a random shift cipher
%Arg 1: Input file to encipher or decipher
%Arg 2: Output file to hold results
%Arg 3: The encryption key, can be any positive integer
%Arg 4: The mode: 0 is encrypt, 1 is decrypt

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

%Seed the pseudo-random number generator:
rng(key);

input = fread( inFID, 1 );
while length( input ) > 0
 
    %ASCII characters go between 0 and 127
   offset = randi(128) - 1; %gives random integer between 0 and 127
   
   if mode == 0 %encryption mode
    output = input + offset;
   else %decryption mode
    output = input - offset;
   end
   
   if output > 127
       output = output - 128;
   end
   if output < 0
       output = output + 128;
   end
   
   fprintf( outFID, '%c', output ); 
   input = fread( inFID, 1 ); 
end

fclose( inFID );
fclose( outFID );

end
