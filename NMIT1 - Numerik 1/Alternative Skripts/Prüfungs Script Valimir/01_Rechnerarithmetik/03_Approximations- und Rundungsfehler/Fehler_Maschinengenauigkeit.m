Basis = 10;
e = 2;
n = 5;

%ABSOLUTER RUNDUNGS FEHLER von höchstens |rd(x)-x| <=
rdx_x = (Basis/2)*Basis^(e-n-1)


%ABSOLUTER ABSCHNEIDE FEHLER von höchstens |absch(x)-x| <=
abschx_x = Basis^(e-n)




%MASCHIENENGENAUIGKEIT bzw. MAX REL FEHLER BEI RUNDEN
maschinengenauigkeit = Basis^(-n)



% n-stellige GLEICHPUNKT ARITHMETIC - RUNDEN AUF STELLEN
d = 1234.1234; %zu rundende zahl
N = 4; %anz stellen

%runden auf N-stellen nach komma
gerundet_stellen_nach_komma = round(d, N)

%gerundet auf insgesamt N-stellen
gerundet_stellen_instesamt = round(d, N, 'significant')

%Für die Berechnungen bedeutet Rundung, 
%dass jede einzelne Operation (+, -, *, ...) 
%auf n+1 genau gerechnet wird und das Ergebnis 
%auf n Stellen gerundet wird (n-stellige Gleitpunktarithmetik).
%Da jedes Zwischenergebnis gerundet wird, 
%wird der Rundungsfehler immer auch mitgeschleppt