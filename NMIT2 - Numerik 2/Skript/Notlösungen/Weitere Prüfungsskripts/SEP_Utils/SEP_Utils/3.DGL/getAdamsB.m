function    [b]     =   getAdamsB(n)
% Test:     [b]     =   getAdamsB(4) 
%
% Hilfsmethode, welche den Koeffizienten der allgemeinen Adams-Bashford
% Methode n-ter Ordnung bei vorgegebenen n holt
%
% Params:
% n:    Ordnung der Adams Bashforth Methode
% 
% Returns:
% b:    Koeffizienten

%% Vorraussetzungen
s =     n-1;
b =     zeros(1,(s+1));      % Interpolationspolynom

%% Implementierung
for j=0:s
    frac_factor = ((-1)^j) / (factorial(j) * factorial(s-j));    % Vorfaktor
    func_str = "@(u)";
    
    for k=0:s
        if ~(k==j)
            func_str = func_str + "(u+" + k + ").*";
        end
    end
    expression = "\.\*$";
    replace = "";
    new_func_string = regexprep(func_str,expression,replace);
    f = str2func(new_func_string);
    %[D, D_table] = romberg_extrapolation(0,1,f,5);
    b(j+1) = frac_factor .* integral(f,0,1);   
end
end
