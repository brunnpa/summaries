% Verrauschte Funktion
function y = g_s(t)
    D = 5;
    y = f_s(t) + D*rand(size(t)) - D/2;
end
