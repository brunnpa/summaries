% NMIT2 SEP - Aufgabe 4
% Valmir Selmani

% Gegebene X und Y Werte
xi = [2, 3, 4];
yi = [0.88137, 1.081135, 1.22423];

% Gesuchter X Wert
x = 3.27;

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