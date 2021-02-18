function [d5f, d5f_table] = D5f(x0, h, f)
%D5f([1, 3, 5], [10^-2, 10^-4, 10^-6, 10^-8], @(x)sin(x))
%Berechnet zweite Ableitung an Stelle x0 mittels
%Zentraler Differenz
%%Fehlerordnung 0(h^2), k=2
%x0: Stellen, an der Ableitung berechnet wird
%h: Schrittweiten
%f: Funktion
format long;
d5f = zeros(size(h,2),size(x0,2));

for i = 1:size(h,2)
    for j = 1:size(x0,2)
        d5f(i,j)= (f(x0(j) + h(i))  -    2.*f(x0(j)) +   f(x0(j) - h(i))  )./h(i).^2;
    end
end

col_labels = string(x0);
row_labels = ["D5f h/x0", string(h)]';
d5f_table = [row_labels, [col_labels;d5f]];
disp(d5f_table);

end

