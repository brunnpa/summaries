%Abgabe David Lüscher Pascal Brunner - Aufgabe 2
function Brunner_Pascal_Gruppe4_S2_Aufg2
    
    %------Aufgabe 2a)------
    steps = (2.01 - 1.99) / 501;
    x = 1.99 : steps : 2.01; 


    f1 = x.^7 - 14*x.^6 + 84*x.^5 - 280*x.^4 + 560*x.^3 - 672*x.^2 + 448*x -128;
    f2 = (x-2).^7;

    subplot(2,2,1); 
    plot(x, f1, 'r');
    title('Aufgabe 2a) Funktion f1');
    subplot(2,2,2);
    plot(x, f2, 'b');
    title('Aufgabe 2a) Funktion f2');
    
    % --> Resultat 2a):
    %   Bei der Funktion f1 werden die Werte sehr gross, was zu einem
    %   Overflow führt.
    
    %------Aufgabe 2b)------
    x = -10^-14:10^-17:10^-14;
    g = x./(sin(1+x) - sin(1));
    
    subplot(2,2,3);
    plot(x, g);
    title('Aufgabe 2b)');
    grid on;
    
    %--> Resultat 2b):
    %   @Todo Erkenntnisse ergänzen
    
    %------Aufgabe 2c)------
    x = -10^-14:10^-17:10^-14;
    g = x./(2.*cos(2+x)./2).*sin(x./2);
    
    subplot(2,2,4);
    plot(x, g);
    title('Aufgabe 2c)');
    grid on;
    
    %--> Resultat 2c):
    %   @Todo Erkenntnisse ergänzen
end
