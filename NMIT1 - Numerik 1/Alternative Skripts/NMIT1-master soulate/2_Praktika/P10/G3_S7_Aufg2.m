%A = [1 5 6; 0 -26 -36; 2 3 4]
%b=[29;-160;20]
%[A_triangle, detA, x] = G3_S7_Aufg2(A, b)

function [A_triangle, detA, x] = G3_S7_Aufg2(A, b)

[m, n] = size(A);
if m ~= n
   disp('Matrix ist nicht quadratisch');
   return;
end

Ab = [A, b];

%subtract factor of first line from each line
operatorCount=1;
for i=2:1:m
    %Zeilen tauschen
    off = 0;
    while(Ab(i-1, i-1) == 0) 
        Ab([i-1 i+off], :) = Ab([i+off i-1], :);
        off=off+1;
        operatorCount=operatorCount+1;
    end
    %Werte eliminieren
    for j=i:1:m
        factor = Ab(j, i-1) / Ab(i-1, i-1);
        Ab(j, :) = Ab(j, :) - factor * Ab(i-1, :);
    end
end

if(mod(operatorCount, 2)==0)
    Ab=-Ab;
end

A_triangle = Ab(1:n, 1:n);
bNeu = Ab(1:n, n+1);
detA = prod(diag(A_triangle));

% x berechnen
x = zeros(m,1);
for i=m:-1:1
    sum = 0;
    for j=i+1:1:m
        sum = sum + A_triangle(i, j) .* x(j, 1);
    end
    x(i, 1) = (bNeu(i, 1) - sum) ./ A_triangle(i, i);  
end