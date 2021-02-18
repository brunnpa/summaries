clear;
T = 1/100;
step = T/100;
t = 0:step:T;

plot(t,f(t), t, g(t));

hold on;
plot(t,h(t));

legend('Funktion t', 'Funktion g', 'Funktion h');
hold off;

function y = h(x)
    T = 1/100;
    n = 10;
    omega = (2*pi)/T;

    A0 = 2/T * integral(@g,0,T);
    Ak = zeros(n,1);
    Bk = zeros(n,1);
    for k=1:n
        Ak(k) = 2/T * integral(@(x) g(x) .* cos(k*omega*x), 0,T);
        Bk(k) = 2/T * integral(@(x) g(x) .* sin(k*omega*x), 0,T);
    end
    y = zeros(length(x),1);
    k = (1:n)';
    for i= 1:length(x)
        y(i) = A0/2 + sum(Ak .* cos(k.*omega.*x(i)) + Bk .* sin(k.*omega.*x(i)));
    end
end
function y = f(t)
    A = 2;
    T = 1/100;
    tau = T/10;
    y = zeros(size(t));
    for k=1:length(t)
        if t(k) < T/2
            y(k) = A*(1-exp(-t(k)/tau));
        else
            y(k) = A*exp(-(t(k)-T/2)/tau);
        end
    end
end

function y = g(t)
    D = 5;
    y = f_s(t) + D*rand(size(t)) - D/2;
end