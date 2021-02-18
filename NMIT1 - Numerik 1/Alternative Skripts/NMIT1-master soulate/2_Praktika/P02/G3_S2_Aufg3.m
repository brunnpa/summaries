function G3_S2_Aufg3()
nmax = 30;
n = 6;
x = zeros(1,nmax);
x(1) = n;

% Teil 1
sn = 1;

fa = zeros(1,nmax);
fa(1) = sn;

for i = 2:nmax
    s2n = sqrt(2 - 2 * sqrt (1 - sn.^2 / 4));
    fa(i) =  2*n*s2n;
    n = 2*n;
    sn = s2n;
    x(i) = n;
end


% Teil 2
sn = 1;

fb = zeros(1,nmax);
fb(1) = sn;

for i = 2:nmax
    s2n = sqrt(sn.^2/(2*(1+sqrt(1-sn.^2/4))));
    fb(i) = 2*x(i-1)*s2n;
    sn = s2n;
end


plot(x,fa);
hold on;
plot(x,fb);
legend('Funktion a', 'Funktion b')

disp(x);

end

%Bei der Funktion A werden werden die Funktionswerte zu gross (im positiven wie auch im negativen) es gibt einen overflow.
%Es gibt Rundungsfehler und schlussendlich einen Overflow.
