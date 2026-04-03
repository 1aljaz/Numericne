function [Q, R] = QRrazcep(A,tip)

[m,n] = size(A);
Q = zeros(m,n);
R = zeros(n,n);
tip = upper(tip);
if tip == "CGS"
    for k = 1:n
        q_k = A(:,k);
        for i = 1:k-1
            R(i,k) = Q(:,i)' * A(:,k);
            q_k = q_k - R(i,k) * Q(:,i);
        end
        R(k,k) = norm(q_k);
        Q(:,k) = q_k / R(k,k);
    end
elseif tip == "MGS"
    V = A;
    for k = 1:n
        R(k,k) = norm(V(:,k));
        Q(:,k) = V(:,k) / R(k,k);
        for j = k+1:n
            R(k,j) = Q(:,k)' * V(:,j);
            V(:,j) = V(:,j) - R(k,j) * Q(:,k);
        end
    end
else
    error("Tip mora biti CGS ali MGS")
end
end

