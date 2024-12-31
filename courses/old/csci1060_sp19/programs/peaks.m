
%This function finds the locations of the maximum values of a 
% of a sequence. I.e. the "peaks" of a sequence
% INPUT seq = the sequence to analyze
% OUTPUT numMaxes = the number of peaks found
% OUTPUT indicies = the location of peaks found

function [ numMaxes indices ] = peaks( seq )

if isempty( seq )
    numMaxes = 0;
    indices = [];
    return;
end

numMaxes = 1;
indices = [ 1 ];

if length(seq) == 1
    return;
end

maxSoFar = seq(1);

for x = 2:length(seq)
    if seq(x) > maxSoFar
        maxSoFar = seq(x);
        numMaxes = numMaxes + 1;
        indices = [ indices x ];
    end
end

end