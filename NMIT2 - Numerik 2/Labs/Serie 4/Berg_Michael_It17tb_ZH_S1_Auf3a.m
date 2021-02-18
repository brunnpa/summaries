function [dx] = Berg_Michael_It17tb_ZH_S1_Auf3a(x,y)
    len = length(x);
    dx(1) = (y(2) - y(1))/ (x(2) - x(1));
    for i = 2:(len-1)
        dx(i) = (y(i+1) - y(i-1)) / (x(i+1) - x(i-1));
    end
    dx(len) = (y(len) - y(len-1)) / (x(len) - x(len-1)); 
end