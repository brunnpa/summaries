n = 6;
S = 1;
nMax = 10;

x = zeros(1,nMax);
y = zeros(1,nMax);

for i=1:nMax
    SHalf = S/2;
    a = sqrt(1-(SHalf)^2);
    b = 1 - a;
    SNew = sqrt(b^2 + (SHalf)^2);
    U = n * S;
    pi = U/2;
    n = n*2;
    S = SNew;
    x(i) = n;
    y(i) = pi;
end

plot(x,y);
xlim([0, 100]);
ylim([0 4]);