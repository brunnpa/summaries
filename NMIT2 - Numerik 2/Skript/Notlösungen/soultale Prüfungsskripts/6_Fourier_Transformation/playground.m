clear, clf;
%trigonometrisches polynom
%omega = 2pi / T => falls Nullpunkte bei 1 2 3.. => T = 2 => omega = pi
syms x;
n = 1000;
f = 0;
for k=1:n
    f = f + ((sin((2*k-1).*x))./(2*k-1));
end
f = 4./pi.*f;
trig_polynom = matlabFunction(f);

x1 = linspace(-pi,0,100);
x2 = linspace(0,pi,100);
y1 = ones(size(x1))*-1;
y2 = ones(size(x2));
x = linspace(-pi,pi,200);
y = trig_polynom(x);
plot(x,y,'r');
plot(x1,y1,'r');
grid minor;
%plot(x,sin(x),'g');
hold on;
plot(x2,y2,'r');
plot(x,y,'b--');

%k = 1;
fk1 = (4/pi).*sin(x);
fk3 = (4/(3*pi)).*sin(3.*x);
fk5 = (4/(5*pi)).*sin(5.*x)
plot(x,fk1,'b');
plot(x,fk1 + fk3,'r');
plot(x,fk1 + fk3 + fk5, 'y');


%y = sin(2*pi*x);
%omega = 2pi => T = 1 => 

%plot(x,y);
x1 = find(x == 0);
x2 = find(x == 1);
x3 = find(x == 2);
plot(x(x1),y(x1),'ro');
plot(x(x2),y(x2),'ro');
plot(x(x3),y(x3),'ro');
y(x0);
y(x1);
%Periode pi => omega = 2
%Frequenz v = 1/pi
%Phasenverschiebung 1
y2 =  sin(2*pi*2*x);
%plot(x,y2, 'r');
