%File Input/Ouput in MATLAB
% March 21, 2018
%David and Class

%%
% Standard File Descriptors
% 0 = standard input
% 1 = standard output
% 2 = standard error

fprintf( 'This goes to the console by default\n' );

fprintf( 1, 'This specifies that output goes to console\n');

fprintf( 2, 'This generates error text\n');


%%

filename = 'SLU_precip.txt';

fd = fopen( filename );

line = fgets( fd );

disp( line );

%%

outputFilename = 'September_rainfall.txt';

outFile = fopen( outputFilename, 'w+' );

fprintf( outFile, 'This is a test\n');
fprintf( outFile, 'This is a new line\n');
fprintf( outFile, 'This is a third line\n');

%%
% Let's read every line of SLU_precip, and only output those
% lines that correspond to September (month 9)

inputFilename = 'SLU_precip.txt';
inFile = fopen( inputFilename );
outputFilename = 'September_rainfall.txt';
outFile = fopen( outputFilename, 'w+' )

line = fgets( inFile );
while line ~= -1
    asNumbers = str2num( line );

    %The second value in each line is the month ID
    if asNumbers(2) == 9
     fprintf( outFile, line );
    end

    line = fgets( inFile );
end


