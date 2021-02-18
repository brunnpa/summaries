%Aufgabe 2 - Test Matlab Pascal Brunner
function Brunner_Pascal_IT17tbZH_Test_Aufg2
%Aufgabe 2.1    
    y = 1;
    e = exp(1);
    x = -5 : 1: 5;
    f = e.^x;
    subplot(3,2,1), plot(x, f);

%Aufgabe 2.2
    x = -10 : 1 : 10;
    g = x.^5 + 3*x.^4 + 3*x.^2 + x + 1
    subplot(3, 2, 2), plot(x, g);
    
%Aufgabe 2.3
    x = -2*pi : 0.1 : 2*pi;
    g = sin(x);
    h = cos(x);
    subplot(3,2,3), plot(x, g, x, h);