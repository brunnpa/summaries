function Diskretisierungsfehler
    %Tabelleratische Form für Berechnung des Diskretisierungsfehlers mit 
    %D1 und D2
    
    %2a
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
    
    %2b
    % Berechnung für hOpt mit binärer Basis und n=52
    
    % da binäre Basis = 2
    % da n = 52
    eps = 2^-52;
    
    % Faustformel für hOpt für die Vorwärtsdifferenz (d1)
    % hOpt = sqrt(4 * eps * abs(f(x0) / abs(f''(x0))
    hopt1 = sqrt(4*eps*abs(log(4))/abs(-0.5));

    % Berechnung von d1 mittels h = hOpt
    d1_hopt = (log((x0 + hopt1)^2) - log((x0)^2)) / hopt1;
    
    der1 = 1;
    
    discErr = abs(d1_hopt - der1);
        
    formatSpec = '\n\nD1f: %16.8f       DiskFehl: %16.8f';
    
    fprintf(formatSpec, d1_hopt, discErr);
    
    % Entspricht den Erwartungen, d1_hopt ist der genauste Wert in der in 2a ausgegebenen Tabelle
    
    %2c
    % 2, da binäre Basis
    % -52, da n=52
    eps = 2^-52;
    
    % Berechnung der optimalen Schrittweite gemäss Faustformel für d2
    % hOpt2 = "dritte Wurzel"(6 * eps * abs(f(x0)) / abs(f'''(x0)))
    % -> Da umständlich wird es umgeformt -> dritte Wurzel = Ausdruck^(1/3)
    % => (6 * eps * abs(f(x0)) / abs(f'''(x0)))^(1/3)
    hopt2 = (6*eps*abs(log(4))/abs(0.5))^(1/3);

    % Berechnung der zentralen Differenz (d2) mittels optimaler
    % Schrittweite
    d2_hopt = (log((x0 + hopt2)^2) - log((x0 - hopt2)^2)) / (2*hopt2);
    
    der1 = 1;
    
    discErr = abs(d2_hopt - der1);
        
    formatSpec = '\n\nD2f: %16.8f       DiskFehl: %16.8f';
    
    fprintf(formatSpec, d2_hopt, discErr); 
   
    % Entspricht den Erwartungen, d2_hopt ist der genauste Wert in der in 2a ausgegebenen Tabelle   
end

