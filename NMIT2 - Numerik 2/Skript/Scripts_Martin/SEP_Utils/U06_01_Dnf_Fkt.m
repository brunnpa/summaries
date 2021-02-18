syms x
% Funktion und Startwert eintragen
f = log(x^2);
x0 = 2;

% Ableitungen berechnen
fDiff = diff(f);
fDiff2 = diff(fDiff);
fDiff3 = diff(fDiff2);

% Funktionen wieder zurückverwandeln
f = matlabFunction(f, 'vars', x);
fDiff = matlabFunction(fDiff, 'vars', x);
fDiff2 = matlabFunction(fDiff2, 'vars', x);
fDiff3 = matlabFunction(fDiff3, 'vars', x);


D1f = @(x0,h) (f(x0+h) - f(x0)) / h;
D2f = @(x0,h) (f(x0+h) - f(x0-h))/(2*h);
D3f = @(x0,h) (f(x0) - f(x0-h))/h;

% Vorwärtsdifferenz mit Diskretisierungsfehler
fprintf('Vorwärtsdifferenz\n');
fprintf('h              D1f(%d,h)         |D1f(%d,h) - fDiff(%d)|\n', x0, x0, x0);
for n = 2:17
    h = 10^(-n);
    d1f = D1f(x0,h);  
    err1 = abs(D1f(x0,h) - fDiff(x0));
    fprintf('%e   %.12f   %.12f\n', h, d1f, err1 );
end

% Optimales h berechnen 
eps = 2^(-52);
hopt1 = sqrt(4*eps * (abs(fDiff(x0))/abs(fDiff2(x0))));
fprintf('\n Das optimale h wäre: %e\n', hopt1);

% Rückwärtsdifferenz mit Diskretisierungsfehler
fprintf('\nRückwärtsdifferenz\n');
fprintf('h              D1f(%d,h)         |D1f(%d,h) - fDiff(%d)|\n', x0, x0, x0);
for n = 2:17
    d2f = D2f(x0, h);
    err2 = abs(D2f(x0, h) - fDiff(x0));
    fprintf('%e   %.12f   %.12f\n', h, d2f, err2 );
end

% Optimales h berechnen
eps = 2^(-52); %52 ist die binäre Basis
hopt2 = nthroot(6*eps * (abs(fDiff(x0))/abs(fDiff3(x0))),3);
fprintf('\n Das optimale h wäre: %e\n', hopt2);

% Zentrale Differenz mit Diskretisierungsfehler
fprintf('\nZentrale Differenz\n');
fprintf('h              D1f(%d,h)         |D1f(%d,h) - fDiff(%d)|\n', x0, x0, x0);
for n = 2:17
    d3f = D3f(x0, h);
    err3 = abs(D3f(x0, h) - fDiff(x0)); 
    fprintf('%e   %.12f   %.12f\n', h, d3f, err3 );
end