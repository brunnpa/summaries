clear, clc, clf;
f = @(x) 1./x;
a = 2;
b = 4;
n = 4;
f_int_analyt = @(a,b) log(b) - log(a);
[IRf] = Rf(a, b, f, n)
IRf_err = abs(IRf - f_int_analyt(a,b))
[ITf] = Tf(a, b, f, n)
ITf_err = abs(ITf - f_int_analyt(a,b))
[ISf] = Sf(a, b, f, n)
ISf_err = abs(ISf - f_int_analyt(a,b))
n_stuetzstellen = 3;
[IGf] = Gf(a,b,f,n_stuetzstellen)
IGf_err = abs(IGf - f_int_analyt(a,b))
%m=Anzahl Glider der Romberg-Folge
m=4;
[D, D_table] = romberg_extrapolation(a,b,f,m)
E = flip(tril(flip(D - f_int_analyt(a,b))));


%Berechne Integral von 0 bis 0.5 mit n=3 von f
f = @(x) eps(1).^((-x).^2);
fplot(f, [0 0.5]);
line([0.25 0.25],[0:1]);
a = 0;
b = 0.5;
n = 3;
%Analytische Lösung (Wolfram Alpha)
IRef = 0.461281;
%mit Rechtecks-Regel
IRf = Rf(a,b,f,n);
%mit Trapez-Regel
ITf = Tf(a,b,f,n);
%mit Simpson-Formel
ISf = Sf(a,b,f,n);
%mit Gauss (G3f)
IGf = Gf(a,b,f,n);

row_labels = ["IRf", "ITf", "ISf", "IGf"];
col_labels = ["Formel"; "Integral"; "Fehler"];
data = [IRf, ITf, ISf, IGf];
error = abs(data - IRef);
table = [row_labels; data; error];
table = [col_labels table];
disp(table);
[D, D_table] = romberg_extrapolation(2,4,@(x)1./x, 3);
%integral von x.2 von 
g = @(x) x.^2;
gint = @(x) (1./3).*x.^3;
%bestimmtes integral von 0 bis 2
g_int_analyt = gint(2) - gint(0);
%numerische lösung mit n = 3
g_ITf = Tf(0,2,g,3);
disp(g_int_analyt);
disp(g_ITf);