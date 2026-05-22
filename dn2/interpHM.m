function [u] = interpHM(x,y, dy, t)
%Vrne vrednost hermitskega interpolacijskega polinoma
d = diag(dvojneDiference(x, y, dy));

m = length(x);
xx = zeros(1, 2 * m);
xx(1 : 2 : 2 * m) = x;
xx(2 : 2 : 2* m) = x; %Prilagodimo xx, da tvori podvojitev vsake tocke
xx = xx';

u = hornerNT(xx, d, t);
end