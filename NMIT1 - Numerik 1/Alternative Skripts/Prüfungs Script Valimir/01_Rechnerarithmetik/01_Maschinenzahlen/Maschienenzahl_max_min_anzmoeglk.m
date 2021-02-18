%WENN EMAX UND EMIN BEKANNT
emax = 15;
emin = 0;
n = 20;
Basis = 2;

xmax1 = (1-Basis^(-n))* Basis^emax
xmin1 = Basis^(emin-1)

%ANZAHL MOEGLICHE MASCHINENZAHLEN MIT VORZEICHEN
%!!!KEINE GARANTIE AUF RICHTIGKEIT!!!
vorzeichen = 1; %0 => ohne Vorzeichen; 1 => mit Vorzeichen
anzahl_verschiedener_mzahlen1 = ((Basis^((n-1)+vorzeichen))*(emax+1)*(Basis^vorzeichen))+1


%WENN NUR ANZAHL STELLEN VON E BEKANNT UND MIT VORZEICHEN
vorzeichen = 1; %0 => ohne Vorzeichen; 1 => mit Vorzeichen
e_stellen = 4;
n = 20;
Basis = 2;

xmax2 = (1-Basis^(-n))* Basis^((Basis^e_stellen)-1)
xmin2 = Basis^((vorzeichen*(-1)*((Basis^(e_stellen)-1)))-1)
anzahl_verschiedener_mzahlen2 = (Basis^((n-1)+vorzeichen)*Basis^(e_stellen + vorzeichen))+1