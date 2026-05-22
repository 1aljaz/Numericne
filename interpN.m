function [p] = interpN(x, y)
%vrne polinom p, ki točke podane po stolpcih x in y komponent
koef = list();
n = length(x);
if length(x) ~= length(y)
    raise InputEror
end
baza = cell(n, 1);
for i = 1 : n
    baza{i} = prod([x for x = 1:5])


end