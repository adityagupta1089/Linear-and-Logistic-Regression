function loss = loss(X, Y, w)
fx = sigmoid(X,w);
loss = - sum(Y .* log(fx) + (1 - Y) .* log(1 - fx));
end

