% =========================================================================
% DEL (a): NEWTONOVA INTERPOLACIJA S SIMBOLNIM PRISTOPOM
% =========================================================================

% --- 1. PRIPRAVA PODATKOV ---
% Vektor x_tb vsebuje 9 točk, kjer poznamo vrednosti (interpolacijske točke).
x_tb = [0 0.1 0.5 0.6 0.8 1 1.2 1.8 2];
total = length(x_tb); % total postane število 9 (dolžina vektorja)

% Vektor A predstavlja "gosto mrežo" 1000 točk med 0 in 2.
% Matlab tukaj ustvari vrstično matriko dimenzije 1x1000.
A = linspace(0, 2, 1000);

% Izračunamo vrednosti funkcije sin(7x) v naših 9 interpolacijskih točkah.
% y postane vektor z 9 številkami.
y = sin(7 * x_tb);


% --- 2. SCHEMA DELJENIH DIFERENC ---
% Ustvarimo matriko 9x9, polno ničel, ki bo služila kot tabela.
D = zeros(total, total);

% V prvi stolpec matrike D zapišemo transponirane vrednosti y.
% y' spremeni vrstico v stolpec (9x1), da se ujema s prvim stolpcem matrike D.
D(:, 1) = y';

% Zanki izračunata višje rede deljenih diferenc (klasična Newtonova tabela).
for j = 2:total
    for i = 1:total - j + 1
        % Izračunamo razmerje med razlikami vrednosti in razlikami x-ov.
        D(i, j) = (D(i + 1, j - 1) - D(i, j - 1)) / (x_tb(i + j - 1) - x_tb(i));
    end
end

% Koeficienti našega polinoma so v prvi vrstici matrike D.
c = D(1, :);


% --- 3. SESTAVLJANJE SIMBOLNEGA POLINOMA (Tvoj pristop) ---
% Definiramo, da je 'x' simbolna spremenljivka (ne številka, ampak črka).
syms x

p = c(1);   % Začnemo s prvim koeficientom c_0
term = 1;   % Pomožna spremenljivka za gradnjo oklepajev (x-x_0)(x-x_1)...

% Zanka teče od 2 do 9 in gradi Newtonovo formulo.
for i = 2:length(c)
    % V vsakem koraku pomnožimo prejšnji izraz z novim oklepajem (x - x_i-1)
    term = term * (x - x_tb(i - 1));
    
    % Prištejemo koeficient, pomnožen s trenutnim produktom oklepajev
    p = p + c(i) * term;
end

% Ukaz expand vzame polinom 'p' in ga razvije (pomnoži oklepaje) v standardno obliko.
p_razvit = expand(p); 


% --- 4. EVALVACIJA IN IZRAČUN NAPAKE ---
% f_A postane vektor (1x1000), ki vsebuje točne vrednosti sin(7x) za vsako točko iz A.
f_A = sin(7 * A);

% Ukaz 'subs' v simbolni polinom 'p' namesto črke 'x' vstavil celoten vektor A (1000 točk).
% Ukaz 'double' spremeni simbolni rezultat nazaj v navadne številke (vektor 1x1000).
p_A = double(subs(p, x, A));

% Izračunamo absolutno razliko med pravo funkcijo in polinomom v vseh 1000 točkah.
% 'abs' poskrbi, da so vse razlike pozitivne, 'max' pa poišče največjo med njimi.
napaka_a = max(abs(f_A - p_A));

% Izpis končnega rezultata v ukazno okno.
disp(['Maksimalna napaka ||f - p|| nad množico A je: ' num2str(napaka_a)]);



% =========================================================================
% REŠITEV PODNALOG (b), (c), (d) in (e)
% =========================================================================

% --- PRIPRAVA FUNKCIJ ---
% Definiramo originalno funkcijo f(x) in njen prvi odvod df(x).
% Znak @(x) pove Matlabu, da gre za funkcijski predpis, kjer je x spremenljivka.
f = @(x) sin(7 * x);
df = @(x) 7 * cos(7 * x);


% --- REŠITEV (b): POKLIC FUNKCIJE ZLEPEK ---
% Pokličemo našo prirejeno funkcijo. 
% Funkcija sedaj vrne tri stvari:
%   z_A -> vektor vrednosti zlepka na 1000 točkah (za del b in e)
%   D1  -> celotno matriko deljenih diferenc za levi polinom p1 (za del c in d)
%   D2  -> celotno matriko deljenih diferenc za desni polinom p2 (za del d)
[z_A, D1, D2] = zlepek(x_tb, f, df, A);

% =========================================================================
% GRAFIČNI PRIKAZ (Zadnji del naloge b)
% =========================================================================

% Ustvarimo novo okno za graf
figure; 

% 1. Narišemo pravo funkcijo f(x) z modro zvezno črto
plot(A, f_A, 'b-', 'LineWidth', 2); 
hold on; % Ta ukaz pove Matlabu, naj naslednje grafe riše čez obstoječega, ne pa čez njega

% 2. Narišemo tvoj izračunani zlepek z(x) z rdečo črtkano črto
plot(A, z_A, 'r--', 'LineWidth', 1.5);

% 3. Označimo interpolacijske točke s črnimi krogci
% y_prave so vrednosti v originalnih 9 točkah (f(x_tb))
y_prave = f(x_tb);
plot(x_tb, y_prave, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8);

% 4. Označimo še stično točko (x = 0.8), da bo jasno videti, kje se polinom p1 in p2 srečata
x_sticna = x_tb(5);
y_sticna = f(x_sticna);
plot(x_sticna, y_sticna, 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 10);

% 5. Urejanje izgleda grafa (naslovi, mrežna podlaga in legenda)
title('Primerjava prave funkcije f(x) in dobljenega zlepka z(x)');
xlabel('x');
ylabel('y');
legend('Prava funkcija f(x) = sin(7x)', 'Dobljeni zlepek z(x)', 'Interpolacijske točke', 'Stična točka (x = 0.8)', 'Location', 'best');
grid on; % Vklopi mrežo za lažje odčitavanje vrednosti


% --- REŠITEV (c): PREDZADNJI ELEMENT V 3. STOLPCU SHEME D1 ---
% V 3. stolpcu sheme, ki ima 6 vrstic, so zaradi trikotne oblike neničelni 
% le prvi 4 elementi. Predzadnji med njimi je v 3. vrstici.
% Dostopamo z indeksom (vrstica = 3, stolpec = 3).
predzadnji_3_stolpec = D1(3, 3);

% Izpis rezultata za (c)
disp(['(c) Predzadnji element v 3. stolpcu sheme za p1 je: ', num2str(predzadnji_3_stolpec)]);


% --- REŠITEV (d): RAZLIKA NAJVEČJIH ELEMENTOV MATRIK v1 IN v2 ---
% Ukaz D1(:) spremeni celotno dvodimenzionalno matriko v en dolg stolpec.
% 'abs' spremeni vse vrednosti v pozitivne, 'max' pa poišče največjo med njimi.
v1 = max(abs(D1(:))); % Največji absolutni element v shemi za p1
v2 = max(abs(D2(:))); % Največji absolutni element v shemi za p2

% Izračunamo absolutno razliko med obema najdenima maksimumoma
razlika_v = abs(v1 - v2);

% Izpis rezultata za (d)
disp(['(d) Razlika |v1 - v2| največjih absolutnih elementov je: ', num2str(razlika_v)]);


% --- REŠITEV (e): KOLIKŠNA JE NAPAKA ZLEPKA NAD MNOŽICO A ---
% Izračunamo točne vrednosti sin(7x) na 1000 točkah (to imamo že iz dela a, a za vsak slučaj ponovimo)
f_A = sin(7 * A);

% Izračunamo maksimalno odstopanje med pravo funkcijo in našim zlepkom z(x)
napaka_e = max(abs(f_A - z_A));

% Izpis rezultata za (e)
disp(['Maksimalna napaka ||f - z|| nad množico A je: ' num2str(napaka_e)]);
