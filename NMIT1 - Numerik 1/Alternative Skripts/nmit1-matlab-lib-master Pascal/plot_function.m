% plotted die Funktion func mit ihrer ableitung und integration
%
% plot_function(@(x) x.^2, -7, 7)
%
% func = Funktion, die geploted werden soll
% xmin = minimun der X-Achse
% xmax = maximum der X-Achse
%
function plot_function(func, xmin, xmax)

funcDiff = ableiten(func);
funcInt = integrieren(func);

fplot(func)
hold on
fplot(funcDiff)
fplot(funcInt)
hold off

grid on
grid minor
axis([xmin xmax -inf inf])
legend('f(x)','f(x)/dx','F(x)');
end


% Dominique Reiser