% x und y Werte erfassen ---EDIT
x = [0.1 0.3 0.7 1.2 1.6 2.2 2.7 3.1 3.5 3.9]';
y = [0.558 0.569 0.176 -0.207 -0.133 0.132 0.055 -0.090 -0.069 0.027]';

% Startvektor ---EDIT
lambda0 = [1 2 2 1]';
% Fehlertoleranz ---EDIT
tol = 10^-(5);
% Maximum Iterationen ---EDIT
nmax = 50;
% Parameter aus der Funktion ---EDIT
syms x0 delta omega phi0
% Funktion erstellen ---EDIT
f = y - (x0 .* exp(-delta.*x).*sin(omega.*x+phi0));

% Jacobi-Matrix für die Funktion erstellen
Df = jacobian(f, [x0 delta omega phi0]);

% Funktion und Jacobi-Matrix in matlab Funktionen umwandeln
Df = matlabFunction(Df, 'vars', [x0 delta omega phi0]);
f = matlabFunction(f, 'vars', [x0 delta omega phi0]);

% Funktionen für Vektoren öffnen --EDIT (so viele wie oben Parameter)
DfVec = @(x) Df(x(1), x(2), x(3), x(4));
fVec = @(x) f(x(1), x(2), x(3), x(4));

% Lösung steht zum Schluss in xn
xn = lambda0;
err = tol + 1;
% Anzahl gebrauchter Iterationen
n = 0;

while(err >= tol && n < nmax)
    DftDf = DfVec(xn)'*DfVec(xn);
    Dftf = -DfVec(xn)'*fVec(xn);
    delta = DftDf\Dftf;
    xn = xn + delta;
    err = norm(delta,2);
    n = n+1;
end
disp(xn) % Ergebnis stimmt so

f = @(t) xn(1)*exp(-xn(2)*t).*sin(xn(3)*t+xn(4));
xx = 0:0.01:4;
plot(x,y,'bo', xx, f(xx));

% Für diese Aufgabe wird es zwischen den beiden Verfahren keine
% Unterschiede geben


% Verwendung von fminsearch
E = @(x) (norm(fVec(xn),2))^2;
xn_fmin = fminsearch(E,lambda0)