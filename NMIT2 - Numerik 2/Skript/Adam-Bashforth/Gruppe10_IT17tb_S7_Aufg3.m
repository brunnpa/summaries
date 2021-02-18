%% Aufgabe 3a) & 3b)

% Initialisieren Fehlervektoren
abs_err_ab4 = zeros(8,1);
time_ab4 = zeros(8,1);
abs_err_rk4 = zeros(8,1);
time_rk4 = zeros(8,1);

n = [10^1,10^2,10^3,10^4,10^5,10^6,10^7,10^8];

for i=1:7
    tic % Start Zeit
    [x, yab4] = Gruppe10_IT17tb_S7_Aufg2(@(x,y) y ,0,1,10^i, 1);
    abs_err_ab4(i) = abs(yab4(end)-exp(1));
    time_ab4(i) = toc; % End Zeit
    
    fprintf('Adam Bashforth \t -> 10^%i berechnet: %f in ca. %f Sekunden \n',i, yab4(10^i),time_ab4(i));
end

for i=1:7
    tic % Start Zeit
    [x, yrk4] = HELPER_S6_RUNGE_KUTTA(@(x,y) y ,0,1,10^i, 1);
    abs_err_rk4(i) = abs(yrk4(end)-exp(1));
    time_rk4(i) = toc; % End Zeit
    fprintf('Runge Kutta \t -> 10^%i berechnet: %f in ca. %f Sekunden \n',i, yrk4(10^i),time_rk4(i));
end

% Drucken Resultate für Runge Kutta und Adam Bashforth nach 10^i
plot(x,yab4,x,yrk4);
hold on;
grid on;
title('Adam Bashforth 4. Ordnung vs. Runge Kutta 4. Ordnung');
xlim([0, 1]);
legend('Adam Bashforth','Runge Kutta');
hold off;

% Drucken der Fehler
figure
semilogy(abs_err_ab4);
hold on;
grid on;
semilogy(abs_err_rk4);
title('Absoluter Fehler');
legend('Aadam Bashforth 4. Ordnung', 'Runge Kutta 4. Ordnung');
xlabel('Anzahl Schritte');
ylabel('Fehlermass');
xlim([1 7])

% Drucken der Zeit
figure
plot(time_ab4);
hold on;
grid on;
plot(time_rk4);
title('Rechenzeit [s]');
legend('Adam Bashforth 4. Ordnung', 'Runge Kutta 4. Ordnung');
xlabel('Anzahl Schritte');
ylabel('Zeit [s]');
xlim([1 7]);

%% 3.c)
% Bei tiefer Anzahl Schritte hat die Runge Kutta Methode einen
% kleineren Fehler als die Bashforth Methode.

% Erst ab n = 10^5 ist eine unterschiedliche Berechnungszeit erkennbar. 
%
% Die Genauigkeit ist ab 10^2 identisch (auf 6 Nachkommastellen)
%
% Adam Bashforth ist generell langsamer zum Berechnen
