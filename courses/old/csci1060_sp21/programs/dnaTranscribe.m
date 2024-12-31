function [] = dnaTranscribe( inputFile, outputFile )
% This function transcribes a DNA sequence to an RNA
% sequence. Input characters in the input
% file are transcribed in the output file, according to
% the following:
% A => U
% U => A
% T => A
% C => G
% G => C

[inputFD message] = fopen( inputFile, 'r' );
if inputFD == -1
    fprintf('Could not open input file: %s\n', message );
    return;
end
[outputFD message] = fopen( outputFile, 'w' );
if outputFD == -1
    fprintf('Could not open output file: %s\n', message );
    return;
end


data = fread( inputFD, 1 );
while ~isempty( data )

    %Step 1: Transcribe character
    if data == 'A'
        output = 'U';
    elseif data == 'T'
        output = 'A';
    elseif data == 'C'
        output = 'G';
    elseif data == 'G'
        output = 'C';
    else
        output = data;
    end
    
    %Step 2: Write character to output file
    fwrite( outputFD, output );
    %fprintf(outputFD, '%c', output);
    
    %Step 3: Read the next character from input
    data = fread( inputFD, 1 );
end

fclose( inputFD );
fclose( outputFD );

end
