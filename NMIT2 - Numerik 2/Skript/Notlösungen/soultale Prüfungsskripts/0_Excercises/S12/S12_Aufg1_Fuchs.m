% NMIT2 - Serie 12, Aufgabe 1
% Script

format compact; format shortE; clear all; clc;

t = [0.1 0.3 0.7 1.2 1.6 2.2 2.7 3.1 3.5 3.9]';
y = [0.558 0.569 0.176 -0.207 -0.133 0.132 0.055 -0.090 -0.069 0.0271];
lambda0 = [1 2 2 1]';

syms x1 x2 x3 x4
g = y' - (x1 .* exp(-x2.*t) .* sin(x3.*t + x4));

Dg = jacobian(g,[x1,x2,x3,x4])

Dgvec = matlabFunction(Dg,'vars',[x1,x2,x3,x4]);
test_dg = Dgvec(lambda0(1),lambda0(2),lambda0(3),lambda0(4));
gvec = matlabFunction(g,'vars',[x1,x2,x3,x4]);

k = 1;
lambda(:,k) = lambda0;
tol = 1e-5;
err = tol + 1;

while (err > tol)
    Dg_eval = Dgvec(lambda(1,k),lambda(2,k),lambda(3,k),lambda(4,k));
    g_eval = gvec(lambda(1,k),lambda(2,k),lambda(3,k),lambda(4,k));
    delta(:,k) = (Dg_eval' * Dg_eval) \ (-Dg_eval' * g_eval);
    lambda(:,k+1) = lambda(:,k) + delta(:,k);
    
    err = abs(norm(gvec(lambda(1,k+1),lambda(2,k+1),lambda(3,k+1),lambda(4,k+1)),2)^2 - ...
            norm(gvec(lambda(1,k),lambda(2,k),lambda(3,k),lambda(4,k)),2)^2);
    k = k+1;
end

x0 = lambda(1,k)
delta = lambda(2,k)
omega = lambda(3,k)
phi0 = lambda(4,k)

x = @(t) x0 .* exp(-delta .* t) .* sin(omega .* t + phi0);

figure('name','NMIT2 - Serie 12, Aufgabe 1');
plot(t,x(t),t,y);
xlabel('t [s]');
ylabel('x(t) [m]');
grid on;
legend('Messung','Lˆsung f¸r x(t)','location','best');
