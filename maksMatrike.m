function [M] = maksMatrike(D, k)
%Iz matrike poišče k največjih števil
[n, m] = size(D);
M = [D(1 : k,1)];
for i = 1 : n
    for j = 1 : m
        for l = k : -1 : 1
            if abs(D(i,j)) > M(l)
                M(l) = abs(D(i,j)); 
                break
            end
        end
    end
end
end