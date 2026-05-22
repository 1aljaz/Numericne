x = [0 0.1 0.5 0.6 0.8 1 1.2 1.8 2];
f =@(x) sin(7*x);
df = @(x) 7*cos(7*x);
A = linspace(0, 2, 1000); % množica za test napake

m = length(x);
xx = zeros(1, 2 * m);
xx(1 : 2 : 2 * m) = x;
xx(2 : 2 : 2* m) = x;

%naloga1
%a
py = hornerNT(x, diag(optimDiference(x, f(x))), A);
infNorm(py, f(A))

%infNorm(interpHM(x, f(x), df(x), A), f(A))


%naloga b
%Narišemo
%{
figure
hold on
%}
t = zlepek(x, f, df, A);
%{
plot(A, t, 'r')
plot(A, f(A), 'b') 
%}


%naloga c
polovica = floor(length(x)/2);
p1x = [x(1, 1 : polovica + 1), x(polovica + 1)];
D1 = p1Diference(p1x, f(p1x), df(p1x(end)));
p2x = [x(polovica + 1), x(1, polovica + 1 : end)];
D2 = p2Diference(p2x, f(p2x), df(p2x(1)));



[n, m] = size(D1);
D1(n -1, 3)



%naloga d
v1 = max(abs(D1(:)));
v2 = max(abs(D2(:)));
abs(v2 - v1)

%naloga e
infNorm(t, f(A))


%Naloga 2
%Primer a
A = [[5 1.4 4 3]
    [1.4 3 7 1]
    [4 7 1 0]
    [3 1 0 2]];
z = [1 0 0 0]';
[l1, v] = potencna(A,z,0, 5);
l1


%Primer b
razlika = abs(potencna(A,z,0,1) - potencna(A,z,0, 4))


%primer c
[lambda1, v1] = potencna(A,z,10^(-10), inf);
hoteling = @(A, lambda, v) A - lambda * v * v';
B = hoteling(A, lambda1, v1);
[lambda2, v2] = potencna(B, z, 0, 10);
lambda2
norma = norm(v1+v2,2)