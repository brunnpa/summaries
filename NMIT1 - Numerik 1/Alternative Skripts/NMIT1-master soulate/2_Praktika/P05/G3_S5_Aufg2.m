function G3_S5_Aufg2()
clear

iterations = 200;

a = 0.1;

k = zeros(iterations, 1);
k(1) = 0.1;

for i=1:1:iterations
    k(i+1) = a * k(i) * (1 - k(i));
end
plot(k, 'b')
hold on

a = 1;
for i=1:1:iterations
    k(i+1) = a * k(i) * (1 - k(i));
end
plot(k, 'k')

a = 1.05;
for i=1:1:iterations
    k(i+1) = a * k(i) * (1 - k(i));
end
plot(k, 'g')

a = 2;
for i=1:1:iterations
    k(i+1) = a * k(i) * (1 - k(i));
end
plot(k, 'r')

a = 4;
for i=1:1:iterations
    k(i+1) = a * k(i) * (1 - k(i));
end
plot(k, 'c')

legend('a 0.1', 'a 1', 'a 1.05', 'a 2', 'a 4')
ylabel('kranke Kinder');
xlabel('Zeit');

%a)
%Die Fkt konvergiert nur f?r kleine Infektionsraten.
%Wird die Infektionsraten zu gross sind irgendwann all kinder krank und
%werden dann alle pl?tzlich wieder gesund. (z.B bei 4)

%b)
%Ab welcher Anzahl erkrankter Kinder sich gleich soviele Kinder anstecken
%wie gesund werden.
