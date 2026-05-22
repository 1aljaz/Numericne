function [lambda, z] = potencna(A,z0, tol, max_koraki)
%Za matriko A in približek lastnega vektorja z0
%%izračuna dominantni lastni par lambda, z
rayl = @(z, y) z' * y;
k = 0;
y = A*z0;
z = z0;
r = rayl(z,y);
while (norm(y-r*z,2)>=tol) && (k<max_koraki)
    k = k+1;
    z = y/norm(y,2);
    y = A*z;
    r = rayl(z,y);
end
lambda = r;
end