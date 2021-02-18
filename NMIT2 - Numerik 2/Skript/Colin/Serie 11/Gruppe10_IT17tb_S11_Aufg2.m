%% Berechnet mit der Ausgleichsrechnung eine Kurve an Messpunkten entlang

%% Rohdaten Kohlewasserstoffdämpfe zur Serie 11, Aufg.2
data = [33.00 53.00 3.32 3.42 29.00
        31.00 36.00 3.10 3.26 24.00
        33.00 51.00 3.18 3.18 26.00
        37.00 51.00 3.39 3.08 22.00
        36.00 54.00 3.20 3.41 27.00
        35.00 35.00 3.03 3.03 21.00
        59.00 56.00 4.78 4.57 33.00
        60.00 60.00 4.72 4.72 34.00
        59.00 60.00 4.60 4.41 32.00
        60.00 60.00 4.53 4.53 34.00
        34.00 35.00 2.90 2.95 20.00
        60.00 59.00 4.40 4.36 36.00
        60.00 62.00 4.31 4.42 34.00
        60.00 36.00 4.27 3.94 23.00
        62.00 38.00 4.41 3.49 24.00
        62.00 61.00 4.39 4.39 32.00
        90.00 64.00 7.32 6.70 40.00
        90.00 60.00 7.32 7.20 46.00
        92.00 92.00 7.45 7.45 55.00
        91.00 92.00 7.27 7.26 52.00
        61.00 62.00 3.91 4.08 29.00
        59.00 42.00 3.75 3.45 22.00
        88.00 65.00 6.48 5.80 31.00
        91.00 89.00 6.70 6.60 45.00
        63.00 62.00 4.30 4.30 37.00
        60.00 61.00 4.02 4.10 37.00
        60.00 62.00 4.02 3.89 33.00
        59.00 62.00 3.98 4.02 27.00
        59.00 62.00 4.39 4.53 34.00
        37.00 35.00 2.75 2.64 19.00
        35.00 35.00 2.59 2.59 16.00
        37.00 37.00 2.73 2.59 22.00];

y = data(:,5); % -> mCH (5, da es ein Polynom mit 5 Koeffizienten ist (gem. Aufgabe)
sizeOfY = size(y,1);
x = 1:sizeOfY;

%% Aufgabe a)
% Koeffizienten berechnen:
TTank = data(1:end,1);
TBenzin = data(1:end,2);
pTank = data(1:end,3);
pBenzin = data(1:end,4);
A = [TTank TBenzin pTank pBenzin ones(sizeOfY,1)];
% Gemäss Formel: ATrans * A * lambda = ATrans * y 
% -> lambda = ATrans * y * inv(ATrans * A)
% inv(A) * b = A \ b (MATLAB)
% -> lambda = (ATrans * A) \ (ATrans * y)
ATrans = A';
ATransA = ATrans*A;
lambda = ATransA\(ATrans*y);

subplot(1,2,1)
plot(x,y,'rx',x,A*lambda,'b')
legend('Messpunkte mCH','Fit mCH')

%% Aufgabe b)
maxIterations = 1000;
fehler = 10;
fehlerfunktional = ones(10,100);
for k=1:fehler
    for i=1:maxIterations
        randomMatrix = rand(sizeOfY,1); % -> Matrix mit Werten (0 bis 1)
        % Zufällig beide Vorzeichen -> sign() Funktion
        % Hat -1 wenn kleiner und 1 wenn grösser
        vorzeichen = sign(randomMatrix-0.5); % -0.5 da sonst nie negativ
        y_disturbed = y + (y.*(k/100)).* vorzeichen;
        % neues lambda
        lambda_dist = ATransA\(ATrans*y_disturbed);
        fehlerfunktional(k,i) = norm(y-A*lambda_dist);
    end
end
subplot(1,2,2)
plot(1:10,min(fehlerfunktional,[],2),'rx',1:10,max(fehlerfunktional,[],2),'bs')
grid on
xlabel('Fehlerkategorie +- xx%')
ylabel('Min/Max Fehlerfunktional')