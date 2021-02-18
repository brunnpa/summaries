clc,
clear,

% Algorithmus:
% 1) Tabelle abschreiben
% 2) Konstanten aufstellen
% 3) Ableiten und grössen aufstellen
%       h(t) = v(t) = dh / dt = D1fD2fD3fDiskret(t,h);
%       dm / dh = mh = D1fD2fD3fDiskret(h,m)
% 4) Plotten
% TEIL 2: E Kin ausrechnen
% 1) TfNeq mappen auf i, x, y
% 2) Epot formel mappen auf x und y
%    * x sind die integrationsgrenzen
%    * y ist der Funktionswert der hinter dem integral steht
% 1) Aufstellen der Tabelle
t = [0 10 20 30 40 50 60 70 80 90 100 110 120];
h = [2 286 1268 3009 5375 8220 11505 15407 20127 25593 31672 38257 44931];
m = [2051113 1935155 1799290 1681120 1567611 1475282 1376301 1277921 1177704 1075683 991872 913254 880377];

R0 = 6378137;
M = 5.976e24;
G = 6.673e-11;

% Aufgabe a) Aus Tabelarischen Werten
vt = D1fD2fD3fDiskret(t,h);
at = D1fD2fD3fDiskret(t,vt);
mt = D1fD2fD3fDiskret(t,m);     % dm / dt (h)
mh = D1fD2fD3fDiskret(h,m);     % dm / dh (h)

% Plotten der 6 Grössen in einem Grafen
figure(1)   % Graph
% 3 rows, 2 colums
subplot(3,2,1); plot(t,h);xlabel("t");ylabel("h(t)");
subplot(3,2,2); plot(t,vt);xlabel("t");ylabel("v(t)");
subplot(3,2,3); plot(t,at);xlabel("t");ylabel("a(t)");
subplot(3,2,4); plot(t,m);xlabel("t");ylabel("m(t)");
subplot(3,2,5); plot(t,mt);xlabel("t");ylabel("dm/dt(t)");
subplot(3,2,6); plot(t,mh);xlabel("t");ylabel("dm/dh(t)");

%7. Plot
dm_dt   =   mh .* vt;
figure(2)
plot(t, dm_dt); hold on;
scatter(t, mt);% hold off;
title('dm/dt(t) = dm/dh(h)*v(t)');

% Aufgabe b)
R_0 = 603780137;
% Tf mappen für spätere Berechnung der Werte
TF = @(i, x, y) TfNeq(x(1:i),y(1:i));
% Ekin und EPot Funktionen aufstellen,  x und y mappen
Epot = @(i) G*M*TF(i, R0+h, m./(R0+h).^2);
Ekin = @(i) TF(i, R0+h, mt.*vt) + TF(i, R0+h, m.*at);


%WICHTIG !!!!!!!!!!!!!!!!!!!!!!¨¨
n = length(h);

% Berechnung von E-Kin und E-Pot
for i=1:n
    %Berechnung potentielle Energie und kinetische Energie zum Zeitpunkt t
    Ekin_values(i) = Ekin(i);
    Epot_values(i) = Epot(i);
end
% ETot ausrechnen
% Totale Energie
E_total = Epot_values + Ekin_values;

%Plotten Ekin Epot Etot
figure(3);
plot(t, Ekin_values, "green"); hold on;
xlabel("t");
plot(t, Epot_values, "blue"); 
plot(t, E_total, "red");
legend("Ekin", "Epot", "ETotal");
hold off;

% Aufgabe c: 
Esum        = TfNeq(t, E_Total);
E_haushalt  = 10^10;
count_haushalte = Esum / E_haushalt;
