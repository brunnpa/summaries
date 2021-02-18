function [A_triangle,detA,x] = G3_S7_Aufg2(A,b)

[m, n] = size(A);
if m ~= n
   disp('Matrix ist nicht quadratisch');
   return;
end

Ab = [A, b];
count=1;

for i=2:1:m
    j = i;
    while(Ab(i-1, i-1) == 0) 
        Ab([i-1 j], :) = Ab([j i-1], :);
        j=j+1;
        count=count+1;
    end
    
    for j=i:1:m
        factor = Ab(j, i-1) / Ab(i-1, i-1);
        Ab(j, :) = Ab(j, :) - factor * Ab(i-1, :);
    end
end

if(mod(count, 2)==0)
    Ab=-Ab;
end

A_triangle = Ab(1:n, 1:n);
bNeu = Ab(1:n, n+1);
detA = prod(diag(A_triangle));

x = zeros(m,1);
for i=m:-1:1
    sum = 0;
    for j=i+1:1:m
        sum = sum + A_triangle(i, j) .* x(j, 1);
    end
    x(i, 1) = (bNeu(i, 1) - sum) ./ A_triangle(i, i);  
end

 

