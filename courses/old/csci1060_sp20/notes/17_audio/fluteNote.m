function [] = fluteNote( frequency, duration )

[ flute fluteRate ] = audioread( 'instr_flute.wav' );

baseFreq = 261.63;
rateShift = frequency/baseFreq;

fluteLength = 100000/fluteRate;

if( duration > fluteLength )
    sound( flute, fluteRate*rateShift );
else
    sound( flute(1:duration*fluteRate), fluteRate*rateShift );
end
    
end
