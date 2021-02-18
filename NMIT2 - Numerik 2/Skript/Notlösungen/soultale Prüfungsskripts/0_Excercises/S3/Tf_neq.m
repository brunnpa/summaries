function [Itf_neq ] = Tf_neq(x,y)
%TF_NEQ Trapezregel für nicht äquidistante Punkte
%x: Punkte auf x achse
%y: Punkte auf y Achse

if ~(size(x)==size(y))
    error("x und y müssen dieselben Dimensionen haben");
end
Itf_neq = 0;

if (size(x,2) == 1)
    return
end


y_diff = (y(1:end-1) + y(2:end))./2;
x_diff = x(2:end) - x(1:end-1);

flaeche_intervalle = y_diff .* x_diff
Itf_neq =  sum(flaeche_intervalle);

end

