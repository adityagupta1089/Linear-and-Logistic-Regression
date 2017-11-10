close all
clear all
clc
% constants
N=100;
degree = 2;
% input
A = csvread('credit.txt');
X = [ones(size(A,1), 1) A(:,1:end-1)];
X = featureTransform(X, degree);
Y = A(:, 3);
% classes
C1 = A(Y == 0,:);
C2 = A(Y == 1,:);
% inital value of w
w0 = 0.2 * rand(size(X, 2), 1) - 0.1;
ws = logisticRegression(X,Y,w0,0,N,'NewtonRaphson');
% error
error = cellfun(@(w) loss(X,Y,w), ws);
figure
plot(error);
title('Degree = 2');
xlabel('Iterations');
ylabel('LOSS error');
% grid
x = linspace(0,6,100);
y = linspace(0,7,100);
% sigmoid values
z = zeros(length(x), length(y));
figure
for i=1:length(x)
    for j=1:length(y)
        z(i,j) = sigmoid(featureTransform([1 x(i) y(j)], degree), ws{end});
    end
end
% plot
hold on
contourf(x,y,z',[0.5 0.5]);
title('Degree = 2');
scatter(C1(:,1), C1(:,2), 'rx');
scatter(C2(:,1), C2(:,2), 'bo');