function    [x, y_euler, y_mittelpunkt, y_modeuler ] = eulerMittelMod(f, a, b, n, y0)

[x, y_euler]        = euler(f, a, b, n, y0);
[~, y_mittelpunkt]  = mittelpunkt(f, a, b, n, y0);
[~, y_modeuler]     = modeuler(f, a, b, n, y0);

[x, y_euler, y_mittelpunkt, y_modeuler];