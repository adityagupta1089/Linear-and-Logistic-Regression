function A = readData()
A = readtable('linregdata','ReadVariableNames',false);
present = @(x) ismember(table2array(A(:,1)), x);
rest = table2array(A(:,2:end));
repeat = @(arr) repmat(arr, size(rest, 1), 1);
rest = rest - repeat([mean(rest(:,1:end-1)) 0]);
rest = rest ./ repeat([std(rest(:,1:end-1)) 1]);
A = [present('F') present('I') present('M') rest];
end