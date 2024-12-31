function [] = DNA_transcribe( input_file, output_file )
% This function takes a DNA sequence in input_file and
% transcribes it to the corresponding output RNA sequence
% in output_file
% Argument 1: input_file contains the input DNA sequence, this
%             file should contain only the characters AGCT in
%             one unbroken sequence on a single line
% Argument 2: output_file will contain the output RNA sequence,
%             that corresponds to the input DNA sequence where the
%             following substitutions occur:
%               A -> U
%               T -> A
%               G -> C
%               C -> G

%Steps:
%Read in input file
%Convert input characters to output characters
%Write output to output file

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
    
    if input == 'A'
        output = 'U';
    elseif input == 'T'
        output = 'A';
    elseif input == 'G'
        output = 'C';
    elseif input == 'C'
        output = 'G';
    else
        %output = input; %one defensible catchall case: do not translation
        %other defensible thing to do: return an error
        fprintf(2, 'Error, encountered invalid character: "%c"\n', input );
        return;
    end
    
    fprintf( outFID, '%c', output );
    
    input = fread( inFID, 1 );
end

close( inFID );
close( outFID );

end
