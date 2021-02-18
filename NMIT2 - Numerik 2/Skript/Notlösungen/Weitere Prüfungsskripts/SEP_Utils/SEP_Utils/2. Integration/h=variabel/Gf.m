function    [IGf]   =   Gf(a,b,f,n)
% Test:     [IGf]   =   Gf(0,0.5,@(x) exp(1).^(-x.^2),3)
%                   =   0.461281280092515
% Params:
% a:    Untere Integrationsgrenze
% b:    Obere Integrationsgrenze
% f:    Zu integrierende Funktion
% n:    Grad des verwendeten Polynomes / Anzahl Stützstellen
%       0/1   =>  Rechteck-Formel
%       1/2   =>  Trapez-Formel
%       2/3   =>  Simpson-Formel
%
% Eigenschaften:
%       * Stützstellen sind nicht äquidistant
%       * sondern werden so gewählt, dass sie das
%       * Integral optimal approximieren
%       * Fehlerordnung möglichst klein halten

% Check
% Check
if (b <= a)
    error("b muss als obere Intervallgrenze grösser als a sein")
end
% Wahl der Anzahl Stützstellen
if n ==1
    IGf = (b-a).*f((b+a)./2);
end

if n == 2 
    s1 = (-1./sqrt(3)).*((b-a)./2)+((b+a)./2);
    s2 = (1./sqrt(3).*((b-a)./2))+((b+a)./2);
    IGf = ((b-a)./2).*(f(s1)+f(s2));
end

if n == 3
    s1 = (-sqrt(0.6) * ((b-a)./2)) + ((b+a)/2);
    s2 = (b+a)/2;
    s3 = (sqrt(0.6) * ((b-a)./2)) + ((b+a)/2);
    IGf = ((b-a)./2).*(((5./9).*f(s1))+((8./9).*f(s2)))...
        + ((b-a)./2).*(((5./9).*f(s3)));
end

end

