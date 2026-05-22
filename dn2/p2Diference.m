function [D] = p2Diference(x, y, dy)
%Optimizirane diference -> vekotrji (za prvi elt prilagojen v odvodu)
m = length(x);
D = NaN(m, m); %length je za vektorje size za matrike
D(:, 1) = y';
for j = 2 : m
    if j==2
        D(j + 1 : m, j) = (D(j + 1 :m, j - 1) - D (j : m -1, j - 1) ) ./ (x(1, j +1:m) - x(1, j:m-1))';
        D(j, j) = dy;
    else
        D(j : m, j) = (D(j :m, j - 1) - D (j -1 : m -1, j - 1) ) ./ (x(1, j:m) - x(1,1:m-j+1))'; % namesto for loopov zdaj odštevamo vektorje
    end
end