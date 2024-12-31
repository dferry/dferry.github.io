%Reverses the beatles audio clip to reveal backmasking
%Play the resultant sample with 'sound( reverse, rate )';

[ beatles rate ] = audioread( 'Beatles.wav' );
%slice out 2:25 through 2:37
%2:25 = 145 seconds 
slice = beatles(145*rate:(157+1)*rate, 1:2);

len = length(slice);

reverse = zeros( len, 2 );
for i = 1:len
   reverse( i, 1:2 ) = slice( len - i + 1, 1:2 ); 
end