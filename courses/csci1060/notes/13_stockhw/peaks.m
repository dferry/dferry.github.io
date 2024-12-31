function [numPeaks indices]  = peaks(data)
% function to locate elements of a vector that are strictly
% greater than all preceding elements
% Usage:  [numPeaks indices] = peaks(data)
%
% Data is assumed to be a vector of values.
  if nargin ~= 1
    error('Incorrect usage of peaks');
  end
  if ~isvector(data)
    error('data must be a vector');
  end
  numPeaks = 1;
  maxSoFar = data(1);
  if nargout == 2
    indices = [1];
  end
  for ind = 2:length(data)
    if data(ind) > maxSoFar
      numPeaks = numPeaks + 1;
      maxSoFar = data(ind);
      if nargout == 2
        indices(end+1) = ind;   % append to the resulting vector
      end
    end
  end
