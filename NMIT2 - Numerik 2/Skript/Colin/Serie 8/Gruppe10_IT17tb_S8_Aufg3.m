% Definieren Funktion und Startvariable gemäss Aufgabenstellung
f = @(t,y) -12 * y + 30 * exp(-2*t);

a = 0;
b = 10;
h = 0.01;
n = (b-a)/h;

x = a:h:b;
y0 = 0;

% Aufgabe 3a) Anfangswertproblem normal
[~, ~, y_mittelpunkt, ~] = HELPER_EULER(f,a,b,n,y0);
figure(1)
plot(x, 3*(1-exp(-10*x)).*exp(-2*x), 'r', x, y_mittelpunkt, 'g');
hold on;

% Aufgabe 3b) Dasselbe mit variabler Schrittweite
toleranz = 1e-1;
h_adaptiv = h;
i = 1;
y_euler = y0;
y_mittelpunkt = y0;
x = a;
while(x(i) < b)
    
    y_euler(i+1) = y_euler(i) + h * f(x(i),y_euler(i));
    yh2 = y_mittelpunkt(i)+h/2*f(x(i),y_mittelpunkt(i));
    y_mittelpunkt(i+1) = y_mittelpunkt(i) + h * f(x(i)+h/2, yh2);
   
   % Schrittweite anpassen
   if (abs(y_euler(i+1)-y_mittelpunkt(i+1)) < toleranz/20) 
       x(i+1) = x(i) + h;
       h = h*2;  
       i = i + 1;       
   else
       if (abs(y_euler(i+1)-y_mittelpunkt(i+1)) >= toleranz)
           h = h/2;
       else 
           x(i+1) = x(i) + h;
           i = i + 1;
       end
   end  
   h_adaptiv(i) = h;
end

% Aufgabe 3c)
plot(x, y_mittelpunkt, '--b');
legend('exakt', 'angenähert fixes h','angenähert variables h');
title('Vergleich Exakt, fixes h und variables h');
hold off;

figure(2)
plot(x, h_adaptiv)
title('Variable h in Abhängigkeit der Zeit');

% Aufgabe 3d)
% Die Kurve ist ungenau wenn die Toleranz klein ist (bsp: 1e-1)
% Umso kleiner desto besser jedoch auch langsamer