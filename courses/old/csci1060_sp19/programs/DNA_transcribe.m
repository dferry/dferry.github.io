%David and class
%March 22, 2019
%DNA transcription function

%This function takes a file composed of DNA bases,
% AGCT, and outputs the transcribed RNA version,
% composed of RNA bases, in other words, the mapping:
% A -> T
% T -> U
% G -> C
% C -> G
% is used to transform the inputFile to the outputFile
% inputFile and outputFile are strings that name a file
function [] = DNA_transcribe( inputFile, outputFile )

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
        
        if input == 'A'
            output = 'T';
        elseif input == 'T'
            output = 'U';
        elseif input == 'G'
            output = 'C';
        elseif input == 'C'
            output = 'G';
        else
            output = input;
        end
        
        fprintf( outFile, '%s', output );
    end

    fprintf( outFile, '\n');

    fclose( inFile );
    fclose( outFile);
end


