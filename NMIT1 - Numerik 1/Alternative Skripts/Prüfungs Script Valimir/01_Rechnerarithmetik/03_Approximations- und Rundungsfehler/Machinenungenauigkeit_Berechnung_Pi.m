
% aufgabe a)
sn = 1;
n = 6;
laenge = 0;
s2n = 0;

for i = 1 : 50
    s2n = sqrt(2-2*sqrt(1-(sn^2)/4));
    n = 2*n;
    sn = s2n;
    laenge = sn * n;
end

 % aufgabe b)
sn1 = 1;
n1 = 6;
laenge1 = 0;
s2n1 = 0;
 
 
 for i = 1 : 50
    s2n1 = sqrt((sn1^2) / (2*(1 + sqrt(1-(sn1^2)/4))));
    n1 = 2*n1;
    sn1 = s2n1;
    laenge1 = sn1 * n1;
 end
 
 % beobachtung: 1 schleife: wenn nur 1:20 gibt es ein resultat, f�r mehr als 30 gibt es nur noch 0.
 % zweite schleife geht f�r viel mehr iterationen

 