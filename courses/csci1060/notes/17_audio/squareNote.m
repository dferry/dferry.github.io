function [] = squareNote( freq, duration )
% Plays a pure note constructed from a square wave
% at the specified frequency and amplitude, for the
% given duration.

Fs = 8192;
ramp = 512;

deltaT = 1/Fs;

time = (0:deltaT:duration)';
amp = ones( length(time), 1);

amp(1:ramp+1) = 0:1/ramp:1;
amp(end-ramp:end) = 1:-1/ramp:0;

y = amp.*square(2*pi*freq*time);

plot(y)

sound(y, Fs)

end
