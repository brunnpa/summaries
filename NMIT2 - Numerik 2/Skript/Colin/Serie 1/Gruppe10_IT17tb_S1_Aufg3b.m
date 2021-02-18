% Plottet Ortskurve, Geschwindigkeit und Beschleunigung einer Feder welche
% schwingt.
% 
% PARAMETER
% nMax = Anzahl Iterationen
%
% RETURN
% -
% SAMPLE
% Gruppe10_IT17tb_S1_Aufg3b(1000)
function Gruppe10_IT17tb_S1_Aufg3b(nMax)
    % Gegeben aus Aufgabe:
    n = 1:nMax;
    t = 0 + n.*0.1;
    x = 10.*exp(-0.05.*t).*cos(0.2.*pi.*t);
    % Auslenkung x(t)
    dx = Gruppe10_IT17tb_S1_Aufg3a(t, x);
    dx2 = Gruppe10_IT17tb_S1_Aufg3a(t, dx);
    plot(t, x, t, dx, t, dx2);

    legend('Ort', 'Geschwindigkeit', 'Beschleunigung');
    grid();


    % Wo hat die Geschwindigkeit die Nulldurchgänge?
    % Dort wo die Feder nicht mehr schwingt. Das heisst immer dort wo die
    % Ortskurve ein lokales minimum oder maximum erreicht hat.

    % Wo liegen die relativen Extrema der Beschleunigung?
    % Immer dort wo die Ableitung der Beschleunigungskurve null ergibt. Das
    % heisst wo die Kurve von steigend zu fallend wechselt.

    % Was bedeutet das in Bezug auf die Bewegung des Pendels?
    % Die Beschleunigung erreicht seine Extrempunkte immer zur gleichen
    % Zeit wie die Ortskurve (aber in entgegengesetzter Richtung.
    % Ist der Ort an der obersten Stelle, ist die Beschleunigung am
    % kleinsten und umgekehrt. An diesen Stellen beträgt die
    % Geschwindigkeit 0, da sich die Richtung der Federschwingung dabei
    % ändert.
end

