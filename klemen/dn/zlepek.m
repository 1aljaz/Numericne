function [z, D1, D2] = zlepek(x, f, df, t)
    % ZLEPEK Izračuna vrednosti zlepka dveh polinomov s pogojem za odvod.
    %   x  - vektor interpolacijskih točk (npr. x_tb, dolžina 9)
    %   f  - kazalec na pravo funkcijo (anonymus function)
    %   df - kazalec na odvod funkcije
    %   t  - vektor točk, kjer želimo izračunati vrednost (npr. množica A)

    n = length(x);             % Število vseh točk (9)
    mid_idx = (n + 1) / 2;     % Sredinski indeks (za 9 točk je to 5. točka, tj. x = 0.8)
    x_sticna = x(mid_idx);     % Vrednost stične točke (0.8)

    % ---------------------------------------------------------------------
    % 1. DEL: LEVI POLINOM p1 (Hermitova interpolacija na področju [x_0, x_k+1])
    % ---------------------------------------------------------------------
    % Točke za p1: prvih 5 točk + stična točka še enkrat (skupaj 6 točk)
    x1 = [x(1:mid_idx), x_sticna];
    y1 = f(x1); % Vrednosti funkcije v teh točkah
    
    % Tabela deljenih diferenc za p1 (velikost 6x6)
    n1 = length(x1);
    D1 = zeros(n1, n1);
    D1(:, 1) = y1';
    
    for j = 2:n1
        for i = 1:n1 - j + 1
            % KLJUČNI HERMITOV POGOJ: Če sta sosednji točki enaki (to se zgodi na koncu)
            if x1(i + j - 1) == x1(i)
                D1(i, j) = df(x1(i)); % Namesto deljenja z 0 vstavimo vrednost odvoda f'(x)
            else
                D1(i, j) = (D1(i + 1, j - 1) - D1(i, j - 1)) / (x1(i + j - 1) - x1(i));
            end
        end
    end
    c1 = D1(1, :); % Koeficienti za polinom p1

    % ---------------------------------------------------------------------
    % 2. DEL: DESNI POLINOM p2 (Hermitova interpolacija na področju [x_k+1, x_2k+1])
    % ---------------------------------------------------------------------
    % Točke za p2: stična točka še enkrat + zadnjih 5 točk (skupaj 6 točk)
    x2 = [x_sticna, x(mid_idx:end)];
    y2 = f(x2);
    
    % Tabela deljenih diferenc za p2 (velikost 6x6)
    n2 = length(x2);
    D2 = zeros(n2, n2);
    D2(:, 1) = y2';
    
    for j = 2:n2
        for i = 1:n2 - j + 1
            % KLJUČNI HERMITOV POGOJ
            if x2(i + j - 1) == x2(i)
                D2(i, j) = df(x2(i)); % Vstavimo vrednost odvoda
            else
                D2(i, j) = (D2(i + 1, j - 1) - D2(i, j - 1)) / (x2(i + j - 1) - x2(i));
            end
        end
    end
    c2 = D2(1, :); % Koeficienti za polinom p2

    % ---------------------------------------------------------------------
    % 3. DEL: VREDNOTENJE ZLEPKA (Simbolno ali numerično na vektorju t)
    % ---------------------------------------------------------------------
    % Pripravimo prazen vektor 'z', ki bo enakih dimenzij kot 't' (1x1000)
    z = zeros(size(t));
    
    % Za vsako točko iz 't' preverimo, ali leži levo ali desno od stične točke
    for idx = 1:length(t)
        trenutni_x = t(idx);
        
        if trenutni_x <= x_sticna
            % --- Vrednotenje polinoma p1 (levi del) ---
            % Uporabimo koeficiente c1 in točke x1
            vrednost = c1(1);
            term = 1;
            for k = 2:length(c1)
                term = term * (trenutni_x - x1(k - 1));
                vrednost = vrednost + c1(k) * term;
            end
            z(idx) = vrednost;
            
        else
            % --- Vrednotenje polinoma p2 (desni del) ---
            % Uporabimo koeficiente c2 in točke x2
            vrednost = c2(1);
            term = 1;
            for k = 2:length(c2)
                term = term * (trenutni_x - x2(k - 1));
                vrednost = vrednost + c2(k) * term;
            end
            z(idx) = vrednost;
        end
    end
end