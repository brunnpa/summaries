clf, clear;
T = 1/100;
t = 0:T/100:T;
y = f(t);
plot(t, y, t, g(t),t,h(t))
legend('f', 'g', 'h');



function y = f(t)
    A = 2;
    T = 1/100;
    tau = T/10;
    y = zeros(size(t));
    
    for k = 1: length(t)
        if t(k) < T/2
            y(k) = A * (1 - exp(-t(k)/tau));
        else
            y(k) = A * exp(-(t(k)-T/2)/tau);
        end
    end
end

function y = g(t)
    D = 5;
    y = f(t) + D * rand(size(t)) - D/2;
end

function y = h(t)
    n = 10;
    T = 1/100;
    w = 2*pi/T; 
    A = zeros([n 1]);
    B = zeros([n 1]);
    
    A(1) = 2/T * integral(@(t) g(t), 0, T);
    y = A(1)/2;
    
    for k = 2:(n+1)
        A(k) = 2/T * integral(@(t) g(t) .* cos((k-1) .* w .* t), 0, T);
        B(k) = 2/T * integral(@(t) g(t) .* sin((k-1) .* w .* t), 0, T);
        y = y + A(k) .* cos((k-1) .* w .* t) + B(k) .* sin((k-1) .* w .* t);
    end
    
end