% Ploten von einem Bisektionsverfahren

function Pascal_Brunner_Bisketionsverfahren_ploten

% 1. Aufruf mit Toleranzgrenze 10^-15
[root, xit, n] = Pascal_Brunner_Bisektionsverfahren(@(x) x.^2 - 2, 0, 2, 10^-15);

absoluter_fehler = abs(xit);

subplot(3, 1, 1);
semilogy(absoluter_fehler);

% 2. Aufruf mit Toleranzgrenze 10^-16
[root2, xit2, n2] = Pascal_Brunner_Bisektionsverfahren(@(x) x.^2 - 2, 0, 2, 10^-16);

absoluter_fehler = abs(xit);

subplot(3, 1, 2);
semilogy(absoluter_fehler);

% 

end
