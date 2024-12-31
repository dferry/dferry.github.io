%David and Class
% March 19, 2020
% File input and output

%Rough and easy data input to matlab
filename = 'data.txt';
fid = fopen( filename );
myData = fread( fid );

%%

% Open a data file with checking
filename = 'does_not_have_permission.txt';
[fid, message] = fopen( filename );

if fid == -1
    fprintf(2,'Error, could not open file: %s\n', message );
else
    fprintf('Successfully opened file %d\n', fid );
    myData = fread( fid );
end

%%

%Write to a file

filename = 'output.txt';
[fid, message] = fopen( filename, 'a' );

if fid == -1
    fprintf('Error, could not open file for writing: %s\n', message);
end

x = 70;
y = 80;
z = 90;
fprintf( fid, 'This data will be output %d %d %d\n',x,y,z);

%%

%Default file descriptors
% 0 - standard input
% 1 - standard output
% 2 - standard error

clc;
fprintf( 1, 'Printing to standard output\n' );
fprintf('Printing without specifying standard out\n' );
fprintf( 2, 'This is an error message\n' );

%%

%More detailed file reading

filename = 'data.txt';
[ fid, message ] = fopen( filename, 'r' );

if fid == -1
    fprintf(2,'Could not open file: %s\n', message );
end

%Read just one line
line1 = fgetl( fid );
line2 = fgetl( fid );

%Read 10 bytes at a time
text = fread( fid, 10 );

%%
clc;
filename = 'data2.txt';
[ fid, message ] = fopen( filename, 'r' );

if fid == -1 
    fprintf(2,'Could not open file: %s\n', message);
end

line = fgetl( fid );
while line ~= -1
   numeric = str2num( line );
   fprintf('Got %d from file\n', numeric );
   
   line = fgetl( fid );
end

    %%
    
clc;
filename = 'data3.txt';
[ fid, message ] = fopen( filename, 'r' );

if fid == -1 
    fprintf(2,'Could not open file: %s\n', message);
end

data1 = fread( fid, 3 );
space = fread( fid, 1 );
data2 = fread( fid, 4 );
newline = fread( fid, 2 );

while length(data1) > 0
   numeric1 = str2num( char(data1') );
   numeric2 = str2num( char(data2') );
   fprintf('Got %d and %d from file\n', numeric1, numeric2 );
   
    data1 = fread( fid, 3 );
    space = fread( fid, 1 );
    data2 = fread( fid, 4 );
    newline = fread( fid, 2 );
end

    
    





