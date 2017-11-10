function weights = mylinridgereg(X, Y, lambda)
% X -> NxD, X' -> DxN, X'X -> DxD, Y -> Nx1, X'Y -> Dx1
weights = pinv(X' * X + lambda * eye(size(X,2))) * (X' * Y);
end

