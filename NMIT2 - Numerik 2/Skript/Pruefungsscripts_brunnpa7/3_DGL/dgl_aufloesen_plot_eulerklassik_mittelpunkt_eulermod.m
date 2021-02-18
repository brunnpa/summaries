
clc;
format long; 

%{
Anfangswertproblem mittel Euler-, Mittelpunkt- und modifiziertem
Euler-Verfahren l�sen

Funktionierender Aufruf: Martin_Ponbauer_Vele_Ristovski_Gruppe8_S5_Aufg3(,0,2.1,3,2)

wobei f die Funktion ist,
xmin, xmax unf ymin, ymax die Intervallgrenzen sind
und hx und hy die Schrittweiten in die jeweilige Richtung sind.
%}

f = @(x,y) x.^2 ./ y ;
a = 0;
b = 2.1;
n = 3;
y0 = 2;

   
% Vektoren initialisieren    
x = zeros(1, n+1);
    
y_euler = zeros(1, n+1);
y_mittelpunkt = zeros(1, n+1);
y_modeuler = zeros(1, n+1);
y_euler_modeuler = zeros(1, n);   

% Startwerte f�r die jeweiligen Verfahren setzen
x(1)= a;
y_euler(1) = y0;
y_mittelpunkt(1) = y0;
y_modeuler(1) = y0;
    
% h/2 und h definiere, welche in den Verfahren verwendet werden
x_h2 = zeros(1, n+1);
y_h2 = zeros(1, n+1);
h = (b - a) / n;

% Die Verfahren wenden wir innerhal der for-Schlaufe an
for i=1:n
   x(i+1) = x(i) + h;
        
   % Euler-Verfahren
   %y_euler(i+1) = y_euler(i) + h * f(x(i), y_euler(i));
   [~, y_euler] = func_dgl_euler_klassisch(f, a, b, n, y0);

   % Mittelpunkt-Verfahren
   %x_h2 = x(i) + h/2;
   %y_h2 = y_mittelpunkt(i) + h/2 * f(x(i), y_mittelpunkt(i));
   %y_mittelpunkt(i+1) =  y_mittelpunkt(i) + h * f(x_h2, y_h2);
   [~, y_mittelpunkt] = func_dgl_mittelpunkt(f, a, b, n, y0);

   % modifiziertes Euler-Verfahren
   %y_euler_modeuler(i) = y_modeuler(i) + h * f(x(i), y_modeuler(i));
   %y_modeuler(i+1) = y_modeuler(i) + h * 1/2 *( f(x(i), y_modeuler(i)) + f(x(i+1),y_euler_modeuler(i)));
   [~, y_modeuler] = func_dgl_euler_modifiziert(f, a, b, n, y0);
end

% Resultate des Verfahrens plotten
hold on
func_richtungsfeld_zeichnen(f, a, b, y0, 3.26, 0.05, 0.05);
y = @(x) sqrt(2*x.^3/3 +4);
plot(x, y_euler);
plot(x, y_mittelpunkt);
plot(x, y_modeuler);
legend('Richtungsfeld','Euler-Verfahren', 'Mittelpunkt-Verfahren','Modifiziertes Euler-Verfahren');