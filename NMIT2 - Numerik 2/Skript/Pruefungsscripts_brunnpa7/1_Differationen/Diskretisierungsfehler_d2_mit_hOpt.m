function Diskretisierungsfehler_d2_mit_hOpt
    
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