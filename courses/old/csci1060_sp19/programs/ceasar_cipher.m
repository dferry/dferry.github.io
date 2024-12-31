%This function implements a ceasear cipher
function [] = ceasar_cipher( inputFile, outputFile, offset )

    [ inFile, msg ] = fopen( inputFile, 'r' );
    if inFile == -1
        fprintf( 2, 'Could not open input file, reason: %s\n', msg);
        return;
    end
    
    [ outFile, msg ] = fopen( outputFile, 'w' );
    if outFile == -1
        fprintf( 2, 'Could not open output file, reason: %s\n', msg);
        return;
    end
    
    while 1
        
        [ input, count ] = fread( inFile, 1 );
        
        if count == 0
            break;
        end
        
        input = toLowercase( input );
        
        if input >= 97 && input <= 122
            %Peform the encryption input->output
            output = input + offset;
            
            %Have we walked off the end of the alphabet?
            if output > 122
                %If so, wrap around
                output = output - 26;
            end
        else
            output = input;
        end
        
        fprintf( outFile, '%s', output );
    end

    fprintf( outFile, '\n');

    fclose( inFile );
    fclose( outFile);

end


%This function returns the lowercase equivalent of an
% uppercase letter, or it returns the input for any
% other character.
function output = toLowercase( input )

if input < 65 || input > 90
    %Lowercase or other character case
    output = input;
else
    %Uppercase case
    output = input + 32;
end
    
end
