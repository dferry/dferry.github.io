%This script transcribes a DNA sequence to its corresponding RNA
%Sequence

%March 23, 2018
%David and class

inputFile = 'DNA.txt';
outputFile = 'RNA.txt';

[ inFile, result ] = fopen( inputFile, 'r' );
if inFile == -1
    fprintf('Error: Could not open input file. Reason: %s\n', result);
    return;
end

[ outFile, result ] = fopen( outputFile, 'w+' );
if outFile == -1
    fprintf('Error: Could not open output file. Reason: %s\n', result);
    return;
end


%Start transcription
while true
   
    [ base, count ] = fread( inFile, 1 );
    if count == 0
        break;
    end
    
    if base == 'C'
        output = 'G';
    elseif base == 'G'
        output = 'C';
    elseif base == 'T'
        output = 'A';
    elseif base == 'A'
        output = 'U';
    else
        output = base; 
        %output = '_';
    end
    
    fwrite(outFile, output);
    
end

fclose(inFile);
fclose(outFile);


