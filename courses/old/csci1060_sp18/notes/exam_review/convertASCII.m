%Converts a text file to a sequence of ascii characters.
%Input: name of file to convert
%Output: Produces a file containing converted text

function [] = convertASCII( filename )

[ fid, message ] = fopen( filename, 'r' );
if fid == -1 
    disp([ 'Cannot open file: ' message ]);
    return;
end

text = fread(fid);

asciiText = uint8(text);

disp(asciiText);

fid2 = fopen(['ascii_' filename], 'w');

for i = 1:length(asciiText)
    fprintf(fid2, '%d ', asciiText(i) );
end
    
fclose(fid);
fclose(fid2);

end
