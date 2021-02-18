function [IGf] = Gf(a,b,f,n)
%Gaussformeln Gnf => n für Anzahl Stützstellen
%Stützstellen nicht äquidistant => Gewichte
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

