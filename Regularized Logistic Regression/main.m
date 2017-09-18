close all
clear all
clc
% constants
N = 100;
alpha = 0.001;
% input
A = csvread('credit.txt');
X = [ones(size(A,1),1) A(:,[1,2])];
Y = A(:,3);
% classes
C1 = A(Y == 0,:);
C2 = A(Y == 1,:);
% inital value of w
%w = 0.*2 * rand(size(X,2), 1) - 0.1;
w=[1;0;-3];
% gradient-descent
wsGD = logisticRegression(X,Y,w,alpha,N,'GradientDescent');
% error
errorGD = cellfun(@(w) loss(X,Y,w),wsGD);
hold on
plot(0:length(errorGD)-1, errorGD, 'r');
% inital value of w
w = 0.*2 * rand(size(X,2), 1) - 0.1;
% newton raphson
wsNR = logisticRegression(X,Y,w,alpha,N,'NewtonRaphson');
% error
errorNR = cellfun(@(w) loss(X,Y,w),wsNR);
plot(0:length(errorNR)-1, errorNR, 'b');
legend('Gradient Descent', 'Newton Raphson');
% labels
xlabel('Iterations');
ylabel('LOSS error');
% points
figure
hold on
% scatter
scatter(C1(:,1), C1(:,2), 'rx');
scatter(C2(:,1), C2(:,2), 'bo');
% labels
xlabel('x_1');
ylabel('x_2');
% grid 
x = linspace(0,6,100);
y = linspace(0,7,100);
% sigmoid values
zGD = zeros(length(x), length(y));
zNR = zeros(length(x), length(y));
for i=1:length(x)
    for j=1:length(y)
        zGD(i,j) = sigmoid([1 x(i) y(j)], wsGD{end});
        zNR(i,j) = sigmoid([1 x(i) y(j)], wsNR{end});
    end
end
contour(x,y,zGD',0.5,'LineWidth',3,'LineColor','m');
contour(x,y,zNR',0.5,'LineWidth',1);
legend('Negative', 'Positive', 'Gradient Descent', 'Newton Raphson');