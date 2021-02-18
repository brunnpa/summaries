function [ yy ] = Spline_Interpolation(x,y,xx)

n = length(x)-1;
a = zeros(1, n);
h = zeros(1, n);
c = zeros(1,n+1);
b = zeros(1, n);
d = zeros(1, n);
yy = zeros(1,length(xx));

%Die a und h Koeffizienten berechnen
for i = 1:1:n
   a(i) = y(i);
   h(i) = x(i+1)-x(i);
end

%Die c Koeffizienten mit Hilfe einer linearen Gleichung berechnen
A = zeros(n-1);
z = zeros(n-1,1);
for i = 1:1:n-1
    A(i,i) = 2*(h(i)+h(i+1));
    
    if(i > 1)
       A(i, i-1) = h(i); 
    end
    if(i < (n-1))
       A(i, i+1) = h(i+1); 
    end
    z(i) = (3*((y(i+2)-y(i+1))/h(i+1)))-(3*((y(i+1)-y(i))/h(i)));
end
ctemp = linsolve(A,z);
c = [0; ctemp; 0];

%Koeffizienten b und d berechnen
for i = 1:1:n
   b(i) = ((y(i+1)-y(i))/h(i))-((h(i)/3)*(c(i+1)+(2*c(i))));
   d(i) = (1/(h(i)*3))*(c(i+1)-(c(i)));
end

for i = 1:1:n
    r = find(x(i)<=xx & xx<=x(i+1));
    if(isempty(r) == 0)
         for counter = 1:1:length(r);
            value = xx(r(counter));
            yy(r(counter)) = a(i)+(b(i)*(value-x(i)))+(c(i)*((value-x(i))^2))+(d(i)*((value-x(i))^3));
         end
    end
end

end
