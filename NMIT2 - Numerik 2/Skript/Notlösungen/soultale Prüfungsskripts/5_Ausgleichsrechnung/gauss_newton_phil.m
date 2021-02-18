clear;
clc;
hold off;
close all;

%% Normales Gauss-Newton-Verfahren
t = [0.1 0.3 0.7 1.2 1.6 2.2 2.7 3.1 3.5 3.9]'; % x-Wert
y = [0.558 0.569 0.176 -0.207 -0.133 0.132 0.055 -0.090 -0.069 0.027];
%y-Wert

% symbolische Variablen f�r die Variablen, die in der Funktion vorkommen
syms x0 delta omega phi; % Edit
toleranz = 10e-6; % Edit
% Start-lambda
lambda = [1 2 2 1]'; % Edit
% auszugleichende Funktion
f = x0.*exp(-delta.*t).*sin(omega.*t+phi); % Edit
g = y'-(f);
disp('g');
disp(g);
g_mat = matlabFunction(g, 'vars', {[x0;delta;omega;phi]}); % Edit
Dg = jacobian(g, [x0,delta,omega,phi]); % Edit
disp('Dg(x0, delta, omega, phi)');
disp(Dg);
Dg_mat = matlabFunction(Dg, 'vars', {[x0;delta;omega;phi]}); % Edit
i = 1;
tol_reached = false;
% normales Newton-Verfahren
while ~tol_reached
    delta_sol = (Dg_mat(lambda(:,i))'*Dg_mat(lambda(:,i)))\(-Dg_mat(lambda(:,i))'*g_mat(lambda(:,i)));
    i = i + 1;
    lambda(:,i) = lambda(:,i-1) + delta_sol;
    if norm(delta_sol, inf) < toleranz
        tol_reached = true;
    end
end

% plot normales gauss_newton
t_plot = 0:0.01:4;
y_plot = lambda(1,i)*exp(-lambda(2,i)*t_plot).*sin(lambda(3,i)*t_plot+lambda(4,i)); % Edit
plot(t_plot, y_plot);
grid on;
hold on;
plot(t, y, 'o');

%% ged�mpftes Gauss-Newton-Verfahren
p_max = 5;
i = 1;
tol_reached = false;
lambda_ged = lambda(:,1);

while ~tol_reached
    delta_sol_ged = (Dg_mat(lambda_ged(:,i))'*Dg_mat(lambda_ged(:,i))\(-Dg_mat(lambda_ged(:,i))'*g_mat(lambda_ged(:,i))));
    p_min = 0;
    for p = 1:p_max
        if norm(g_mat(lambda_ged(:,i)+(delta_sol_ged)/2^p)) < norm(g_mat(lambda_ged(:,i)))
            p_min = p;
            break;
        end
    end
    i = i + 1;
    lambda_ged(:,i) = lambda_ged(:,i-1) + delta_sol_ged/2^p_min;
    if norm(delta_sol_ged/2^p_min) < 10e-6
        tol_reached = true;
    end
end

% plot ged�mpftes Gauss-Newton-Verfahren
t_plot = 0:0.01:4;
y_plot = lambda_ged(1,i)*exp(-lambda_ged(2,i)*t_plot).*sin(lambda_ged(3,i)*t_plot+lambda_ged(4,i));
hold on;
plot(t_plot, y_plot, '-');
legend('Gauss-Newton','Data','ged. Gauss-Newton');