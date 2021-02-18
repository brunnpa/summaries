% Berechnet y mit dem linearen Ausgleichsproblem

% Vektoren gemäss Aufgabenstellung, transponieren, da sie in vertikaler
% Form gebraucht werden
x=[0 10 20 30 40 50 60 70 80 90 100];
x = x';
y=[999.9 999.7 998.2 995.7 992.2 988.1 983.2 977.8 971.8 965.3 958.4];
y = y';

% Funktion = ax^2 + bx + c --> darum x.^2 | x | 1
A=[x.^2 x ones(length(x),1)];
lambda=A\y;

p=@(x)x^2*lambda(1)+x*lambda(2)+lambda(3);

yAusgeglichen=zeros(size(x));
for i=1:length(x)
    yAusgeglichen(i)=p(x(i));
end

% Konditionszahl berechnen
konditionszahl = cond(A'*A);
display(konditionszahl);
display(lambda);

% Vergleich des Wertes mit Polyval
pPolyfit=polyfit(x,y,2);
yPolyval=polyval(pPolyfit,x);   
display(pPolyfit');

plot(x,y,x,yAusgeglichen,x,yPolyval);
xlabel('Temperatur');
ylabel('Dichte');
legend('y ursprünglich','y Normalgleichung','y Polyfit');

% Da A'*A  sehr schlecht konditioniert ist, ist polyfit genauer.