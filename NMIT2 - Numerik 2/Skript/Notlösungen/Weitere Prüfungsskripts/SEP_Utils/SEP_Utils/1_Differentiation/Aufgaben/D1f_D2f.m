% Konfiguraiton
%-----------------------------------
% Funktion
f = @(x) log(x^2);
% Startwert
x0 = 1;

% Aufgabe: Vergleich von D1f und D2f mit verschiedneen Schrittweiten
fprintf(' --------\n');
fprintf('| Teil 1 |\n');
fprintf(' --------\n');
fprintf('h              D1f(%d,h)         |D1f(%d,h) - fDiff(%d)|    D2f(%d,h)         |D2f(%d-h)-fDiff(%d)| \n', x0, x0, x0, x0, x0, x0);

%anzahlSchrittweiten
totalSteps = 7;
for n = 1:totalSteps
    h       = 10^(-2 * n);
    d1f     = D1f(h, x0, f);
    d1err   = D1fErr(h, x0, f);
    d2f     = D2f(h, x0, f);
    d2err   = D2fErr(h, x0, f);
    fprintf('%e   %.12f   %.12f           %.12f   %.12f\n', h, d1f, d1err, d2f, d2err );
end

% Optimale Schrittweite D1f
fprintf(' --------\n');
fprintf('| Teil 2 |\n');
fprintf(' --------\n');
eps     = epsAccuracy(2, 52);
hopt1   = hOptD1f(eps, x0, f);
hopt2   = hOptD2f(eps, x0, f);
d1f     = D1f(hopt1, x0, f);
d1err   = D1fErr(hopt1, x0, f);
fDiff1  = diff1(f);
d2f     = D2f(hopt2, x0, f);
d2err   = D2fErr(hopt2, x0, f);

fprintf('Optimale Schrittlaenge: %e\n', hopt1);
fprintf('h              D1f(%d,h)         |D1f(%d,h) - fDiff(%d)|\n', x0, x0, x0);
fprintf('%e   %.12f   %.12f\n', hopt1, d1f, d1err);

h       = 10^(-8);
d1f     = D1f(h, x0, f);
d1err   = D1fErr(h, x0, f);
fprintf('%e   %.12f   %.12f\n', 10^(-8), d1f, d1err);

fprintf(' --------\n');
fprintf(' --------\n');
% Optimale Schrittweite D2f

fprintf('Optimale Schrittlaenge: %e\n', hopt2);
fprintf('h              D1f(%d,h)         |D2f(%d,h) - fDiff(%d)|\n', x0, x0, x0);
fprintf('%e   %.12f   %.12f\n', hopt2, d2f, d2err);

h       = 10^(-8);
d2f     = D2f(h, x0, f);
d2err   = D2fErr(h, x0, f);
fprintf('%e   %.12f   %.12f\n', 10^(-8), d2f, d2err);


