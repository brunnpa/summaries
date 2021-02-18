function [ x, y ] = euler(f,a,b,n,y0)
%Input args
% f: function handle (elementwise vector ops)
% a: start interval
% b: end interval
% n: num steps
% y0: start value
% steigung an ausgangs punkt zur direkten eruierung von y(i+1)
% mittels Taylor kann gezeigt werden: lokaler Fehler phi(xn,h)=h^2/2.*y''(x) 
% => Konsistenzordnung p=1
% globaler Fehler => Konvergenzordnung = 1

h = (b-a)./n;
if numel(y0) == 1
    y = zeros(1, n+1);
    x = zeros(1, n+1);
    x(1) = a;
    y(1) = y0;
    for i=1:n
        x(i+1) = x(i) + h;
        y(i+1) = y(i) + h .* f(x(i),y(i));
    end
elseif size(y0,1) > 1
    x = a:h:b;
    n = size(x,2);
    y = zeros(size(y0,1),n);
    y(:,1) = y0;
    for i=1:(n-1)
        y(:,i+1) = y(:,i) + h.*f(x(i),y(:,i));
    end
elseif size(y0,2) > 1
    error("input-Vektor muss Spalten-Vektor sein");
end

