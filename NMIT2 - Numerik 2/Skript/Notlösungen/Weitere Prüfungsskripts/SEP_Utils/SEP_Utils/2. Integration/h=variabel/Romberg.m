function    [D, D_table]    =   Romberg(a,b,f,m)
% Test:     [D, D_table]    =   Romberg(2,4,@(x)1./x, 3);
%                           =   
% ! ACHTUNG: i = 0, 1, 2, 3 => m = 4, da 4 Werte in erste Spalte
% !!!!!!!!!!!!!!!!!!!!!!!!!!!!
% Desc:
%       * Berechnet ein Integral mit der Trapezregel
%       * mittels nicht Äquidistanten Stützpunkten
%       * in einem rekursiven Algorithmus
%       * Fehlerordnung O(k) = 2k+2
%       * Schrittreihenfolge hi = b-a./2.*i
% Params:
% a:    beginn intervall
% b:    ende intervall
% f:    funktion
% m:    Anzahl Glieder der Romberg Folge (b-a)/2^(i-1)

D = zeros(m);

if (a==b)
    return
end

for i=1:m
    h(i)    = (b-a)./2.^(i-1);
    n       = (b-a)./h(i);
    D(i,1)  = TfSumIterative(a,b,f,n);
end

for k=2:m
    for i=1:(m-k+1)
        Dnext = D(i+1,k-1);
        Dprev = D(i,k-1);
        z = 4.^(k-1).*Dnext - Dprev;
        n = 4.^(k-1) - 1;
        D(i,k) = z./n;
    end
end

row_header = ["h"; string(h)'];

col_header_e = strings([1,m]);
col_header_d = strings([1,m]);

for i=1:m
    col_header_e(i) = "Ei" + string(i-1);
    col_header_d(i) = "Ti" + string(i-1);
end

DTable = [col_header_d;D];
DTable = [row_header, DTable];
disp(DTable);
disp(D);
end

