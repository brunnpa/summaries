function Pascal_Brunner_FixpunktiterationAlsLoop(a, t)

k_n = 0.1;

alpha = a;

n = 1;
k_res(n) = alpha;

for i = 0 : 1 : t
    % Fixiterationberechnung
    
    % Funktion für Grippenausbreitung
    k_n1 = alpha * k_n.*(1 - k_n); 
    k_res(n) = k_n1;   

    % neuer Wert an k_n zuweisen
    k_n = k_n1;
    % n++
    n = n+1;
end
x = 1 : t+1;
    % Jedes zwischen Resultat ploten
    plot(x, k_res);

end