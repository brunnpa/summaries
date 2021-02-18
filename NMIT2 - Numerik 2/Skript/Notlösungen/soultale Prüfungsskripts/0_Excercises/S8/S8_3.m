clear, clf;
f = @(t,y) -12.*y + 30.*exp(-2.*t);
y0 = 0;
a = 0;
b = 10;
n = 100;
[x_euler,y_euler] = euler(f,a,b,n,y0);
[x_mittelpunkt,y_mittelpunkt] = mittelpunkt(f,a,b,n,y0);
f_exakt = @(t) 3.*(1-exp(-10.*t)).*exp(-2.*t);
y_exakt = f_exakt(x_euler);
plot(x_euler, y_euler, 'r');
hold on;
plot(x_mittelpunkt,y_mittelpunkt, 'b');
plot(x_euler,y_exakt, 'g');
euler_error = abs(y_euler-y_exakt);
mittelpunkt_error = abs(y_mittelpunkt-y_exakt);

https://script.google.com/macros/s/AKfycbyMkSU3lxlrFspSvXM-yeNJfXfxb5VoaabqVrQgtx8ew86qNmh6/exec?name=Ministerium%20für%20Ländlichen%20Raum%20und%20Verbraucherschutz%20(MLR)%20Baden-Württemberg&id=2746&returnJSON=1&version=2
