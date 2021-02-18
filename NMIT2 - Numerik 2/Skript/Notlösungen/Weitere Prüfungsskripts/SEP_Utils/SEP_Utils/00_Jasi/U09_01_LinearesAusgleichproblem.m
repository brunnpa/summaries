% x und y hier eintragen
x = [0 10 20 30 40 50 60 70 80 90 100];
y = [999.9 999.7 998.2 995.7 992.2 988.1 983.2 977.8 971.8 965.3 958.4];
% Falls ein logarithmisches Problem auftaucht S. 150
% y = log(y)

% x und y transponieren, damit es dem Skript entspricht
x = x';
y = y';

% f1 .. fm hier eintragen
f1 = @(x) x.^2;
f2 = @(x) x;
f3 = @(x) ones(size(x));

% Matrix A berechnen
A =[f1(x), f2(x), f3(x)];

% Lambdas berechnen
AtA = A'*A;
Aty = A'*y;
lambda = AtA\Aty;

% Das Polynom zusammensetzen (hier Lambdas + fn wegnehmen oder hinzufügen)
p = @(x) lambda(1) .* f1(x) + lambda(2) .* f2(x) + lambda(3) .* f3(x);

% Punkte und Polynom plotten
plot(x,y,'o',x,p(x));

% Konditionszahl berechnen
kondition = cond(A'*A, inf);
% Falls die Konditionszahl hoch ist, wirken sich Fehler in den einzelnen
% Werten stark auf die resultierenden Lambdas aus.

% Polynom der Länge 3 mit der MATLAB Funktion herausfinden & Differenz
% ausgeben
poly = polyfit(x,y,2);
abs(lambda(1)-poly(1))
abs(lambda(2)-poly(2))
abs(lambda(3)-poly(3))