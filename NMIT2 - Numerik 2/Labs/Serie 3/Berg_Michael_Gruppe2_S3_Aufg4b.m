function [mass_earth, rel_err, abs_err] = Berg_Michael_Gruppe2_S3_Aufg4b()

radius = [0 800000 1200000 1400000 2000000 3000000 3400000 3600000 4000000 5000000 5500000 6370000];
density = [13000 12900 12700 12000 11650 10600 9900 5500 5300 4750 4500 3300];
correct_mass = 5.972e+24;

f = @(radius, density) density * 4 * pi * (radius.^2);

for i=1:size(radius,2)
    y(i) = f(radius(i),density(i));
end

mass_earth = Berg_Michael_Gruppe2_S3_Aufg4a(radius,y);
abs_err = abs(mass_earth - correct_mass);
rel_err = abs_err/correct_mass;

end