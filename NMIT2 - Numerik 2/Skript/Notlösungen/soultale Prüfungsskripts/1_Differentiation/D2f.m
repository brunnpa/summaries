function [d2f, d2f_table] = D2f(x0, h, f)
%D2f([1, 3, 5], [10^-2, 10^-4, 10^-6, 10^-8], @(x)sin(x))
%Berechnet Ableitung an Stelle x0 mittels
%Zentralerdifferenz mit Taylorpolynom dritten Grades 
%Fehlerordnung O(h^2), k=2
%x0: Stellen, an der Ableitung berechnet wird
%h: Schrittweiten
%f: Funktion
format long;
d2f = zeros(size(h,2),size(x0,2));

for i = 1:size(h,2)
    for j = 1:size(x0,2)
        d2f(i,j)= (f(x0(j) + h(i)) - f(x0(j) - h(i)))./(2*h(i));
    end
end

col_labels = string(x0);
row_labels = ["D2f h/x0", string(h)]';
d2f_table = [row_labels, [col_labels;d2f]];
%disp(d2f_table);

end

