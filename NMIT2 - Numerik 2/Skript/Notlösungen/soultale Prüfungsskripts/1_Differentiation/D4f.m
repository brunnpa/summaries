function [d4f, d4f_table] = D4f(x0, h, f)
%D4f([1, 3, 5], [10^-2, 10^-4, 10^-6, 10^-8], @(x)sin(x))
%Berechnet zweite Ableitung an Stelle x0 mittels
%Vorwärtsdifferenz
%Fehlerordnung 0(h), k=1
%x0: Stellen, an der Ableitung berechnet wird
%h: Schrittweiten
%f: Funktion
format long;
d4f = zeros(size(h,2),size(x0,2));

for i = 1:size(h,2)
    for j = 1:size(x0,2)
        d4f(i,j)= (f(x0(j) + 2.*h(i)) - 2.*f(x0(j) + h(i)) + f(x0(j)))./h(i).^2;
    end
end

col_labels = string(x0);
row_labels = ["D4f h/x0", string(h)]';
d4f_table = [row_labels, [col_labels;d4f]];
disp(d4f_table);

end