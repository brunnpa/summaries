clear, clc;
n = 3;
V = @(t) 3500 * sin(140 .* pi .* t) .* exp(-63 .* pi .* t);
R = 50; % Ohm
E = @(t) V(t).^2 / R;

%t in ms from 0 to 50
t=linspace(0,0.05,100);
E_r3=zeros(size(t));
E_r6=zeros(size(t));
n = 3;
a = 0;
for i=1:size(t,2)
    D = romberg_extrapolation(a,t(i),E,n);
    E_r3(i) = D(1,n);
end

n = 6;
for i=1:size(t,2)
    D = romberg_extrapolation(a,t(i),E,n);
    E_r6(i) = D(1,n);
end
hold on;
plot(t,E_r3, 'r', t, E_r6,'b');
legend('E mit n=3', 'E mit n=6');

%b
f = @(t) E(t) - 250;
h = [0.01, 0.005, 0.0025,0.00125];
epsilon = 1e-5;
xn = 5e-3;

while ((f(xn - epsilon) * f(xn + epsilon)) > 0) 
    %Ableitung
    fdiff =  h2_extrapolation(xn, h, f, @(x,h,f)D2f(x,h,f));
    %Newton Verfahren
    xn1 = xn - (f(xn)/fdiff(1,4));
    xn = xn1; 
end

disp(xn);
disp(f(xn));

