%Abgabe David Lüscher Pascal Brunner - Aufgabe 3
function Brunner_Pascal_Gruppe4_S2_Aufg3
    nmax = 30;
    n = 6;

    x(1) = n;

    %-----Aufgabe 3a)-----
    sn = 1;

    functionA(1) = sn;

    for i = 2:nmax
        s2n = sqrt(2 - 2 * sqrt (1 - sn.^2 / 4));
        functionA(i) =  2*n*s2n;
        n = 2*n;
        sn = s2n;
        x(i) = n;
    end
    plot(x,functionA, 'r');
    
    %-----Aufgabe 3b)-----
    sn = 1;
    functionB(1) = sn;
    
    for i = 2:nmax
        s2n = sqrt(sn.^2 / (2*(1 + sqrt(1 - sn.^2 / 4))));
        functionB(i) = 2*x(i-1)*s2n;
        sn = s2n;        
    end
    

    hold on;
    plot(x,functionB, 'b');
    legend('Funktion A', 'Funktion B')

    disp(x);

end
