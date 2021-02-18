% Abgabe David Lüscher Pascal Brunner Anastassios Martakos - Aufgabe 3a/b
% Die Funktion b liefert konstant genauere Werte als Funktion a
% Kann getestet werden mit Input "Luescher_David_Gruppe4_S2_Aufg3(30)"

function Luescher_David_Gruppe4_S2_Aufg3(accuracy)

    % sdefault bezeichnet die Länge einer einzelnen Seite eines Sechsecks
    sdefault = 1;
    sIterA = sdefault;
    sIterB = sdefault;
    
    % ndefault bezeichnet die Summe der Ecken des Sechsecks
    ndefault = 6;
    nIterA = ndefault;
    nIterB = ndefault;
    
    % Array füllen, um Funktion plotten zu können am Schluss
    funXvaluesA = zeros(accuracy);
    funYvaluesA = zeros(accuracy);
    funXvaluesB = zeros(accuracy);
    funYvaluesB = zeros(accuracy);
   
    for i=1:accuracy
        s2na = sqrt(2-2*sqrt(1-((sIterA^2)/4)));
        twoPi = 2*nIterA * s2na;
        
        % Die Länge für die nächste Iteration festsetzen
        sIterA = s2na;
        
        % Die Kantenanzahl festlegen
        nIterA = 2*nIterA;
        
        % Werte der Funktion zuweisen
        funXvaluesA(i) = nIterA/2;
        funYvaluesA(i) = twoPi/2;
        
    end
     
    subplot (2,2,1);
        plot(funXvaluesA,funYvaluesA, 'r');
        title('Aufgabe 3a');
        ylim([3.1 3.15]);

    for i=1:accuracy
        s2nb = sqrt((sIterB^2)/(2*(1+sqrt(1-(sIterB^2/4)))));
        twoPi = 2*nIterB * s2nb;
        
        % Die Länge für die nächste Iteration zuweisen
        sIterB = s2nb;
        
        % Die Kanzenanzahl festlegen
        nIterB = 2*nIterB;
        
        % Werte der Funktion zuweisen
        funXvaluesB(i) = nIterB/2;
        funYvaluesB(i) = twoPi/2;
    end
    
    subplot (2,2,2);
        plot(funXvaluesB, funYvaluesB, 'g');
        title('Aufgabe 3b')
        ylim([3.1 3.15]);

end
