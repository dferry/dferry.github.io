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
fwrite(fid2, asciiText);

fclose(fid);
fclose(fid2);

end