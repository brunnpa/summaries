% Ableitung durch Extrapulation mit dem h-Algorithmus
% 
% PARAMETER
% -
% RETURN
% -
% SAMPLE
% Gruppe10_IT17tb_S2_Aufg1
function Gruppe10_IT17tb_S2_Aufg1()
    h = [0.1,0.05, 0.025, 0.0125];
    sizeh = numel(h);
    D = zeros(sizeh);
    E = zeros(sizeh);
    x0 = 2;
    
    % Vorgabe ln(x^2)
    f = @(x) log(x^2);
    % Ableitung
    fDiff = @(x) 2/x;
    % Diskretiesierungsfehler
    D1f = @(x0,h) (f(x0+h) - f(x0)) / h; 
    
    % erste Spalte füllen -> D00 bis D30
    for i = 1:(sizeh)
        D(i,1) = D1f(x0, h(i));
        E(i,1) = abs(D(i,1) - fDiff(x0));
    end

    % weitere Spalten füllen auf Basis der ersten
    for k = 2:(sizeh)
        kReal = k-1;
        for i = 1:(sizeh) - kReal
            D(i,k) = (2^kReal * D(i+1, k-1) - D(i, k-1)) / (2^kReal - 1);
            E(i,k) = abs(D(i,k) - fDiff(x0));
        end
    end

    disp(D);
    disp(E);