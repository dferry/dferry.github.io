function [] = ceasarCipher( inputFile, outputFile, key )
% David and class
% April 5th, 2021
% This function implements a Ceasar Cipher.
% input: inputFile - the file to be encrypted or decrypted
% input: outputFile - where the result of the operations are stored
% input: key - the encryption offset- note that specifying a postiive
%              offset can be considered encryption, while specifying the
%              opposite offset can be considered decryption

[ inFD message ] = fopen( inputFile, 'r' );
if inFD == -1
    fprintf('Error: Could not open input file: %s\n', message );
    return
end
[ outFD message ] = fopen( outputFile, 'w' );
if outFD == -1
    fprintf('Error: Could not open output file: %s\n', message );
    return
end

input = fread( inFD, 1 ); 
while ~isempty( input )
    
    %1) Shift input data according to key
    output = input + key;
    
    if input < 97 || input > 122
        output = input;
    elseif output > 122
        output = output - 26; %Handles wrapping around above 'z'
    elseif output < 97
        output = output + 26; %Handles wrapping around below 'a'
    end
        
    %2) Write shifted data to output
    fwrite( outFD, output );
    
    %3) Read another character from the input file
    input = fread( inFD, 1 );
    
end

fclose( inFD );
fclose( outFD );

end
