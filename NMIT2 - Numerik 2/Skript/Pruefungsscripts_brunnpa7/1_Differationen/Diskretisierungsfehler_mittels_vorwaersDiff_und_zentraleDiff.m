function Diskretisierungsfehler_mittels_vorwaersDiff_und_zentraleDiff
    %Tabelleratische Form für Berechnung des Diskretisierungsfehlers mit 
    %D1 und D2
    
    % Anzahl Schritte -> D^i in diesem Beispiel von D^-1 bis D^-17
    for i = 1:17
       % Festlegen von x0 -> Startwert
       x0 = 2;
       
       % Festlegen von h -> in diesem Beispiel 10^-1
       % h = Schrittweite
       h = 10^-i;

       % Festlegen der Formel für d1 -> entspricht der Vorwärtsdifferenz
       % Vorwärtsdifferenz d1 = (f(x0 + h) - f(x0)) / h
       % f(x) = log(x^2)
       d1 = (log((x0 + h)^2) - log((x0)^2)) / h;

       % Festlegen der Formel für d2 -> entspricht der zentralen Differenz
       % zentrale Differenz d2 = (f(x0+h) - f(x0-h)) / 2*h
       d2 = (log((x0 + h)^2) - log((x0 - h)^2)) / (2*h);
       
       % Formatierung für printout
       % d1 wird mit 8 und d2 mit 12 Nachkommastellen dargestellt
       formatSpec = '%d:  %16.8f     %16.12f        hopt:\n';

       %printout
       fprintf(formatSpec, i, d1, d2);
    end