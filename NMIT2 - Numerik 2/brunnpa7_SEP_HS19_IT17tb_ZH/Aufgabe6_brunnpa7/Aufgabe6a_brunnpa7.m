% x und y Werte erfassen ---EDIT
x = [0.05 0.1 0.3 0.5 0.8]';
y = [1.7 2.8 4.5 4.9 5.0]';

% Startvektor ---EDIT
lambda0 = [2 2]';

% Fehlertoleranz ---EDIT
tol = 10^-(4);

% Maximum Iterationen ---EDIT
nmax = 50;

% Maximaler Dämpfungsfaktor ---EDIT
kmax = 20;

% Parameter aus der Funktion ---EDIT
syms x0 delta

% Funktion erstellen ---EDIT
f = x0 .* (1- exp(1)^(-delta.*x));

% Jacobi-Matrix für die Funktion erstellen
Df = jacobian(f, [x0 delta]);

% Funktion und Jacobi-Matrix in matlab Funktionen umwandeln
Df = matlabFunction(Df, 'vars', [x0 delta]);
f = matlabFunction(f, 'vars', [x0 delta]);

% Funktionen für Vektoren öffnen --EDIT (so viele wie oben Parameter)
DfVec = @(x) Df(x(1), x(2), x(3), x(4), x(5));
fVec = @(x) f(x(1), x(2), x(3), x(4), x(5));

% Lösung steht zum Schluss in xn
xn = lambda0;
err = tol + 1;
% Anzahl gebrauchter Iterationen
n = 0;

while err > tol && n < nmax
    DftDf = DfVec(xn)'*DfVec(xn);
    Dftf = -DfVec(xn)'*fVec(xn);
    delta = DftDf\Dftf;
    k = 0;
    while (norm(fVec(xn+delta/2^k),2))^2 >= (norm(fVec(xn),2))^2 && k <= kmax
        k = k+ 1;
    end
    if (k == kmax + 1)
        k = 0;
    end
    xn = xn + delta/2^k;
    err = norm(delta/2^k,2);
    n = n+1;
end
disp(xn)

disp(n)
