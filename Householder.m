function [Q, R, z] = Householder(A, b)
    [m, n] = size(A);
    Q = eye(m);
    
    for j = 1:n
        k = norm(A(j:m, j));
        if k == 0; continue; end % Varnostni preverjanje
        
        w = A(j:m, j);
        if A(j, j) >= 0
            w(1) = w(1) + k;
        else
            w(1) = w(1) - k;
        end
        
        ksi = k * (k + abs(A(j, j))); 
        
        A(j:m, j:n) = A(j:m, j:n) - (1/ksi) * w * (w' * A(j:m, j:n));
        
        b(j:m) = b(j:m) - (1/ksi) * w * (w' * b(j:m));
        
        Q(j:m, :) = Q(j:m, :) - (1/ksi) * w * (w' * Q(j:m, :));
    end
    
    R = A;
    z = b;
    Q = Q'; % Zdaj je Q tisti pravi iz QR = A
end
