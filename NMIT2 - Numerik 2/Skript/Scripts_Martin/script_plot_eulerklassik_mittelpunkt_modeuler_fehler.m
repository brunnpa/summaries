clc;
format long;

% Funktion definieren
f = @(x, y) (x.^2)./y;

% Untere Intervallsgrenze (laut Angabe)
a = 0;

% Obere Intervallsgrenze (laut Angabe)
b = 2.1;

% Startwert
y0 = 2;

% Schrittweite h
h = 0.7;

% Anzahl der Subintervalle
n = (b-a)/h;


% ====================================================================== %
% Klassisches Euler-Verfahren
% ====================================================================== %

[x, y_klassisch] = func_dgl_euler_klassisch(f, a, b, n, y0);
plot(x, y_klassisch, 'm');
hold on;

fprintf('==============================================================\n');
fprintf('Klassisches Euler-Verfahren\n');
fprintf('==============================================================\n');

for i = 1:length(x)
    fprintf('x: %5.8f    y: %5.8f\n', x(i), y_klassisch(i));
end



% ====================================================================== %
% Mittelpunktverfahren
% ====================================================================== %

[x, y_mittelpunkt] = func_dgl_mittelpunkt(f, a, b, n, y0);
plot(x, y_mittelpunkt, 'g');

fprintf('\n\n==============================================================\n');
fprintf('Mittelpunkt-Verfahren\n');
fprintf('==============================================================\n');

for i = 1:length(x)
    fprintf('x: %5.8f    y: %5.8f\n', x(i), y_mittelpunkt(i));
end


% ====================================================================== %
% Modifiziertes Euler-Verfahren
% ====================================================================== %

[x, y_modifiziert] = func_dgl_euler_modifiziert(f, a, b, n, y0);
plot(x, y_modifiziert, 'b');

fprintf('\n\n==============================================================\n');
fprintf('Modifiziertes Euler-Verfahren\n');
fprintf('==============================================================\n');

for i = 1:length(x)
    fprintf('x: %5.8f    y: %5.8f\n', x(i), y_modifiziert(i));
end


% ====================================================================== %
% Fehlerberechnung
% ====================================================================== %

% Exakte Loesung der oberen DGL (aus Angabe)
yExakt = @(x) sqrt(((2 * x.^3)/3)+ 4);

% Exakte Funktion plotten
step = a:0.01:b;
plot(step, yExakt(step),'r');

legend('klassisch', 'mittelpunkt', 'modifiziert', 'exakt');
hold off;

fprintf('\n\n----------------------------------------------\n');
fprintf('Fehlerberechnung Euler-Verfahren\n');
fprintf('----------------------------------------------\n');
fprintf('| klassisch    |  mittelpunkt | modifiziert  |\n'); 
fprintf('----------------------------------------------\n');

for i=1:n
    xi = x(i);
    yEx = yExakt(xi);
    error_klassisch = abs(yEx - y_klassisch(i));
    error_mittelpunkt = abs(yEx - y_mittelpunkt(i));
    error_modifiziert = abs(yEx - y_modifiziert(i));
    fprintf('| %.10f | %.10f | %.10f |\n', error_klassisch, error_mittelpunkt, error_modifiziert);
end