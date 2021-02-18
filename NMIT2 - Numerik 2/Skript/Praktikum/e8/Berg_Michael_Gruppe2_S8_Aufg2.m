function [] = Berg_Michael_Gruppe2_S8_Aufg2()
    % h
    delta_t = 0.5;

    a = 0;
    b = 1;
    h = 0.5;
    n = abs(b-a)/h;


    x = a:delta_t:b;
    y0 = [2; 0; 0];

    f = @(x, z)[z(2); z(3); 10*exp(-x) - 5*z(3) - 8*z(2) - 6*z(1)];

    [x, y] = runge_kutta_4(f, a, b, n, y0);

    plot(x,y(1, :));
end