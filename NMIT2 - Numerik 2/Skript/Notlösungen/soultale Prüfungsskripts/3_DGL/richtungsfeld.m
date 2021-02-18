function [ ] = richtungsfeld()
% Input args
% f: function handle (elemetwise vector operations
% hx: x step width
% hy: y step width
%f = @(x,y) x.^2 + y;
%xmin = 0;
%xmax = 3;
%ymin = -1.5;
%ymax = 1.5;
%hx = 0.5;
%hy = 0.5;
[X, Y] = meshgrid(xmin:hx:xmax,ymin:hy:ymax);
ydiff = f(X,Y);
sizeX = size(X);
quiver(X,Y,ones(sizeX(1), sizeX(2)), ydiff);
end

