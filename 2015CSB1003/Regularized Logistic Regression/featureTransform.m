function X2 = featureTransform(X, d)
n = size(X, 1);
x1 = X(:,2);
x2 = X(:,3);
pows1 = zeros(n, d+1);
pows2 = zeros(n, d+1);
pows1(:,1) = ones(n, 1);
pows2(:,1) = ones(n, 1);
for i=2:d+1
    pows1(:,i)=pows1(:,i-1).*x1;
    pows2(:,i)=pows2(:,i-1).*x2;
end
X2 = zeros(n, floor((d+2)*(d+1)/2));
ind = 1;
for i=1:d+1
    for j=1:d+2-i
        X2(:,ind) = pows1(:,i) .* pows2(:,j);
        ind = ind + 1;
    end
end
end

