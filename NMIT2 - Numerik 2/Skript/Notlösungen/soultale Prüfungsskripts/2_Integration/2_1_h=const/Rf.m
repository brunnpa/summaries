function [IRf] = Rf(a, b, f, n)
%IRf = Rf(2,4,@(x)1/x, 100);
%RF := bestimtes Integral von a bis b  mit Rechteckregel
%a: untere Grenze
%b: obere Grenze
%f: zu integrierende Funktion
%n: Anzahl Subintervalle
if (b <= a)
    error("b muss grösser als a sein");
end

IRf = 0;

h = (b-a)/n;
xi = a;
for i=1:n
    IRf = IRf + f(xi + (h/2));
    xi = xi + h;
end

IRf = IRf .* h;
%disp("Schrittlänge h:" + h + "- Anzahl Subintervalle: " + n);
%disp(IRf);
end

