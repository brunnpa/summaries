function [d6f, d6f_table] = D6f(x0, h, f)
%D6f([1, 3, 5], [10^-2, 10^-4, 10^-6, 10^-8], @(x)sin(x))
%Berechnet zweite Ableitung an Stelle x0 mittels
%Rückwärts Differenz
%%Fehlerordnung 0(h^1), k=1
%x0: Stellen, an der Ableitung berechnet wird
%h: Schrittweiten
%f: Funktion
format long;
d6f = zeros(size(h, 2), size(x0, 2));s

for i = 1:size(h, 2)
    for j = 1:size(x0, 2)
        d6f(i, j) = (f(x0(j)) - 2 .* f(x0(j)-h(i)) + f(x0(j)-2.*h)) ./ h(i).^2;
    end
end

col_labels = string(x0);
row_labels = ["D6f, h / x0", string(h)]';
d6f_table = [row_labels, [col_labels; d6f]];
disp(d6f_table);

end