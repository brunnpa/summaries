clear;
T = 1/100; % Aus Angabe
step = T/100; % in 100 äquidistanten Unterteilungen
t = 0:step:T; % Laut Angabe im Intervall  von [0, T] mit Schrittweite 'step'

% Plotten der Funktionen f (exakte Funktion), g (Rauschfunktion),
% fourier_allgemein (angenaeherte Funktion mittels Fourier Transf.)
plot(t,f(t), t, g(t),t,fourier_allgemein(t));

hold on;

legend('Funktion t', 'Funktion g', 'Funktion fourier_allgemein');
hold off;


function y = fourier_allgemein(x)
    T = 1/100;
    
    
    n = 10;
    
    % Kreisfrequenz der Schwingung
    omega = (2*pi)/T;

    % Fourierkoeffizienten
    A0 = 2/T * integral(@g,0,T);
    Ak = zeros(n,1);
    Bk = zeros(n,1);
    
    % Fourierkoeffizienten berechnen
    for k=1:n
        Ak(k) = 2/T * integral(@(x) g(x) .* cos(k*omega*x), 0,T);
        Bk(k) = 2/T * integral(@(x) g(x) .* sin(k*omega*x), 0,T);
    end
    
    
    y = zeros(length(x),1);
    k = (1:n)';
    
    % Allgemeine Fourier-Reihe (Formel Skriptum Seite 165)
    for i= 1:length(x)
        y(i) = A0/2 + sum(Ak .* cos(k.*omega.*x(i)) + Bk .* sin(k.*omega.*x(i)));
    end
end


% Rauschfunktion
% Je nach Angabe anpassen
function y = g(t)
    D = 5;
    y = f_s(t) + D*rand(size(t)) - D/2;
end

% Ursprüngliche exakte Funktion
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