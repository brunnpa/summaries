% Gegebene X und Y Werte
xi = [exp(1)-1/2, exp(1)-1/4, exp(1)+1/4, exp(1)+1/2];
yi = [3.9203, 5.9169, 11.3611, 14.8550];

% Gesuchter X Wert
x = exp(1);

n = length(xi);

% Li Vektor vorbereiten
li = ones(n, 1);

% Li Vektor befüllen
for i = 1:n
    for j = 1:n
        if (i ~= j) 
            li(i) = li(i) * (x-xi(j))/(xi(i)-xi(j));
        end
    end
end

% Polynom zusammensetzen
Pn = 0;
for i= 1:n
    Pn = Pn + (yi(i) * li(i));
end
fprintf('\nWert für die Lis\n');
disp(li);
fprintf('\nErgebnis für x %.6f\n', Pn);

% Falls man die exakte Kurve kennt, hier die Fehler berechnen
% exakt = (exp(2) * (log(exp(2))-1) + 1);
% fprintf('Absoluter Fehler %.12f\n', abs(Pn - exakt));
% fprintf('Relativer Fehler %.12f\n', abs(Pn - exakt) / abs(exakt));
% 
% romberg = IT15ta_ZH08_S3_Aufg3(@(x) 2*x * log(x^2), 1, exp(1), 3);
% disp(abs(romberg - exakt)/ abs(exakt));