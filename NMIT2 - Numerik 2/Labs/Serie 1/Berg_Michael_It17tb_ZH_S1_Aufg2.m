function Berg_Michael_It17tb_ZH_S1_Aufg2
    %2a
    for i = 1:17
       x0 = 2;

       h = 10^-i;

       d1 = (log((x0 + h)^2) - log((x0)^2)) / h;

       d2 = (log((x0 + h)^2) - log((x0 - h)^2)) / (2*h);
       
       formatSpec = '%d:  %16.8f     %16.8f        hopt:\n';

       fprintf(formatSpec, i, d1, d2);
    end
    
    %2b
    % Entspricht den Erwartungen, d1_hopt ist der genauste Wert in der in 2a ausgegebenen Tabelle
    eps = 2^-52;
    
    hopt1 = sqrt(4*eps*abs(log(4))/abs(-0.5));

    d1_hopt = (log((x0 + hopt1)^2) - log((x0)^2)) / hopt1;
    
    der1 = 1;
    
    discErr = abs(d1_hopt - der1);
        
    formatSpec = '\n\nD1f: %16.8f       DiskFehl: %16.8f';
    
    fprintf(formatSpec, d1_hopt, discErr);
    
    %2c
    % Entspricht den Erwartungen, d2_hopt ist der genauste Wert in der in 2a ausgegebenen Tabelle
    eps = 2^-52;
    
    hopt2 = (6*eps*abs(log(4))/abs(0.5))^(1/3);

    d2_hopt = (log((x0 + hopt2)^2) - log((x0 - hopt2)^2)) / (2*hopt2);
    
    der1 = 1;
    
    discErr = abs(d2_hopt - der1);
        
    formatSpec = '\n\nD2f: %16.8f       DiskFehl: %16.8f';
    
    fprintf(formatSpec, d2_hopt, discErr);    
end

