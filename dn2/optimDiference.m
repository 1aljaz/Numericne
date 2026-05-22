function [D] = optimDiference(x, y)
%Optimizirane diference -> vekotrji
m = length(x);
D = NaN(m, m); %length je za vektorje size za matrike
D(:, 1) = y';
for j = 2 : m
    D(j : m, j) = (D(j :m, j - 1) - D (j -1 : m -1, j - 1) ) ./ (x(1, j:m) - x(1,1:m-j+1))'; % namesto for loopov zdaj odštevamo vektorje
end