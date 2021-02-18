x=[0 10 20 30 40 50 60 70 80 90 100]';
y=[999.9 999.7 998.2 995.7 992.2 988.1 983.2 977.8 971.8 965.3 958.4]';

A=[x.^2 x ones(length(x),1)];
lambda=A\y;
lambda2=(A'*A)\(A'*y);

p=@(x)x^2*lambda(1)+x*lambda(2)+lambda(3);

y2=zeros(size(x));
for i=1:length(x)
    y2(i)=p(x(i));
end

Konditionszahl = cond(A'*A);
display(Konditionszahl);

p2=polyfit(x,y,2);
y3=polyval(p2,x);   
display(lambda);
display(p2');

plot(x,y,x,y2,x,y3);
xlabel('Temperatur');
ylabel('Dichte');
legend('y-Daten','y2-Normalgl.','y3-polyfit');

% Da A'*A  sehr schlecht konditioniert ist, ist polyfit genauer.