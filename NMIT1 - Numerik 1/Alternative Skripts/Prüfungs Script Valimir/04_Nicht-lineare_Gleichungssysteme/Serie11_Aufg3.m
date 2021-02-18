% Funktion Georgiou_Remi_IT13t_S11_Aufg3
% Aufruf: Georgiou_Remi_IT13t_S11_Aufg3()

function[] = Georgiou_Remi_IT13t_S11_Aufg3()
    clc; clear all; format long;
 
    syms x y;
    f1 = x^2/186^2 - y^2/(300^2-186^2)-1;
    f2 = (y-500)^2/279^2 - (x-300)^2/(500^2-279^2)-1;
    f = [f1; f2]
   
    % a) grafische Lösung des Gleichungssystems
    hold on;
    ezplot(f1,[-2000,2000,-2000,2000]);
    ezplot(f2,[-2000,2000,-2000,2000]);
    legend('f1(x,y)', 'f2(x,y)', 'Location', 'northeast');
    title('Hyperbelförmige Ortskurven');
    grid on;
 
    % 2. Paramter: abgelesener Schnittpunkt
    xn = Newton(f, [200; 200])
    plot(xn(1), xn(2), 'ro', 'LineWidth', 2) 
    xn = Newton(f, [-100; 100])
    plot(xn(1), xn(2), 'ro', 'LineWidth', 2)
    xn = Newton(f, [-1100; 1500])
    plot(xn(1), xn(2), 'ro', 'LineWidth', 2)
    xn = Newton(f, [600; 700])
    plot(xn(1), xn(2), 'ro', 'LineWidth', 2)
    hold off;
end

% b) Implementation des Newtonschen Verfahren für nichtlineare Systeme
function[xn] = Newton(f, xn)
    x = sym('x');
    y = sym('y');
    old = [x; y];           
    Df = jacobian(f)
 
    tol = 1e-5;
    dn = 1;
    n = 0
    % Euklidsche Norm (2-Norm) des Vektors delta^(n)
    % mögliches Abbruchkriterium gemäss 'Numerik Algorithmen', G.
    % Englen-Müllges et al., 10. Auflage, 2011
    while (norm(dn, 2) > tol)
        % symbolische Substitution
        Dfv = subs(Df, old, xn);   % [x;y] durch xn ersetzen und Df mit xn auswerten
        fv = subs(f, old, xn);     % [x;y] durch xn ersetzen und f mit xn auswerten
        % delta^(n) berechnen: Matrix dividiert durch Vektor
        dn = double(-Dfv\fv);
        % Iterationsvorschrift x^(n+1) := x^(n) + delta^(n)
        xn = xn + dn
        n = n + 1
        disp('---');
    end
end