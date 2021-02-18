%Aufg7
A=[10 4 2; 5 20 8; 15 5 30];
b=[62;116;280];

% b)
x0 = [3;2;6];

D = triu(tril(A))
L = tril(A) - D
R = triu(A) - D

jaco = @(xn) -D^-1 * (L+R) * xn + D^-1 * b;

x1 = jaco(x0)
x2 = jaco(x1)

% c)
B = -D^-1 * (L+R);

n = log((10^-4 * (1- norm(B, inf))) / norm(x1-x0, inf)) / log(norm(B, inf));
n = ceil(n)