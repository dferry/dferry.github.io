function [] = addLineNumbers( filename )

[ fid, message ] = fopen( filename, 'r' );
if fid == -1 
    disp([ 'Cannot open input file: ' message ]);
    return;
end

outputFile = [ 'with_numbers_' filename ];

[ fid2, message ] = fopen( outputFile, 'w' );
if fid == -1 
    disp([ 'Cannot open output file: ' message ]);
    return;
end

counter = 1;
line = fgets( fid ); %Use fgets and not fgetl here, as we want the
                     %newline character to stay

while line ~= -1
    %Print the counter followed by a space and then the original line
    fprintf( fid2, '%d %s', counter, line );
    counter = counter + 1;
    
    line = fgets( fid ); %Get next line
end

fclose(fid);
fclose(fid2);

end
