% Bestimmt die Parameter für eine Formel mit dem Gauss Newton Verfahren
% aufgrund von Messdaten
%
% Messdaten gemäss Aufgabenstellung
xi = [0.1 0.3 0.7 1.2 1.6 2.2 2.7 3.1 3.5 3.9];
xi = xi';
yi = [0.558 0.569 0.176 -0.207 -0.133 0.132 0.055 -0.090 -0.069 0.027];
yi = yi';

% Parameter die berechnet werden sollen
syms x0; % Anfangsamplitude
syms delta; % Abklingkonstante
syms omega; % Kreisfrequenz
syms phi0; % Nullphasenwinkel

% Formel gemäss Aufgabenstellung
formel = @(t) x0 * exp(-delta*t) .* sin(omega*t + phi0);
% Schritt 1 gedämpftes/ungedämpftes Newton Verfahren
g = yi - formel(xi);
Dg = jacobian(g, [x0; delta; omega; phi0]);
% MatlabFunction erstellt eine Funktion aus symbolischen Variablen
% syms x y -> r = sqrt(x^2 + y^2); -> ht = matlabFunction(r) -> @(x,y)sqrt(x.^2+y.^2)
g = matlabFunction(g, 'vars', {[x0; delta; omega; phi0]});
Dg = matlabFunction(Dg, 'vars', {[x0; delta; omega; phi0]});

%% Aufgabe a und b)
%% Gauss-Newton ungedaempft
% Vorbereitungen
tol = 1e-6;
lambda = [1 2 2 1]'; % Gemäss Aufgabenstellung
delta = ones(size(lambda));
while norm(delta, inf) > tol
    DgNormal = Dg(lambda);
    DgTrans = DgNormal';
    gNormal = g(lambda);
    % Formel: DgTrans * DgNormal * delta = -DgTrans * gNormal
    % delta = -DgTrans * gNormal * inv(DgTrans * DgNormal)
    % -> delta = (DgTrans * DgNormal) \ (-DgTrans * gNormal)
    delta = (DgTrans * DgNormal) \ (-DgTrans * gNormal);
    lambda = lambda + delta;
end
% Resultate
x0 = lambda(1);
delta = lambda(2);
omega = lambda(3);
phi0 = lambda(4);
formel = @(t) x0 * exp(-delta*t) .* sin(omega*t + phi0);

% Grafische Darstellung
plot(xi, yi, '*');
hold on
t = 0:0.01:4;
plot(t,formel(t));

%% Gauss-Newton gedämpft
pmax = 5; % Maximale Anzahl durch 2 Divisionen
lambda = [1 2 2 1]';
delta = ones(size(lambda));
tol = 1e-6;
while norm(delta, inf) > tol
    DgNormal = Dg(lambda);
    DgTrans = DgNormal';
    gNormal = g(lambda);
    % Formel: DgTrans * DgNormal * delta = -DgTrans * gNormal
    % delta = -DgTrans * gNormal * inv(DgTrans * DgNormal)
    % -> delta = (DgTrans * DgNormal) \ (-DgTrans * gNormal)
    delta = (DgTrans * DgNormal) \ (-DgTrans * gNormal);
    delta_found = false;
    found = false;
    p = 0;
    for i = 0:pmax
        if found == false % solange nicht gefunden, erhöhe p um 1 und rechne nochmals
            bruch = delta/(2^i);
            if norm(g(lambda+bruch)) < norm(g(lambda))
                found = true;
                p = i;
            end
        end
    end
    
    if found == false
        p = 0;
    end
    
    lambda = lambda + delta/(2^p);
 end

%% Grafische Darstellung
% Resultate
x0 = lambda(1);
delta = lambda(2);
omega = lambda(3);
phi0 = lambda(4);
formel = @(t) x0 * exp(-delta*t) .* sin(omega*t + phi0);

plot(t,formel(t));
legend('punkte','ungedaempft','gedaempft');