%Abgabe Praktikum 1 - David Luescher und Pascal Brunner
function Brunner_Pascal_Gruppe4_S1_Aufg1
    x = -10:0.1:10;
    f = x.^5-5*x.^4-30*x.^3+110*x.^2+29*x-105;
    f_diff = 5*x.^4-20*x.^3-90*x.^2+220*x+29;
    f_int = x.^6/6-x.^5-15*x.^4/2+110*x.^3/3+29*x.^2/2-105*x+0;
    
    plot(x, f, x, f_diff, x, f_int)
    xlim([-7, 10]);
    ylim([-1500, 1500]);
    grid;
    legend("Funktion", "Ableitung", "Stammfunktion");
end
   