function A = readData()
A = readtable('linregdata','ReadVariableNames',false);
present = @(x) ismember(table2array(A(:,1)), x);
A = [present('F') present('I') present('M') table2array(A(:,2:end))];
end