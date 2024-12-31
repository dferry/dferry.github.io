function [ ret ] = reverb ( input, rate, delay )
%This function takes an audio sample and adds a
%simple reverb effect by layering the sample over itself
%with the specified delay.

%input = audio sample to play
%rate  = sampling rate of the audio
%delay = delay (in seconds) of reverb

len = length(input) ;
sampleDelay = rate*delay;

ret = zeros( len + sampleDelay, 2);

ret( 1:len, 1:2 ) = input;

ret( sampleDelay:len+sampleDelay-1, 1:2) =...
    (ret( sampleDelay:len+sampleDelay-1, 1:2) +...
    input(1:len, 1:2))/2; 


end