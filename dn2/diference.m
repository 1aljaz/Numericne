function [D] = diference(x, y)
%vrne spodnje trikotno matriko D, ki predstavlja shemo deljeih diferenc (zgornji del bodo tvorile vrednosti Nan)
%%predostavimo, da sta x, y vrstici
n = length(x);
D = NaN(n, n); %length je za vektorje size za matrike
D(:, 1) = y';
for j = 2 : n
    for i = j : n
        D(i, j) = ( D(i, j-1) - D(i-1, j - 1) ) / (x(i) - x(i -j + 1) );
    end
end


end