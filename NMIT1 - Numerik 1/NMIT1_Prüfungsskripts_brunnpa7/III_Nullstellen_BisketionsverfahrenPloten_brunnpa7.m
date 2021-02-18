% Ploten von einem Bisektionsverfahren

function III_Nullstellen_BisketionsverfahrenPloten_brunnpa7

% 1. Aufruf mit Toleranzgrenze 10^-15
[root, xit, n] = III_Nullstellen_BisektionsverfahrenInklParam_brunnpa7(@(x) x.^2 - 2, 0, 2, 10^-15);

absoluter_fehler = abs(xit);

subplot(3, 1, 1);
semilogy(absoluter_fehler);

% 2. Aufruf mit Toleranzgrenze 10^-16
[root2, xit2, n2] = III_Nullstellen_BisektionsverfahrenInklParam_brunnpa7(@(x) x.^2 - 2, 0, 2, 10^-16);

absoluter_fehler = abs(xit);

subplot(3, 1, 2);
semilogy(absoluter_fehler);


end
