dxMaxVec=zeros(1, 1000);
dxObsVec=zeros(1, 1000);
verhaeltnis=zeros(1, 1000);

for i=1:1:1000
    A = rand(100, 100);
    b = rand(100, 1);
    As = A + rand(100, 100)/10^5;
    bS = b + rand(100, 1)/10^5;
    
    [x, xS, dxMax, dxObs] = G3_S9_Aufg2(A, As, b, bS);
    dxMaxVec(i) = dxMax;
    dxObsVec(i) = dxObs;
    verhaeltnis(i) = dxMax/dxObs;
end

figure(1)
hold off;
semilogy(dxMaxVec, 'r');
hold on;
semilogy(dxObsVec, 'g');
semilogy(verhaeltnis, 'b');
legend('dxMax', 'dxObs', 'dxMax/dxObs');
xlabel('n');
ylabel('log(dxMax, dxObs, dxMax/dxObs)');

%Der effektive Fehler ist immer kleiner als der maximale Fehler.
%Das Verhältnis von dxMax/dxObs zeigt den Abstand vom effektiven Fehler und
%dem maximalen Fehler. 
%Der maximale Fehler ist ca. 10^3 mal grösser als der effektive Fehler.