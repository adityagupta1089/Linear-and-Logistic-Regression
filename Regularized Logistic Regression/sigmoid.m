function fx = sigmoid(X, w)
fx = 1.0 ./ (1.0 + exp(-X*w));
fx = arrayfun(@f, fx);
end

function y = f(x)
    eps = 1e-14;
    if x>=1-eps
        y=1-eps;
    elseif x<=eps
        y=eps;
    else
        y=x;
    end
end