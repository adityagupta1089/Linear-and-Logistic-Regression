function ws = logisticRegression(X, Y, w0, alpha, N, optimizationMethod)
ws = cell(1,N);
ws{1} = w0;
if strcmp(optimizationMethod, 'GradientDescent')
    for i=2:N
        ws{i} = ws{i-1} - alpha * X' * (sigmoid(X,ws{i-1}) - Y); 
    end
elseif strcmp(optimizationMethod, 'NewtonRaphson')
    for i=2:N
        fx = sigmoid(X,ws{i-1});
        R = diag(fx .* (1 - fx));
        ws{i} = ws{i-1} - pinv(X' * R * X) * X' * (fx - Y);  
    end
end
end

