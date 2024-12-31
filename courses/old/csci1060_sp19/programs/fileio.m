%David and Class
% File input/output
% March 20th, 2019

fid = fopen( 'output.txt', 'w' );

fprintf(fid, 'This is a test message.\n');

%fclose( fid );

%%
% 0  - standard input
% 1  - standard output
% 2  - standard error
fprintf( 1, 'Hello, world\n');
fprintf( 2, 'This is an error message\n');

%%
%Opening a file with error checking

[ fid, msg ] = fopen( 'output.txt', 'w' );
fprintf('fopen returned %d with message "%s"\n', fid, msg );
%%
%This should not work...
[ fid, msg ] = fopen( 'C:\Windows\system.cfg', 'w' );
fprintf('fopen returned %d with message "%s"\n', fid, msg );

%%
%Reading from a file

inputFile = 'gambler.m';
[fid, msg ] = fopen( inputFile, 'r' );

if fid == -1 
    fprintf('Call to open "%s" filed, reason: %s\n', inputFile, msg );
    return;
end

fileContents = fread( fid );

%%
%%
%Reading from a file

stride = 5;
inputFile = 'gambler.m';
[fid, msg ] = fopen( inputFile, 'r' );

if fid == -1 
    fprintf('Call to open "%s" filed, reason: %s\n', inputFile, msg );
    return;
end

count = 1;
while count ~= 0
    [fileContents, count] = fread( fid, stride );
    if count == 0
        break;
    end
    disp( char(fileContents)' )
end


%%
%Reading from a file

inputFile = 'gambler.m';
[fid, msg ] = fopen( inputFile, 'r' );

if fid == -1 
    fprintf('Call to open "%s" filed, reason: %s\n', inputFile, msg );
    return;
end

while 1
    fileContents = fgetl( fid);
    if fileContents == -1 
        break;
    end
    disp( char(fileContents) )
end