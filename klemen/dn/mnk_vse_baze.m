% =========================================================================
% UNIVERZALNA ŠABLONA ZA METODO NAJMANJŠIH KVADRATOV (MNK)
% =========================================================================

% --- 1. SPREMENI PODATKE TUKAJ ---
x = [2007:2022]'; % Primer let iz tvoje datoteke
% Vektor y (podatki) - npr. prodaja telefonov
y = [122 139 172 296 472 680 969 1244 1423 1495 1536 1556 1540 1351 1433 1395]';

% --- 2. SPREMENI BAZNE FUNKCIJE TUKAJ ---
% Če naloga zahteva f(x) = c0 + c1*x + c2*x^2 + c3*e^x, jih zapišeš spodaj:
baza1 = @(x) ones(size(x));      % Za konstanto c0
baza2 = @(x) x - 2007;           % Za linearni del (kot v nalogi)
baza3 = @(x) (x - 2007).^2;      % Za kvadratni del
baza4 = @(x) exp((x - 2007)/10); % Za eksponentni del

% --- 3. GRADNJA MATRIKE A (Aproksimacijska matrika) ---
% Vsak stolpec matrike A pripada eni bazni funkciji, izračunani v točkah x.
A = [baza1(x), baza2(x), baza3(x), baza4(x)];
b = y; % Desna stran sistema so izmerjene vrednosti

% --- 4. REŠEVANJE PREKO QR RAZCEPA (Householder / Givens simulacija) ---
% Matlabov [Q, R] = qr(A, 0) vrne ekonomični razcep, ki se obnaša kot
% tisto, kar zahtevajo naloge (Givens/Householder).
[Q, R] = qr(A, 0); 
z = Q' * b;
c_koef = R \ z; % Izračunani koeficienti c0, c1, c2...

% --- MOREBITNA VPRAŠANJA NA KVIZU IN KAKO JIH REŠIŠ: ---
% Vprašanje: Koliko je ||A||_F (Frobeniusova norma)? -> norm(A, 'fro')
% Vprašanje: Napoved za leto 2026? 
leto = 2026;
napoved = c_koef(1)*baza1(leto) + c_koef(2)*baza2(leto) + c_koef(3)*baza3(leto) + c_koef(4)*baza4(leto);

disp(['Napoved za 2026: ', num2str(napoved)]);