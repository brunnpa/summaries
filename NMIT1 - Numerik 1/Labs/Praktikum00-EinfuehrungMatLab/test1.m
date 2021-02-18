%Dies ist mein erstes Skript
A = rand(101, 4); x = [0:5:500];
for i = 1:4,
    subplot(2,2,i), plot(x, A(:, i), 'b');
end
