function [] = playSong( songFile , note )
%Plays a specified song given by songFile,
%Expects format:
%Col 1: note frequency
%Col 2: note start time
%Col 3: note duration

%The note parameter gives the type of note to use:
% note = 1 -> pure sine wave note
% note = 2 -> ramp note (avoids popping)
% note = 3 -> synthesized organ
% note = 4 -> square wave notes
% note = 5 -> sawtooth wave notes
% note = 6 -> sampled piano notes
% note = 7 -> sampled flute notes

song = load(songFile);
time = 0;

if note == 7
    [y Fs] = audioread( 'instr_flute.wav' );
else
    [y Fs] = audioread( 'instr_piano.wav' );
end

for i = 1:length(song)
   noteFreq   = song(i, 1);
   noteStart  = song(i, 2);
   noteLength = song(i, 3);
   
   if( noteStart > time )
       delta = noteStart - time;
       pause( delta );
       time = noteStart;
   end
  
   if ( note == 1 )
      pureNote( noteFreq, noteLength, 1);
   elseif ( note == 2 )
      rampNote( noteFreq, noteLength );
   elseif ( note == 3 )
      organ( noteFreq, noteLength );
   elseif ( note == 4 )
      squareNote( noteFreq, noteLength );
   elseif ( note == 5 )
      sawtoothNote( noteFreq, noteLength );
   elseif (note == 6 )
       pianoNote( noteFreq, y, Fs );
   elseif (note == 7 )
       fluteNote( noteFreq, y, Fs );
   end

end


end
