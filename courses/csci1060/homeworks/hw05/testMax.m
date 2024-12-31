function success = testMax(numTrials)
% Compares the output of max and myMax on randomly generated arrays.
% Usage:  success = testMax(numTrials)
% Returns true if successful.
% Otherwise, outputs a matrix that demonstrates the flaw and
% returns false.
  if nargin == 0
    numTrials = 1000;
  end
  success = true;                 % unless evidenced to the contrary
  for trial = 1:numTrials
    r = ceil(8 * rand());         % pick #rows from 1 to 8
    c = ceil(8 * rand());         % pick #cols from 1 to 8
    data = ceil(10*rand(r,c));    % pick entries from 1 to 10
    [y i] = max(data);    official = {y i};
    [y i] = myMax(data);  student = {y i};
    label = 'YI';
    for ind = 1:2
      if ~isequal(official{ind}, student{ind})
        disp('For the original array:');
        disp(data);
        fprintf('The official max returned %s:\n', label(ind));
        disp(official{ind});
        fprintf('myMax returned %s:\n', label(ind));
        disp(student{ind});
        success = false;
        break
      end
    end
    if ~success
      break;       % quit now
    end
  end
