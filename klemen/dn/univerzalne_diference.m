function D = univerzalne_diference(x, f_funkcija, df_odvod)
    % Zgradi tabelo deljenih diferenc, ki podpira tudi podvojene točke (Hermite).
    % x          - vektor točk (lahko vsebuje podvojene elemente)
    % f_funkcija - kazalec na funkcijo, npr. @(x) sin(7*x)
    % df_odvod   - kazalec na odvod funkcije, npr. @(x) 7*cos(7*x)

    n = length(x);
    D = zeros(n, n);
    
    % 1. stolpec: Vrednosti funkcije
    for i = 1:n
        D(i, 1) = f_funkcija(x(i));
    end
    
    % Polnjenje preostalih stolpcev
    for j = 2:n
        for i = 1:n-j+1
            % KLJUČNI POGOJ: Če sta x-a enaka, gre za odvod (Hermite)!
            if x(i+j-1) == x(i)
                % Za 2. stolpec (j=2) je to prvi odvod f'(x)
                % Če bi imeli trikrat isto točko (j=3), bi bil to f''(x)/2!
                D(i, j) = df_odvod(x(i)) / factorial(j-1);
            else
                % Klasična formula deljenih diferenc
                D(i, j) = (D(i+1, j-1) - D(i, j-1)) / (x(i+j-1) - x(i));
            end
        end
    end
end