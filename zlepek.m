function [z] = zlepek(x, f, df, t)
%Prejme vektor točk x, funkcijo f in njen odvod f ter vektor
%%točk t in vrne vektor vrednosti zlepka z v točkah t
polovica = floor(length(x)/2);
p1x = [x(1, 1 : polovica + 1), x(polovica + 1)];
p1y = hornerNT(p1x, diag(p1Diference(p1x, f(p1x), df(p1x(end)))), t);
p2x = [x(polovica + 1), x(1, polovica + 1 : end)];
p2y = hornerNT(p2x, diag(p2Diference(p2x, f(p2x), df(p2x(1)))), t);
n = length(t);
indeksLocevanja = NaN;
for i = 1 : n
    if t(i) >= x(polovica + 1)
        indeksLocevanja = i;
        break
    end
end
z = [p1y(1, 1:indeksLocevanja-1), p2y(1, indeksLocevanja:end)];
end