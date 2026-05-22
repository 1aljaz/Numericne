function [y] = hornerNT(x, d, t)
%Posplošen hornerjev algoritem, vrne vrednost v točkah t
n = length(d);
y = t.^0 * d(n);
for i = n : -1 : 2
    y = y.*(t - x(i - 1)) + d(i-1); 
end
end