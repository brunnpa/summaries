function G3_S4_Aufg3()
clear;
func =@(x) x^2 -2;
a = 0;
b = 2;

% Teil 1
[root,xit,n] = G3_S4_Aufg2(func,a,b,10^-15);

fehler = abs(xit - root);

subplot(1,2,1);
semilogy(fehler);



% Teil 2

iterations = [];
y=1:1:n;
tols = logspace(-1,-15,15);
for i=1:numel(tols)
    [root,xit,n] = G3_S4_Aufg2(func, a, b, tols(i));
    iterations = [iterations; n];
end

subplot(1,2,2);
loglog(tols, iterations);

%Begruendung:
%Die Unebenheiten enstehen weil die absoluten Fehler der ereichneten Werte
%links und rechts von der Nullstelle jeweil unterscheiden.
%D.h. der absolute Fehler wird nicht immer vom einen zum naechsten Schritt kleine.
