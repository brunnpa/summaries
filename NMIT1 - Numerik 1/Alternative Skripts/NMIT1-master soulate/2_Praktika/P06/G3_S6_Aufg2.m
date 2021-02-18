function G3_S6_Aufg2()
format long
h= 9;
fehler = 2;
count = 0;
while (fehler > 1 && count < 10)
    count = count + 1;
    halt = h;
    h = h - ((1/3) * h^3 * pi - 5*h^2*pi + 471)/(h^2 * pi - 10 * h * pi);
    fehler = ((1/3) * h^3 * pi - 5*h^2*pi + 471) * 10^3;
end
 count
 h
 fehler = fehler * 10^-3