% 3.a)
for i=1:7
[x, yab4] = Berg_Michael_Brunner_Pascal_IT17tb_G2_S7_Aufg2(@(x,y) y ,0,1,10^i, 1);
plot(x,yab4);
hold on;
title('Adam Bashforth 4. Ordnung');
grid minor;
xlim([0, 1]);
fprintf('Graph: %i fertig \n',i);
end
legend('10^1','10^2','10^3','10^4','10^5','10^6','10^7');
figure

for i=1:7
[x, yrk4] = Berg_Michael_Brunner_Pascal_Gruppe2_S6_Aufg1(@(x,y) y ,0,1,10^i, 1);
plot(x,yrk4);
hold on;
title('Runge Kutta 4. Ordnung');
grid minor;
xlim([0, 1]);
fprintf('Graph: %i fertig \n',i);
end
legend('10^1','10^2','10^3','10^4','10^5','10^6','10^7');
figure 

% 3.b)
abs_err_rk4 = zeros(8,1);
time_rk4 = zeros(8,1);
abs_err_ab4 = zeros(8,1);
time_ab4 = zeros(8,1);

n = [1e1,1e2,1e3,1e4,1e5,1e6,1e7,1e8];

for i=1:7
tic
[~, yrk4] = Berg_Michael_Brunner_Pascal_Gruppe2_S6_Aufg1(@(x,y) y ,0,1,10^i, 1);
abs_err_rk4(i) = abs(yrk4(end)-exp(1));
time_rk4(i) = toc;
tic
[~, yab4] = Berg_Michael_Brunner_Pascal_IT17tb_G2_S7_Aufg2(@(x,y) y ,0,1,10^i, 1);
abs_err_ab4(i) = abs(yab4(end)-exp(1));
time_ab4(i) = toc;
fprintf('Graph: %i fertig \n',i);
end

semilogy( abs_err_ab4);
hold on;
grid minor;
semilogy( abs_err_rk4);
title('Absoluter Fehler');
legend('Aadam Bashforth 4. Ordnung', 'Runge Kutta 4. Ordnung');
xlabel('Anzahl Schritte')
xlim([1 7])
set(gca, 'XTickLabel',{'10^1','10^2','10^3','10^4','10^5','10^6','10^7'})

figure

plot( time_ab4);
hold on;
grid minor;
plot(time_rk4);
title('Rechenzeit [s]');
legend('Aadam Bashforth 4. Ordnung', 'Runge Kutta 4. Ordnung');
xlabel('Anzahl Schritte')
xlim([1 7]);
set(gca, 'XTickLabel',{'10^1','10^2','10^3','10^4','10^5','10^6','10^7'})

% 3.c)
% Bei tiefer Anzahl Schritte hat die Runge Kutta Methode (4. Ordnung) einen
% kleineren Fehler als die Bashforth Methode (4. Ordnung).
% Erst ab n = 10^5 ist eine unterschiedliche Berechnungszeit erkennbar. 