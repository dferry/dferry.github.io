function [] = pureNote( freq, duration, amp )
% Plays a pure note constructed from a cosine wave
% at the specified frequency and amplitude, for the
% given duration.

Fs = 8192;
deltaT = 1/Fs;

time = 0:deltaT:duration;
y = amp*cos( 2*pi*freq*time);

sound(y, Fs)

end