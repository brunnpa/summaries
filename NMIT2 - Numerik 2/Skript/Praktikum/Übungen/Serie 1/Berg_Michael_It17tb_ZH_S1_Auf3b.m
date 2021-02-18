function Berg_Michael_It17tb_ZH_S1_Auf3b
    t = 0.1:0.1:100;

    x = 0;

    x_der1 = 0;

    x_der2 = 0;

    for i = 1:1000
        x(i) = 10*exp(-0.05*t(i))*cos(0.2*pi*t(i));

        x_der1(i) = 10*exp(-0.05*t(i))*(-0.05)*cos(0.2*pi*t(1))+10*exp(-0.05*t(i))*-sin(0.2*pi*t(i))*0.2*pi;

        x_der2(i) = 10*exp(-0.05*t(i))*(-0.05)^2*cos(0.2*pi*t(i))+10*exp(-0.05*t(i))*-0.05*-sin(0.2*pi*t(i))*0.2*pi+10*exp(-0.05*t(i))*-0.05*-sin(0.2*pi*t(i))*0.2*pi+10*exp(-0.05*t(i))*-cos(0.2*pi*t(i))*(0.2*pi)^2;
    end

    plot(t, x, t, x_der1, t, x_der2);
    grid on;
    legend("f", "f'", "f''");
    
    % Geschwindigkeit hat Nulldurchg?nge in maximalen Auslenkungen des
    % Pendels (kurz vor Loslassen oder zur?ckpendeln)
    
    % Beschleunigung hat Extrema ebenfalls in maximalen Auslenkungen des
    % Pendels. Aufgrund dieser Versetztheit der Extrema von Geschwindigkeit
    % und Beschleunigung bewegt sich das Pendel bis zum Stillstand immer
    % weiter.
end