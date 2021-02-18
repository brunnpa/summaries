%Aufg1
syms x;
f =  cos(x);
fdiff = diff(f);

f = matlabFunction(f);
fdiff = matlabFunction(fdiff);

clear x;

counter = 1;
for x=-pi:0.01:pi
    c(counter) = abs(fdiff(x)).*abs(x) / abs(f(x));
    counter = counter+1;
end
x=-pi:0.01:pi;
plot(x,c);