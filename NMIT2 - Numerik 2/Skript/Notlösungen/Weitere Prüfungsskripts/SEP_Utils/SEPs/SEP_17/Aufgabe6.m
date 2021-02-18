clear;
T = 2*pi;
step = T/100;
t = -pi:step:pi;

plot(t,f(t));

hold on;
plot(t,h(t));

legend('Funktion t', 'Funktion h');
hold off;

function y = h(x)
    T = 2*pi;
    n = 15;
    omega = (2*pi)/T;

    A0 = 2/T * integral(@f,0,T);
    Ak = zeros(n,1);
    Bk = zeros(n,1);
    for k=1:n
        Ak(k) = 2/T * integral(@(x) f(x) .* cos(k*omega*x), 0,T);
        Bk(k) = 2/T * integral(@(x) f(x) .* sin(k*omega*x), 0,T);
    end
    y = zeros(length(x),1);
    k = (1:n)';
    for i= 1:length(x)
        y(i) = A0/2 + sum(Ak .* cos(k.*omega.*x(i)) + Bk .* sin(k.*omega.*x(i)));
    end
end

function y = f(x)
    A = 1.25;
    for i = 1:length(x)
       y(i) = 2*A;
       if x(i)>= (-pi/2) && x(i) <=pi/2
           y(i) = 0;
       end
    end
end