function [d3f, d3f_table] = D3f(x0, h, f)
%D3f([1, 3, 5], [10^-2, 10^-4, 10^-6, 10^-8], @(x)sin(x))
%Berechnet Ableitung an Stelle x0 mittels
%Zentralerdifferenz mit Taylorpolynom zweiten Grades 
%Fehlerordnung O(h), k=1
%x0: Stellen, an der Ableitung berechnet wird
%h: Schrittweiten
%f: Funktion
format long;
d3f = zeros(size(h,2),size(x0,2));

for i = 1:size(h,2)
    for j = 1:size(x0,2)
        d3f(i,j)= (f(x0(j)) - f(x0(j) - h(i)))./h(i);
    end
end

col_labels = string(x0);
row_labels = ["D3f h/x0", string(h)]';
d3f_table = [row_labels, [col_labels;d3f]];
%disp(d3f_table);

end
