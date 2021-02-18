function [Tf_neq] = Berg_Michael_Gruppe2_S3_Aufg4a(x,y,j)

sum = 0;

for i = 1:j-1
    factor1 = y(i) + y(i+1);
    factor2 = x(i+1) - x(i);
    sum = sum + (factor1 * factor2)/2;
end

Tf_neq=sum;

end