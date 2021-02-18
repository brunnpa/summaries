format long
syms x
% Funktion hier eintragen
f = log(x^2);
a = 1;
b = 2;
err = 10^(-5);

% Ableitungen erstellen und gleich printen lassen um sie abzuschreiben
fDiff = diff(f)
fDiff2 = diff(fDiff)
fDiff3 = diff(fDiff2)
fDiff4 = diff(fDiff3)

% Aus den symbolischen Funktionen richtige Funktionen machen:
f = matlabFunction(f,'vars',x);
fDiff = matlabFunction(fDiff,'vars',x);
fDiff2 = matlabFunction(fDiff2,'vars',x);
fDiff3 = matlabFunction(fDiff3,'vars',x);
fDiff4 = matlabFunction(fDiff4,'vars',x);

% Linien plotten und maximaler Punkt ablesen
x = a:0.05:b;
subplot(1,3,1);
plot(x, abs(fDiff(x)));
subplot(1,3,2);
plot(x, abs(fDiff2(x)));
subplot(1,3,3);
plot(x,abs(fDiff4(x)));

% Maximum hier in der Ableitung eintragen und Ergebnis ablesen
maxDiff2 = abs(fDiff2(1))
maxDiff4 = abs(fDiff4(1))

% Neues H für die summierte Rechtechsregel
disp('Rechtecksregel');
h = sqrt((err * 24) / ((b-a) * maxDiff2))
nNeu = (b-a)/h
nNeu = ceil(nNeu)
hNeu = (b-a)/nNeu

% Neues H für die summierte Trapezregel
disp('Trapezregel');
h = sqrt((err * 12) / ((b-a) * maxDiff2))
nNeu = (b-a)/h
nNeu = ceil(nNeu)
hNeu = (b-a)/nNeu

% Neues H für die summierte Simpsonregel
disp('Simpsonregel');
h = nthroot((err * 2880) / ((b-a) * maxDiff4), 4)
nNeu = (b-a)/h
nNeu = ceil(nNeu)
hNeu = (b-a)/nNeu


