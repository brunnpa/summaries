x = 0:0.1:6;
n = 60;
h = 0.1;
sum1 = 0;
sum2 = 0;

for i = 2:1:n
    sum1 = sum1 + func(x(i));
end

for i = 2:1:n+1
    sum2 = sum2 + func((x(i-1)+x(i))/2);
end

display(sum1);
display(sum2);

Sf = (h/3)*((0.5*1)+sum1+(2*sum2)+(0.5*func(6)));

display(Sf);

func2 = @(x) 4/((1 + 4*(x^2))^(3/2));

maxi = 0;
maxy = 0;

for i = 1:1:n+1
    tmp = abs(func(x(i)));
    if(tmp > maxi)
        maxy = tmp;
        maxi = i;
    end
end

display(maxi);
display(maxy);
display(x(maxi));