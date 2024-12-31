%File input and output
%David and Class
% 3/29/2021

%Basic, rectangular data files can be loaded with the simple
% command load()

filename = 'data.txt';
load( filename );

%%

%fread() is a more flexible function for reading data
%Read an entire file into a single vector
filename = 'data.txt';
[fid, message] = fopen( filename, 'r' );
if fid == -1
    fprintf('Error, could not open file: %s\n', message );
    return; %Causes our script to stop executing
end
data = fread( fid );

%Recall we can print as characters
char(data')

%%
%Write formatted data to a file

filename = 'data3.txt';
[fid, message] = fopen( filename, 'w' );
if fid == -1
    fprintf('Error, could not open file: %s\n', message );
    return; %Causes our script to stop executing
end

x = 42;
fprintf(fid, 'My data is %d\n', x );

%%
% Read a file line by line

filename = 'data.txt';
[fid, message] = fopen( filename, 'r' );
if fid == -1
    fprintf('Error, could not open file: %s\n', message );
    return; %Causes our script to stop executing
end

%data1 = fgetl( fid ) %fgetl stands for get line from file
%data2 = fgetl( fid )
i = 1;
line = fgetl( fid );
while line ~= -1
    fprintf('Got line %d: %s\n', i, line );
    line = fgetl( fid );
    i = i + 1;
end

%%

%Reading in a file by a set of characters at a time

filename = 'data.txt';
[fid, message] = fopen( filename, 'r' );
if fid == -1
    fprintf('Error, could not open file: %s\n', message );
    return; %Causes our script to stop executing
end

readSize = 25;

data = fread(fid, readSize)
while ~isempty( data )
   fprintf('%s\n', data);
   data = fread(fid, readSize);
end


