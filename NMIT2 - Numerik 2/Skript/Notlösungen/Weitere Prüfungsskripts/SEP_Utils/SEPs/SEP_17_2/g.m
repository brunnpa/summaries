% Verrauschte Funktion
function y = g(t)
    D = 5;
    y = f(t) + D*rand(size(t)) - D/2;
end
