%David and Class
%Revealing digital watermarking 
% April 29th, 2020

%Load the watermarked image
imdata = imread( 'watermarked.png' );

red =   imdata( :, :, 1 );
green = imdata( :, :, 2 );
blue =  imdata( :, :, 3 );

%%
%Extracting red channel data - hidden image

%How do we pull out the value of the least significant bit?
% Numbers are represented as eight bits: 10011010

%Base 10 number system, suppose we have the value 1,234
% 1,234 = 1000 * 1 + 100 * 2  + 10 * 3   + 1 * 4
% 1,234 = 10^3 * 1 + 10^2 * 2 + 10^1 * 3 + 10^0 * 4

%Base 2 number system, suppose we have the value 10011010
% = 2^7*1 + 2^6*0 + 2^5*0 + 2^4*1 + 2^3*1 + 2^2*0 + 2^1*1 + 2^0*0
% = 128*1 + 64*0 + 32*0 + 16*1 + 8*1 + 4*0 + 2*1 + 1*0
% = 154

%The least significant bit is 1 if number is odd, or 0 if number is even
%How do we figure out if a number is even? Use the modulus/remainder operator

[rows columns] = size( red );
outRed = zeros( rows, columns);

for row = 1:rows
    for col = 1:columns
        pixelValue = red( row, col );
        remainder = rem( pixelValue, 2 ); %Will be zero or one
        outRed( row, col ) = remainder;
    end
end

%Now we have a matrix outRed full of ones and zeros
imwrite( outRed, 'hidden_image.png' );

%%

%Green channel - hidden audio

%Base 2 number system, suppose we have the value 10011010
% = 2^7*1 + 2^6*0 + 2^5*0 + 2^4*1 + 2^3*1 + 2^2*0 + 2^1*1 + 2^0*0
% = 128*1 + 64*0 + 32*0 + 16*1 + 8*1 + 4*0 + 2*1 + 1*0
% = 154

%The least significant bit is 1 if number is odd, or 0 if number is even
%How do we figure out if a number is even? Use the modulus/remainder operator

%Text is encoded - every eight pixels is equivalent to one 8-bit ASCII
%character

[rows columns] = size( green );
length = rows*columns;
message = [];

for i = 1:8:length
    bit1 = rem( green(i), 2 ); %Gives us a zero or one
    bit2 = rem( green(i+1), 2 ); %Gives us a zero or one
    bit3 = rem( green(i+2), 2 ); %Gives us a zero or one
    bit4 = rem( green(i+3), 2 ); %Gives us a zero or one
    bit5 = rem( green(i+4), 2 ); %Gives us a zero or one
    bit6 = rem( green(i+5), 2 ); %Gives us a zero or one
    bit7 = rem( green(i+6), 2 ); %Gives us a zero or one
    bit8 = rem( green(i+7), 2 ); %Gives us a zero or one
    
    decimalValue = bit1*128 + bit2*64 + bit3*32 + bit4*16 + ...
        bit5*8 + bit6*4 + bit7*2 + bit8;
    
    message(end+1) = decimalValue;
end

message = char( message )

fid = fopen('carroll.txt', 'w');
fprintf(fid, message);
fclose( fid );

%%

%Decoding the blue channel - audio

%Challenge - must represent negative numbers using "twos complement"
%representation, also a 16-bit representation

%This means our values are 16 bits: 0000111100001111
% The first bit has the value -2^15
% = -2^15*bit1 + 2^14*bit2 + 2^13*bit3 + ... + 2^1*bit15 + 2^0*bit16

[rows columns] = size( blue );
length = rows*columns;
audio = [];
blue = double(blue);

for i = 1:16:length
    bit1 = rem( blue(i), 2 ); %Gives us a zero or one
    bit2 = rem( blue(i+1), 2 ); %Gives us a zero or one
    bit3 = rem( blue(i+2), 2 ); %Gives us a zero or one
    bit4 = rem( blue(i+3), 2 ); %Gives us a zero or one
    bit5 = rem( blue(i+4), 2 ); %Gives us a zero or one
    bit6 = rem( blue(i+5), 2 ); %Gives us a zero or one
    bit7 = rem( blue(i+6), 2 ); %Gives us a zero or one
    bit8 = rem( blue(i+7), 2 ); %Gives us a zero or one
    bit9 = rem( blue(i+8), 2 ); %Gives us a zero or one
    bit10 = rem( blue(i+9), 2 ); %Gives us a zero or one
    bit11 = rem( blue(i+10), 2 ); %Gives us a zero or one
    bit12 = rem( blue(i+11), 2 ); %Gives us a zero or one
    bit13 = rem( blue(i+12), 2 ); %Gives us a zero or one
    bit14 = rem( blue(i+13), 2 ); %Gives us a zero or one
    bit15 = rem( blue(i+14), 2 ); %Gives us a zero or one
    bit16 = rem( blue(i+15), 2 ); %Gives us a zero or one
    
    decimalValue = -bit1*2^15 + bit2*2^14 + bit3*2^13 + bit4*2^12 + ...
        bit5*2^11 + bit6*2^10 + bit7*2^9 + bit8*2^8 + bit9*2^7 + ...
        bit10*2^6 + bit11*2^5 + bit12*2^4 + bit13*2^3 + bit14*2^2 + ...
        bit15*2 + bit16;
    
    %if decimalValue >= 2^15
    %    decimalValue = decimalValue - 2^16;
    %end
    
    audio(end+1) = decimalValue;
end

sound( audio, 8000 )






