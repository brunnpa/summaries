m = 1500;
t = 0:0.01:0.08;
v = [13.0 12.5 11.9 9.8 4.4 2.3 0.9 0.3 0.0];

% Teilaufgabe a
D1f = @(y, yNext, x, xNext) (yNext - y) / (xNext-x);
D2f = @(yPrev, yNext, xPrev, xNext) (yNext - yPrev) / (xNext - xPrev);
D3f = @(yPrev, y, xPrev, x) (yPrev - y) / (xPrev - x);

iMax = length(t);
a = zeros(length(t), 1);

for i = 1:iMax 
    if (i == 1) % Erste Zeile: Vorwärtsdifferenz
        a(i) = D1f(v(i), v(i+1), t(i), t(i+1));
    elseif (i == iMax) % Letzte Zeile: Rückwärtsdifferenz
        a(i) = D3f(v(i-1), v(i), t(i-1), t(i));
    else % Alles in der Mitte: Zentraldifferenz
        a(i) = D2f(v(i-1), v(i+1), t(i-1), t(i+1));
    end
end

plot(t, v, t, a);

% Teilaufgabe b
s = zeros(length(t),1);
Tf = 0;
for i=1:length(t)-1
    s(i) = sum(s) + (v(i) + v(i+1))/2 * (t(i+1) - t(i));
end
hold on;
plot(t,s);
hold off;
smax = s(end);
fprintf('Die zurückgelegte Strecke nach 0.08s ist: %.5f\n', smax);

% Teilaufgabe c
f = @(a) m * a;
a = 0;
b = smax;
n = 9;

h = (b-a)/n;
Ekin = (f(a) + f(b))/2;
for i=1:(n-1)
    Ekin = Ekin + f(a+i*h);
end


Ekin = h * Ekin;
fprintf('Die kinetische Energie nach 0.08s ist: %.5f\n', Ekin);