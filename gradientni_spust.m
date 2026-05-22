% =========================================================================
% METODA NAJSTRMEJŠEGA SPUSTA (MINIMIZACIJA)
% =========================================================================

f = @(x) x(1)^2 + 2*x(2)^2 - x(1)*x(2); % Funkcija, ki jo minimiziramo
grad_f = @(x) [2*x(1) - x(2);           % Gradient (vektor prvih odvodov)
               4*x(2) - x(1)];

x = [1; 1]; % Začetna točka
alfa = 0.1; % Dolžina koraka (learning rate) - v nalogah je lahko konstanten ali optimalen

for k = 1:5
    g = grad_f(x); % Izračunamo smer najstrmejšega naraščanja
    x = x - alfa * g; % Premaknemo se v nasprotno smer (smer spusta)
    
    fprintf('Korak %d: f(x) = %f\n', k, f(x));
end