function Berg_Michael_Brunner_Pascal_IT17tb_G2_S7_Aufg1()
clear;
a = 0;
b = zeros(1,4);
ordnung = 4;
n = 5;

s = ordnung-1;

bj = @(j, f) (-1)^j / (factorial(j)*factorial(s-j))*Berg_Michael_Gruppe2_S3_Aufg3(f, 0, 1, n);

% k != j
f = @(u) (u+1).*(u+2).*(u+3);
b(1) = bj(0, f);

for j = 1:3
   f = @(u) (u+0).*(u+1).*(u+2).*(u+3)./(u+j);
   b(j+1) = bj(j, f);
end

b.*24
% ans = 55   -59    37    -9