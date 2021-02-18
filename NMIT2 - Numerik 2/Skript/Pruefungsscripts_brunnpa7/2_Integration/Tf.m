function [ITf] = Tf(a, b, f, n)
%ITf = Tf(2,4,@(x)1/x, 100);
%TF := bestimtes Integral von a bis b  mit Trapezregel
%a: untere Grenze
%b: obere Grenze
%f: zu integrierende Funktion
%n: Anzahl subintervalle
if (b < a)
    error("b muss grösser als a sein");
end

if (b==a)
    ITf = 0;
    return
end

h = (b-a)/n;
xi = a;
ITf = 0;
for i=1:n
    ITf = ITf + (((f(xi) + f(xi+h))./ 2)*h);
    xi = xi + h;
end
%disp(ITf);

end

