function [R, z] = Givens(A, b)
    % [R, z] = Givens(A, b) izračuna razširjeni QR razcep.
    % Namesto matrike Q shranjujemo le transformiran vektor z = Q'b.
    [m, n] = size(A);
    R = A;
    z = b;

    for j = 1:n
        for i = j+1:m
            % Elementa, ki ju obravnavamo:
            % R(j,j) je pivotni element, R(i,j) pa želimo spremeniti v 0.
            if R(i, j) ~= 0
                a = R(j, j);
                b_val = R(i, j);
                
                r = hypot(a, b_val);
                c = a / r;
                s = b_val / r;
                
                vrstica_j = R(j, j:n);
                vrstica_i = R(i, j:n);
                
                R(j, j:n) = c * vrstica_j + s * vrstica_i;
                R(i, j:n) = -s * vrstica_j + c * vrstica_i;
                
                zj = z(j);
                zi = z(i);
                
                z(j) = c * zj + s * zi;
                z(i) = -s * zj + c * zi;
                
                R(i, j) = 0;
            end
        end
    end
end