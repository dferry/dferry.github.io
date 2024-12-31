filename = input('Enter filename [default: djia.txt]: ', 's');
if length(filename) == 0
  filename = 'djia.txt';
end
data = load(filename);

choice = 0;
while choice ~= 6

  fprintf('\n');
  choice = menu('Stock Market Analysis', ...
                'Best calendar month (% gain)', ...
                'Most consecutive days with gain', ...
                'Biggest historical downturn (% loss)', ...
                'Year end analysis (geometric mean)', ...
                'Daily analysis (geometric mean)', ...
                'Quit');
  fprintf('\n');

  stockAnalysis(data, choice);

end
