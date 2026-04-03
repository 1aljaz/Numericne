function [L, U] = LUrazcep(A)
%Vrne LU razcep matrike A
n = size(A, 1)
for k = 1:(n-1) %šetam po diagonali
    D_k = A(k,k); %diagonalni element
    for i= (k+1) : (n) %šetam po vrsticah (torej ostajam v istem stolpcu in grem dol)
        A(i,k) = A(i,k) / D_k; %elt = elt/diagonalec
        for j = (k+1) : n; %šetam po stolpcih eno vrstico pod diagonalo (ostanem v isti vrstici, migam po stolpcih v desno)
            A(i,j) = A(i,j)- A(i,k)*A(k,j); %elemmentu odštejemo zmnožek eltov nad njim in levo od njega, ki se nahajajo na višini trenutnega diagonalca
        end
    end
end 
L = tril(A,-1) + eye(n);
U=triu(A);

end