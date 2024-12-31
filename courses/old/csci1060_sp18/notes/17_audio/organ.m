function [] = organ( freq, duration )
% Plays a synthethsized organ note at the given frequency
% and for the given duration

Fs = 8192;
ramp = 512;

deltaT = 1/Fs;

time = (0:deltaT:duration)';

amp = ones( length(time), 1);
amp(1:ramp+1) = 0:1/ramp:1;
amp(end-ramp:end) = 1:-1/ramp:0;

freqL  = freq/2;
freqLL = freq/4;
freqU  = freq*2;
freqUU = freq*4;

amp1 = amp.*0.5;
amp2 = amp.*0.25;

y1 = amp2.*cos( 2*pi*freqLL*time);
y2 = amp1.*cos( 2*pi*freqL *time);
y3 = amp .*cos( 2*pi*freq  *time);
y4 = amp1.*cos( 2*pi*freqU *time);
y5 = amp2.*cos( 2*pi*freqUU*time);

y = (y1+y2+y3+y4+y5)/5;

sound(y, Fs)

end