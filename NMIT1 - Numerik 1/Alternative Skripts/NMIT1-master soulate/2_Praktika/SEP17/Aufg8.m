%Aufg8

%a)
syms k1 k2 k3;

%p = @(k1, k2, k3) k1 * exp(k2 * r) + k3 * r

f1 = k1 * exp(k2) + k3 - 10;
f2 = k1 * exp(k2 * 2) + k3 * 2 - 12;
f3 = k1 * exp(k2 * 3) + k3 * 3 - 15;

jacobian([f1;f2;f3], [k1, k2, k3])

f = matlabFunction([f1;f2;f3]);
Df = matlabFunction(jacobian([f1;f2;f3], [k1, k2, k3]));

k0 = [10;0.1;-1];


% k3 fällt weg und ist somit irrelevant für Df
dx0 = Df(k0(1), k0(2));
fx0 = f(k0(1), k0(2), k0(3));
delta = dx0 \ - fx0;
k1 = k0 + delta;

%k2
dx1 = Df(k1(1), k1(2));
fx1 = f(k1(1), k1(2), k1(3));
delta = dx1 \ -fx1
k2 = k1 + delta

%k3
dx2 = Df(k2(1), k2(2));
fx2 = f(k2(1), k2(2), k2(3));
delta = dx2 \ -fx2
k3 = k2 + delta

f(k3(1), k3(2), k3(3))
norm(k3-k2)


%b)
syms r;
equ = 500 == 8.7884*exp(0.2699*r)-1.4876*r;
%dies sollte eigentlich mit newton gelöst werden
simplify(solve(equ, r));