% =========================================================================
% NEWTONOVA METODA ZA NELINEARNE SISTEME
% =========================================================================

% Definiramo sistem nelinearnih enačb kot vektor
F = @(x) [x(1)^2 + x(2)^2 - 4;  % Enačba krožnice: x^2 + y^2 = 4
          x(1)*x(2) - 1];       % Enačba hiperbole: x*y = 1

% Definiramo Jacobijevo matriko (odvode) sistema F
% JF(i, j) je odvod i-te enačbe po j-ti spremenljivki
JF = @(x) [2*x(1), 2*x(2);
           x(2),   x(1)];

x0 = [2; 0.5]; % Začetni približek
x = x0;

for k = 1:5
    % Korak Newtonove metode: x_nov = x - JF(x)^(-1) * F(x)
    % V Matlabu namesto inverza uporabimo levo deljenje (\)
    popravek = JF(x) \ F(x);
    x = x - popravek;
    
    fprintf('Korak %d: x1 = %f, x2 = %f\n', k, x(1), x(2));
end

% --- ČE BI BILA KVAZI-NEWTONOVA METODA (Broyden) ---
% Pri Broydnu ne računaš JF v vsakem koraku, ampak matriko B posodabljaš:
% B_nov = B + ((y - B*s)*s') / (s'*s)
% kjer je s = x_nov - x, y = F(x_nov) - F(x)