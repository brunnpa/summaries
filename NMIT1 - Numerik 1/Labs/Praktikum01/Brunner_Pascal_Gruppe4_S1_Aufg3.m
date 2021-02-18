function x = fakIter(n)
x = 1;

for y = 1 : n
   x = x*y; 
end

% Ergebnis der Auswertung
    % t1 = tic;
    % fak(100);
    % toc(t1)
    % Elapsed time is 7.580106 seconds.
    % t2 = tic;
    % fakIter(100);
    % toc(t2)
    % Elapsed time is 6.940403 seconds.
    
% Erklärung / Antwort:
% Wie wir im Fach Algorithm & Datastructure gelernt haben, ist der
% rekursive Aufwand Zeitintensiver, da der Rechner bei jedem rekursivem
% Aufruf die Rücksprung-Adresse speichern muss. Dies ist beim iterativen
% Vorgehen nicht notwendig.