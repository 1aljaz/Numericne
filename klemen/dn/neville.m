function [V, vrednost] = neville(x_tb, y_tb, t)
    % NEVILLE Izračuna vrednost polinoma v točki t s pomočjo Nevilleove sheme.
    %   x_tb, y_tb - interpolacijske točke
    %   t          - točka, v kateri vrednotimo polinom
    %   V          - celotna trikotna matrika sheme (za preverjanje vmesnih elementov)

    n = length(x_tb);
    V = zeros(n, n);
    V(:, 1) = y_tb(:); % Prvi stolpec so kar y vrednosti

    for j = 2:n
        for i = 1:n-j+1
            % Nevilleova rekurzivna formula
            stevec = (t - x_tb(i+j-1))*V(i, j-1) - (t - x_tb(i))*V(i+1, j-1);
            imenovalec = x_tb(i) - x_tb(i+j-1);
            V(i, j) = stevec / imenovalec;
        end
    end
    
    % Končna vrednost polinoma v točki t se nahaja v desnem oglišču (1, n)
    vrednost = V(1, n);
end