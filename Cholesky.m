function V = Cholesky(A)

n = size(A, 1);
V = zeros(n);

for i = 1:n
    for j = 1:i

        s = 0;
        for k = 1:j-1
            s = s + V(i,k)*V(j,k);
        end

        if i == j
            V(i,j) = sqrt(A(i,i) - s);
        else
            V(i,j) = sqrt(A(i,j) - s) / V(j,j);
        end
    end
end
