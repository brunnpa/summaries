% x und y hier eintragen
ti = [0 10 20 30 40 50 60 70 80 90 100 110];
pt = [76 92 106 123 137 151 179 203 227 250 281 309];

% x und y transponieren, damit es dem Skript entspricht
ti = ti';
pt = pt';

% Polynom 1 berechnen
f1 = @(x) x.^3;
f2 = @(x) x.^2;
f3 = @(x) x; 
f4 = @(x) ones(size(x));

p1 = polynomOrdnung4(ti, pt,  f1, f2, f3, f4);

% Polynom 2 berechnen
f1 = @(x) x.^2;
f2 = @(x) x;
f3 = @(x) ones(size(x)); 

p2 = polynomOrdnung3(ti, pt,  f1, f2, f3);

% Punkte und Polynom plotten
plot(ti,pt,'o',ti,p1(ti),ti, p2(ti));

disp(norm(pt-p1(ti),2)^2);
disp(norm(pt-p2(ti),2)^2);
% Das Fehlerfunktional des ersten Polynoms ist kleiner, deshalb ist das
% Polynom p1 optimaler, als das Polynom p2

function [p] = polynomOrdnung4(ti, pt,  f1, f2, f3, f4)
     % Matrix A berechnen
    A =[f1(ti), f2(ti), f3(ti), f4(ti)];
   
    % Lambdas berechnen
    AtA = A'*A;
    Aty = A'*pt;
    lambda = AtA\Aty;

    % Das Polynom zusammensetzen (hier Lambdas + fn wegnehmen oder hinzufügen)
    p = @(x) lambda(1) .* f1(x) + lambda(2) .* f2(x) + lambda(3) .* f3(x) + lambda(4) .* f4(x);
end

function [p] = polynomOrdnung3(ti, pt,  f1, f2, f3)
     % Matrix A berechnen
    A =[f1(ti), f2(ti), f3(ti)];

    % Lambdas berechnen
    AtA = A'*A;
    Aty = A'*pt;
    lambda = AtA\Aty;

    % Das Polynom zusammensetzen (hier Lambdas + fn wegnehmen oder hinzufügen)
    p = @(x) lambda(1) .* f1(x) + lambda(2) .* f2(x) + lambda(3) .* f3(x);
end
