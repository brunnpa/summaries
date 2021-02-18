clear;
b = zeros(1,4);
bashford_ordnung = 4;
m = 10; % Selbst gewählt

s = bashford_ordnung - 1;
% Formel für Koeffizienten aus Aufgabenstellung
bj = @(j) (-1)^j / ( factorial(j)*factorial(s-j) );

% k = 0, k != j
f = @(u) (u+1).*(u+2).*(u+3);
integral = HELPER_S3_INTEGRAL(f, 0, 1, m);
b(1) = bj(0) * integral;

for j = 1:s
   f = @(u) (u+0).*(u+1).*(u+2).*(u+3)./(u+j);
   integral = HELPER_S3_INTEGRAL(f, 0, 1, m);
   b(j+1) = bj(j) * integral;
   b(j+1) = b(j+1) * 24; % Da h/24
end
b(1) = b(1) * 24;% Da h/24
disp(b);