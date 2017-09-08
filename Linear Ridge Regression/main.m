clc
clear all
% read data
data = readData();
% constants
frac = 0.2;
lambda = 0;
% input
X = data(:,1:end-1);
N = size(X,1);
% ouput
Y = data(:,end);
% shuffling
perm = randperm(N); 
X = X(perm, :);
Y = Y(perm);
% splitting
split = floor(frac*N);
Xtrain = X(1:split,:);
Ytrain = Y(1:split,:);
Xtest = X(split+1:end,:);
Ytest = Y(split+1:end,:);
% apply linear redge regression
W = mylinridgereg(Xtrain, Ytrain, lambda);
[~, idx] = sort(abs(W));
discards = 0:size(Xtrain, 2);
errors = zeros(size(discards));
for i = 1:length(discards)
    discard = discards(i);
    W2 = W(idx(discard+1:end));
    Xtest2 = Xtest(:,idx(discard+1:end));
    % TODO should do ridge regression again?
    T2 = mylinridgeregeval(Xtest2, W2);
    errors(i) = meansquarederr(Ytest, T2);
end
plot(discards, errors);
xlabel('Attributes Discarded');
ylabel('Mean Squared Error');