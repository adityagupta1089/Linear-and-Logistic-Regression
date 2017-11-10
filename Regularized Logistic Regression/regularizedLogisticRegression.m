function ws = regularizedLogisticRegression(X,Y,w0,lambda,N)
ws = cell(1,N);
ws{1} = w0;
for i=2:N
        fx = sigmoid(X,ws{i-1});
        R = diag(fx .* (1 - fx));
        I = eye(size(X,2));
        ws{i} = ws{i-1} - pinv(X' * R * X + lambda * I) * (X' * (fx - Y) + lambda * ws{i-1});  
end
end

