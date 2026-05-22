function [D] = dvojneDiference(x, y, dy)
%Izračuna diference za polinom, ki se ujema po točkah in odvodih
m = length(x);
xx = zeros(1, 2 * m);
xx(1 : 2 : 2 * m) = x;
xx(2 : 2 : 2* m) = x; %Prilagodimo xx, da tvori podvojitev vsake tocke
yy = zeros(1, 2 * m);
yy(1 : 2 : 2 * m) = y;
yy(2 : 2 : 2* m) = y; %Prilagodimo xx, da tvori podvojitev vsake tocke
D = NaN(2*m);
D(:, 1) = yy;
D(2 : 2 : 2*m, 2) = dy';
D(3 : 2 : 2*m, 2) = (D(3 : 2 : 2*m, 1) - D(2 : 2 : 2*m - 1, 1))./(xx(3 : 2 : 2*m) - xx(2 : 2 : 2*m - 1))';
for j = 3 : 2 * m
    D(j : 2*m, j) = (D(j :2*m, j - 1) - D (j -1 : 2*m -1, j - 1) ) ./ (xx(1, j:2*m) - xx(1,1:2*m-j+1))';
end 
end    
