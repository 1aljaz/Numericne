% =========================================================================
% GLAVNI PROGRAM ZA 2. NALOGO: POTENČNA METODA IN HOTELLINGOVA REDUKCIJA
% =========================================================================

% --- DEFINICIJA SIMETRIČNE MATRIKE A ---
A = [5    1.4  4    3;
     1.4  3    7    1;
     4    7    1    0;
     3    1    0    2];

% Začetni približek mora biti stolpčni vektor po navodilu z0 = (1,0,0,0)
z0 = [1; 0; 0; 0];


% ---------------------------------------------------------------------
% (a) Pet korakov potenčne metode
% ---------------------------------------------------------------------
% Pokličemo funkcijo za natanko max_koraki = 5. 
% Toleranco nastavimo na 0 (ali zelo majhno), da se zanka zagotovo ne ustavi prej.
[lambda_a, z_a] = potencna(A, z0, 0, 5);

disp(['(a) Približek za dominantno lastno vrednost lambda_1 po 5 korakih je: ', num2str(lambda_a)]);


% ---------------------------------------------------------------------
% (b) Absolutna razlika med približkom po 1 koraku in po 4 korakih
% ---------------------------------------------------------------------
% Izračunamo približek po natanko 1 koraku
[lambda_1korak, ~] = potencna(A, z0, 0, 1);

% Izračunamo približek po natanko 4 korakih
[lambda_4koraki, ~] = potencna(A, z0, 0, 4);

% Izračunamo absolutno vrednost razlike
razlika_b = abs(lambda_1korak - lambda_4koraki);

disp(['(b) Absolutna razlika med 1. in 4. korakom je: ', num2str(razlika_b)]);


% ---------------------------------------------------------------------
% (c) Iskanje para (mu, v) do tolerance 10^(-10) in Hotellingova redukcija
% ---------------------------------------------------------------------
% Zaženemo metodo z visoko omejitvijo korakov (npr. 1000), a s strogo toleranco 10^(-10)
[mu, v] = potencna(A, z0, 1e-10, 1000);

% Izvedemo Hotellingovo redukcijo (deflacijo) matrike A.
% Formula iz navodila: B = A - mu * v * v^T
% Ker je v stolpec (4x1), je v*v' matrika velikosti 4x4.
B = A - mu * (v * v');

% Sedaj na REDUCIRANI matriki B naredimo natanko 10 korakov potenčne metode.
% Kot začetni vektor ponovno uporabimo z0.
[lambda_2, z_2] = potencna(B, z0, 0, 10);

disp(['(c) Približek za drugo največjo lastno vrednost lambda_2 (po 10 korakih na B) je: ', num2str(lambda_2)]);


% ---------------------------------------------------------------------
% (d) Norma vsote lastnih vektorjev ||v + z||_2
% ---------------------------------------------------------------------
% v je približek za prvi lastni vektor (iz podnaloge c)
% z je približek za drugi lastni vektor iz podnaloge c (v kodi imenovan z_2)
vsota_vektorjev = v + z_2;

% Izračunamo standardno Evklidsko normo (2-normo) tega seštevka
norma_d = norm(vsota_vektorjev, 2);

disp(['(d) Norma vsote vektorjev ||v + z||_2 je: ', num2str(norma_d)]);