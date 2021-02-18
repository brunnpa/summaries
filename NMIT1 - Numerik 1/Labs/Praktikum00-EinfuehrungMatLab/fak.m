function y = fak(n)

%FAK y = fak(n) berechnet die Fakultät von n
%fak(n) = n * fak(n-1), fak(0) = 1
%Fehler, falls n < 0 oder nicht ganzzahlig

if n < 0 || fix(n) ~=n
    error('ERROR: Fak ist nur für nicht-negative, ganze Zahlen definiert')
end

if n <= 1
    y = 1;
else
    y = n*fak(n-1);
end