clear, clc, clf;
format long;
% zu integrierende Funktion mit m = 10
% aequivalent zu f = 10 ./ (-x.*x.^.5);)
f = @(x) -10 .* x.^-(3./2); 

%Stammfunktion
F = @(x) 20 .* x.^-(1./2);

%Bestimmtes Integral (F(b) - F(a)) => t = 4.4721s
t = (F(20) - F(5)).*-1;

v1 = 5;
v2 = 20;
n = 5;
tRf = -Rf(v1,v2,f,n);
tTf = -Tf(v1,v2,f,n);
tSf = -Sf(v1,v2,f,n);

eRf = abs(tRf - t);
eTf = abs(tTf - t);
eSf = abs(tSf - t);
disp(eRf);
disp(eTf);
disp(eSf);