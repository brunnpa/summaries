%t elem [0,T)
clf, clear;
T = 0.01;
t = 0:T/100:T;
t = t(1:end-1);

plot(t,f(t),'b', t,g(t), 'r');
hold on;

f_ = @(t) f(t);
g_ = @(t) g(t); 

n = 10;
A_ = zeros([1,n+1]);
B_ = zeros([1,n+1]);
A_(1) = (2/T) * integral(g_, 0,T);
omega0 = (2*pi)./T;
y = A_(1)./2;
for k=2:(n+1)
    g_A = @(t) g_(t) .* cos((k-1).*omega0.*t);
    A_(k) = 2./T * integral(g_A,0,T);
    g_B = @(t) g_(t) .* sin((k-1).*omega0.*t);
    B_(k) = 2./T * integral(g_B,0,T);
    y = y + A_(k) .* cos((k-1).*omega0.*t) + B_(k).*sin((k-1) .* omega0 .* t);
end
plot(t,y,'g');
legend("f(t)", "g(t)","fourier");