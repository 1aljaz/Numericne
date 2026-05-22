% =========================================================================
% ITERATIVNE METODE ZA LINEARNE SISTEME
% =========================================================================

A = [4 -1  0 0; 
    -1  4 -1 0; 
     0 -1  4 -1; 
     0  0 -1 4]; % Primer diagonalno dominantne matrike
b = [1; 2; 0; 1];
x = [0; 0; 0; 0]; % Začetni približek x0

max_koraki = 5;
vsi_koraki = zeros(length(x), max_koraki);

% --- IZBERI METODO (odkomentiraj želeno) ---
metoda = 'Jacobi';
% metoda = 'Gauss-Seidel';

D = diag(diag(A));  % Diagonalni del matrike A
L = -tril(A, -1);   % Strogi spodnji trikotnik
U = -triu(A, 1);    % Strogi zgornji trikotnik

for k = 1:max_koraki
    if strcmp(metoda, 'Jacobi')
        % Formula: x^(k+1) = D^(-1) * ((L + U)*x^(k) + b)
        x = D \ ((L + U)*x + b);
    else
        % Formula za Gauss-Seidel: x^(k+1) = (D - L)^(-1) * (U*x^(k) + b)
        x = (D - L) \ (U*x + b);
    end
    
    vsi_koraki(:, k) = x; % Shranimo korak za kasnejša vprašanja
end

% Vprašanje na kvizu: "Kolikšna je 1-norma vektorja po 4 korakih?"
disp(['Norma po 4 korakih: ', num2str(norm(vsi_koraki(:, 4), 1))]);