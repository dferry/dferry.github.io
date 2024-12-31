function [] = pianoNote( frequency )

[ piano pianoRate ] = audioread( 'instr_piano.wav' );

baseFreq = 261.63;
rateShift = frequency/baseFreq;

sound( piano, pianoRate*rateShift );

end 
