function [b] = get_adams_b(n)
%GET_ADAMS_B Koeffizienten b für AdamsBashforth n-ter Ordnung
%n: Ordnung der Adams Bashforth Methode => Ordnung 4 => n = 4
%b: Koeffizienten
s = n-1;
b = zeros([1,(s+1)]);
for j=0:s
    factorial_part = ((-1).^j)./(factorial(j).*factorial(s-j));
    func_str = "@(u)";
    for k=0:s
        if ~(k==j)
            func_str = func_str + "(u+" + k + ").*";
        end
    end
    expression = "\.\*$";
    replace = "";
    func_str = regexprep(func_str,expression,replace);
    f = str2func(func_str);
    %[D, D_table] = romberg_extrapolation(0,1,f,5);
    b(j+1) = factorial_part .* integral(f,0,1);
end

end