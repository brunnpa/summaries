% Implementation des Newtonschen Verfahren für nichtlineare Systeme

function[xn] = QuadratischKonvergentNewton(f,xn,v)
    Df = jacobian(f,v)
    Df = matlabFunction(Df,'vars',v)
    f = matlabFunction(f,'vars',v)

    tol = 1e-6;
    delta = 1;
    n = 0
    % Euklidsche Norm (2-Norm) des Vektors delta^(n)
    % mögliches Abbruchkriterium gemäss 'Numerik Algorithmen', G.
    % Englen-Müllges et al., 10. Auflage, 2011
    while (norm(delta, 2) > tol)
        % symbolische Substitution
        Dfv = subs(Df, v, xn)   % old durch xn ersetzen und Df mit xn auswerten
        fv = subs(f, v, xn)     % old durch xn ersetzen und f mit xn auswerten
        % delta^(n) berechnen: Matrix dividiert durch Vektor
        delta = -Dfv\fv
        % Iterationsvorschrift x^(n+1) := x^(n) + delta^(n)
        xn = xn + delta
        n = n + 1
        disp('---');
    end
end