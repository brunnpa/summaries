function [d1f, d1f_table] = D1f(x0, h, f)
%d1f = D1f([1, 3, 5], [10^-2, 10^-4, 10^-6, 10^-8], @(x)sin(x))
%Berechnet Ableitung an Stelle x0 mittels
%Vorwärtsdifferenz mit Taylorpolynom ersten Grades
%Fehlerordnung 0(h^1), k=1
%x0: Stellen, an der Ableitung berechnet wird
%h: Schrittweiten
%f: Funktion

format long;
d1f = zeros(size(h,2),size(x0,2));

for i = 1:size(h,2)
    for j = 1:size(x0,2)
        d1f(i,j)= (f(x0(j) + h(i)) - f(x0(j)))./h(i);
    end
end

col_labels = string(x0);
row_labels = ["D1f h/x0", string(h)]';
d1f_table = [row_labels, [col_labels;d1f]];
%disp(d1f_table);

end

