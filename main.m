clc
clear all
data = readData();
frac = 0.2;
X = data(:,1:end-1);
N = size(X,1);
X = X(randperm(N), :);
Y = data(:,end);
split = floor(frac*N);
Xtrain = X(1:split,:);
Ytrain = Y(1:split,:);
Xtest = X(split+1:end,:);
Ytest = Y(split+1:end,:);
W = mylinridgereg(Xtrain, Ytrain, 0);
T = mylinridgeregeval(Xtest, W);
disp(meansquarederr(Ytest, T));