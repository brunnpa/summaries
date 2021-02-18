% Berechnet die Beschleunigung, Massenänderung bezüglich Zeit und Höhe und
% stellt diese in einem Plot dar.
% 
% PARAMETER
%
% RETURN
%
% SAMPLE
% [] = Gruppe10_IT17tb_S4_Aufg1()
function [] = Gruppe10_IT17tb_S4_Aufg1()

%% Konstanten definieren gemäss Aufgabenstellung
% Zeit
t = [0 10 20 30 40 50 60 70 80 90 100 110 120];
% Höhe
h = [2 286 1268 3009 5375 8220 11505 15407 20127 25593 31672 38257 44931];
% Masse
m = [2051113 1935155 1799290 1681120 1567611 1475282 1376301 1277921 1177704 1075683 991872 913254 880377];
% Erdradius
R0 = 6378137;
% Erdmasse
M = 5.976 * 10^24;
% Gravitationskonstante
G = 6.673 * 10^-11;

%% Aufgabe 1a)
vt = HELPER_S1_AUFG3A(t,h);    % v(t) Geschwindigkeit = dh/dt
at = HELPER_S1_AUFG3A(t,vt);   % a(t) Beschleunigung
dmdt = HELPER_S1_AUFG3A(t,m);  % dm/dt(t) Massenänderung pro Zeit
dmdh = HELPER_S1_AUFG3A(h,m);  % dm/dt(t) Massenänderung pro Höhe
dmdhMalvt = dmdh.* vt;  % dm/dt(t)

% Plots
%Plots
figure('Name','Serie 4 - Aufgabe 1a','NumberTitle','off');
subplot(4,2,1);
plot(t,h);
title('h(t)');


subplot(4,2,2);
plot(t,vt);
title('v(t)');

subplot(4,2,3);
plot(t,at);
title('a(t)');

subplot(4,2,4);
plot(t,m);
title('m(t)');

subplot(4,2,5);
plot(t,dmdt);
title('dm/dt(t)');

subplot(4,2,6);
plot(h,dmdh);
title('dm/dh(h)');

subplot(4,2,7);
plot(t,dmdt,'b',t,dmdhMalvt,'r:o');
title('dm/dt(t) = dm/dh(h) * v(t)');

%% Aufgabe 1b)
lengthOft = length(t);
% Arrays initialisieren
ekin = zeros(1,lengthOft);
epot = zeros(1,lengthOft);

% Kinetische und Potentielle Energie zu jedem Zeitpunkt
% HELPER_S3_AUFG4A berechnet das Integral anhand einer
% Wertetabelle
for i = 1:lengthOft
    xVektor = R0 + h(1:i);
    yVektorV = dmdt(1:i).*vt(1:i);
    yVektorA = m(1:i).*at(1:i);
    ekin(i) = HELPER_S3_AUFG4A(xVektor, yVektorV)  +  HELPER_S3_AUFG4A(xVektor, yVektorA);
    epot(i) = G * M * HELPER_S3_AUFG4A(xVektor, m(1:i)./(h(1:i) + R0).^2);
end
et = ekin + epot; 

% Plot
figure('Name','Serie 4 - Aufgabe 1b','NumberTitle','off');
hold off;
plot(t,ekin,'r--');
hold on;
plot(t,epot,'b');
plot(t,et,'g:');
legend('Kinetische Energie: E-Kin(t)', 'Potentielle Energie: E-Pot(t)', 'Gesamt Energie: E(t)');

%% Aufgabe 1c)
anzahlSchweizerHaushalte = et(lengthOft) / 10^10;
fprintf('%.0f schweizer Haushalte können für ein Jahr versorgt werden \n', anzahlSchweizerHaushalte);
% -> 63 Haushalte

end

