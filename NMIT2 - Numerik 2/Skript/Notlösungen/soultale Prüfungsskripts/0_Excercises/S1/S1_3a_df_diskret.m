function [dx] = S1_3a_df_diskret(x,y)
% dx = S1_3a([-2, -1, 0, 1, 2, 3, 4], [4, 1, 0, 1, 4, 9, 16]);
% expected dx = [-3, -2, 0, 2, 4, 6, 7]
% berechnet ableitung mit zentraler differenz ausser bei erstem und letzen
% punkt
if~(size(x)==size(y))
    error("x and y should be of same size");
end

dx = zeros(size(x));
n = size(x,2);
h = x(2:end) - x(1:(end-1));

dx(2:end-1) =(y(3:end)-y(1:end-2))./(h(1:end-1)+h(2:end));
dx(1)=(y(2) - y(1))./h(1);
dx(end)=(y(end) - y(end-1))./(x(end)-x(end-1));

end