%Playing around with creating synthesized notes, this code evolved
%into pureNote.m, rampNote.m, and organ.m

%%Creating a pure note
clear;
Fs = 8192;
freq = 261.63; 
length = 4;
deltaT = 1/Fs;
time = 0:deltaT:length;

y = sin( 2*pi*freq*time);
sound(y, Fs)

%%
clear;
Fs = 8192;
freq1 = 440;
freq2 = 880;
len = 4;
deltaT = 1/Fs;
time = 0:deltaT:len;
y1 = sin( 2*pi*freq1*time);
y2 = sin( 2*pi*freq2*time);

y = (y1 + y2)/2;
sound(y, Fs);

%Time for one cycle of the first freq
plotT = 1/freq1;
plotX = 0:deltaT:4*plotT;
plotY1 = y1(1:length(plotX));
plotY2 = y2(1:length(plotX));
plotY = y(1:length(plotX));

subplot( 3, 1, 1);
plot( plotX, plotY1 );
subplot( 3, 1, 2);
plot( plotX, plotY2 );
subplot( 3, 1, 3);
plot( plotX, plotY );