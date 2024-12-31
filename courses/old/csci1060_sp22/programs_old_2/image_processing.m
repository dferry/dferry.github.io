%David and class
%Image processing in MATLAB
% April 28th, 2020

%Loads the image into MATLAB
imdata = imread( 'slu.png' );

%Picks out a single pixel at row 47, column 212
singlePixel = imdata( 47, 212, : )

%Change the color of that pixel:
imdata( 47, 212, : ) = 255;

imwrite( imdata, 'whitePixel.png' )

%%
%White out a block of pixels
imdata( 40:50, 210:220, : ) = 255; 

imwrite( imdata, 'whiteBlock.png' );

%%

%Pull out the each color channel

%Loads the image into MATLAB
imdata = imread( 'slu.png' );

%Note, dimension 1 is the red color channel
%Note, dimension 2 is the green color channel
%Note, dimension 3 is the blue color channel

redChannel = imdata; %makes a copy of imdata
greenChannel = imdata;
blueChannel = imdata;

%black out the green and blue color channels
redChannel( :, :, 2:3 ) = 0;
%black the red and green color channels
blueChannel( :, :, 1:2 ) = 0;
%black out the red and blue color channels
greenChannel( :, :, [ 1 3 ] ) = 0; 


imwrite( redChannel, 'redSLU.png' );
imwrite( greenChannel, 'greenSLU.png' );
imwrite( blueChannel, 'blueSLU.png' );

%%

%Edge detection with a covolution matrix in MATLAB

%Loads the image into MATLAB
imdata = imread( 'slu.png' );
[rows columns depth ] = size( imdata );

imdata = double(imdata);
output = zeros( rows, columns, depth );

%Convlution matrix
c = [ -1  -1  -1;
      -1  9   -1;
      -1  -1  -1];

for row = 2:(rows - 1)
    for col = 2:(columns - 1)

        output( row, col, : ) = ...
            imdata( row-1, col-1, : ) .* c(1,1) + ...
            imdata( row-1, col, : )   .* c(1,2) + ...
            imdata( row-1, col+1, : ) .* c(1,3) + ...
            imdata( row, col-1, : )   .* c(2,1) + ...
            imdata( row, col, : )     .* c(2,2) + ...
            imdata( row, col+1, : )   .* c(2,3) + ...
            imdata( row+1, col-1, : ) .* c(3,1) + ...
            imdata( row+1, col, : )   .* c(3,2) + ...
            imdata( row+1, col+1, : ) .* c(3,3);
        
    end 
end

output = uint8( output );
imwrite( output, 'output.png' );



