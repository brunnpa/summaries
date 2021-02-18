function Aufgabe6a_plotten_brunnpa7

    f1(x,y) = x.^2 + y.^2 -1;
    f2(x,y) = x - y.^2;
    
    [x,y] = meshgrid(-10 : 1 : 10);
    
    mesh(x,y,z);

end
