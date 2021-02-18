% PARTIELLE ABLEITUNG
%
%
% INPUT:
% Funktion nach welcher abgeleitet werden soll
%
% OUTPUT:
% fx = Partielle Ableitung für fx
% fy = Partielle Ableitung für fy
%
% BEISPIELAUFRUF:
% Pascal_Brunner_PartielleAbleitung(x*y^2*(sin(x) + sin(y)))
%

function Pascal_Brunner_PartielleAbleitung(func)
% Variablen definieren
syms x y z

% Funktion definieren
f = func;

% REMINDER: 
% Für jeden Inputparameter soll auch die partielle Ableitung angegeben werden

% 1. Partielle Ableitung für x
xPartAbl = diff(f, x);

% 1. Partielle Ableitung für y
yPartAbl = diff(f, y); 

disp('fx = ');
disp(xPartAbl);
disp('fy = ');
disp(yPartAbl);



end