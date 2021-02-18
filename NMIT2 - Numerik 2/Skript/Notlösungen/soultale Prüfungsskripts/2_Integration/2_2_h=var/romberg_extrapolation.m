function [D, D_table] = romberg_extrapolation(a,b,f,m)
%romberg_extrapolation(2,4,@(x)1./x, 3);
%ROMBERG_EXTRAPOLATION berechnet integral mittels Romberg-Extrapolation
%Trapezregel mit nicht äquidistanten Stützpunkten + some recursive magic
%führt zu Fehlerordnung 2k + 2
%Schrittreihenfolge gemäss folge hi = b-a./2.î
%a: beginn intervall
%b: ende intervall
%f: funktion
%m: Anzahl Glieder der Romberg Folge (b-a)/2^(i-1)
D = zeros(m);

if (a==b)
    return
end
for i=1:m
    h(i) = (b-a)./2.^(i-1);
    n = (b-a)./h(i);
    D(i,1) = Tf(a,b,f,n);
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


for i=1:m
    col_labels_D(i) = "Di" + string(i);
end

D_table = [col_labels_D;D];
row_labels = ["h (const)"; string(h)'];
D_table = [row_labels, D_table];
%disp(table);


end

