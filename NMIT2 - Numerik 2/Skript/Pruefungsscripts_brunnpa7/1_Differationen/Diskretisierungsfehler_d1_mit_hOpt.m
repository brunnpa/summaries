function Diskretisierungsfehler_d1_mit_hOpt
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
    
    % diskreter Fehler wird berechnet aus der Differenz von d1-hOpt und 
    discErr = abs(d1_hopt - der1);
        
    formatSpec = '\n\nD1f: %16.8f       DiskFehl: %16.8f';
    
    fprintf(formatSpec, d1_hopt, discErr);
    
    % Entspricht den Erwartungen, d1_hopt ist der genauste Wert in der in 2a ausgegebenen Tabelle
end