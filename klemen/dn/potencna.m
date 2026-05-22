function [lambda, z] = potencna(A, z0, tol, max_koraki)
    % POTENCNA Izvede potenčno metodo za iskanje dominantnega lastnega para.
    %   A          - Kvadratna matrika
    %   z0         - Začetni približek za lastni vektor (vektor stolpec)
    %   tol        - Toleranca za ustavitev algoritma
    %   max_koraki - Maksimalno dovoljeno število iteracij

    % Poskrbimo, da je začetni vektor z0 pravilno usmerjen kot stolpec in normiran
    z = z0(:) / norm(z0(:), 2);
    
    % Inicializiramo izhodno vrednost lambda (za primer, če bi max_koraki bil 0)
    lambda = z' * A * z; 

    % Glavna zanka potenčne metode
    for k = 1:max_koraki
        % 1. Korak: Pomnožimo trenutni vektor z matriko A, da dobimo nov približek
        z_nov = A * z;
        
        % 2. Korak: Novi vektor normiramo z 2-normo (dolžino), da preprečimo preliv
        z = z_nov / norm(z_nov, 2);
        
        % 3. Korak: Izračunamo trenutni približek za lastno vrednost (Rayleighov kvocient)
        % Ker je z normiran, je z'*z = 1, zato je formula preprosto z' * A * z
        lambda = z' * A * z;
        
        % 4. Korak: Preverjanje pogoja za zaustavitev
        % Naloga zahteva testiranje norme razlike: ||A*z_k - rho(z_k,A)*z_k||_2
        razlika = A * z - lambda * z;
        reziduum = norm(razlika, 2);
        
        % Če je ostanek (reziduum) manjši od predpisane tolerance tol,
        % pomeni, da smo dosegli želeno natančnost in prekinemo zanko.
        if reziduum < tol
            break;
        end
    end
end