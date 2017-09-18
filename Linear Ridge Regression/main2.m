close all
clear all
clc
% read data
data = readData();
% constants
fractions = 0.1:0.01:0.90;
repetitions = 100;
lambdas = 0:0.1:10;
% input
X = [ones(size(data,1),1) data(:,1:end-1)];
N = size(X,1);
% ouput
Y = data(:,end);
trainErrors = zeros(length(fractions),length(lambdas)); 
testErrors = zeros(length(fractions),length(lambdas)); 
% progress bar
wb = waitbar(0,'Please Wait');
curr = 0;
total = length(fractions)*length(lambdas);
% loop
for i = 1:length(fractions)
    frac = fractions(i);
    for j = 1:length(lambdas)
        lambda = lambdas(j);
        trainErrorSum = 0;
        testErrorSum = 0;
        for k = 1:repetitions
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
            % find approximate value T
            Ttrain = mylinridgeregeval(Xtrain, W);
            Ttest = mylinridgeregeval(Xtest, W);
            % compute error
            trainErrorSum = trainErrorSum + meansquarederr(Ytrain, Ttrain);
            testErrorSum = testErrorSum + meansquarederr(Ytest, Ttest);
        end
        trainErrors(i, j) = trainErrorSum/repetitions;
        testErrors(i, j) = testErrorSum/repetitions;
        curr = curr+1;
        waitbar(curr/total);
    end
end
close(wb);
[cX, cY] = meshgrid(lambdas, fractions);
% training error
surf(cX, cY, trainErrors, 'FaceColor','interp', 'EdgeColor','none',...
   'FaceLighting','phong');
xlabel('\lambda');
ylabel('Fraction of Training Data used');
zlabel('Average Mean squared Training Error');
% testing error
figure
surf(cX, cY, testErrors, 'FaceColor','interp', 'EdgeColor','none',...
   'FaceLighting','phong');
xlabel('\lambda');
ylabel('Fraction of Training Data used');
zlabel('Average Mean squared Testing Error');
% for each training fraction
figure
sampleRate = 10;
fractions2 = 1:sampleRate:length(fractions);
index = 1;
for i = fractions2
    % training error
    subplot(2, length(fractions2), index);
    plot(lambdas, trainErrors(i, :));
    xlabel('\lambda');
    ylabel('Training Error');
    ylim([0 20]);
    title(['Fraction = ', num2str(fractions(i))]);
    % testing error
    subplot(2, length(fractions2), index + length(fractions2));
    plot(lambdas, testErrors(i, :));
    xlabel('\lambda');
    ylabel('Testing Error');
    ylim([0 20]);
    title(['Fraction = ', num2str(fractions(i))]);
    % index
    index = index + 1;
end
% minimum average mean squared error
figure
[mins, minIdx] = min(testErrors, [], 2);
subplot(1,2,1);
plot(fractions, mins, 'xr', fractions, mins, ':b');
xlabel('Fraction of Training Data');
ylabel('Minimum Average Mean Sqaured Testing Error');
% lambda value
subplot(1,2,2);
plot(fractions, lambdas(minIdx), 'xr', fractions, lambdas(minIdx), ':b');
xlabel('Fraction of Training Data');
ylabel('\lambda for Minimum Average Mean Sqaured Testing Error');
% difference between predicted values for best lambda
figure
frac = 0.5;
lambda = lambdas(minIdx(fractions==frac));
%shuffling
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
% find approximate value T
Ttrain = mylinridgeregeval(Xtrain, W);
Ttest = mylinridgeregeval(Xtest, W);
% range of values
rng = [0 max(max([Ttrain;Ttest;Ytrain;Ytest]))];
% training set
subplot(1, 2, 1);
hold on
plot(Ytrain, Ttrain, 'bx');
line(rng, rng, 'Color', 'red', 'LineWidth', 2);
xlabel('Actual Values');
ylabel('Predicted Values');
xlim(rng);
ylim(rng);
title('Training Data');
% testing set
subplot(1, 2, 2);
hold on
plot(Ytest, Ttest, 'bx');
line(rng, rng, 'Color', 'red', 'LineWidth', 2);
xlabel('Actual Values');
ylabel('Predicted Values');
xlim(rng);
ylim(rng);
title('Testing Data');
            