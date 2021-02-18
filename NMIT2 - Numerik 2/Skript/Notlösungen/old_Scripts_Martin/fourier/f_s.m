% Periodische Funktion im Intervall 0..T beschreiben
function y = f_s(t)
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
