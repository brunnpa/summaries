function [] = G3_S3_Aufg3_2(x,B,nmax)
if B > 9 || B < 1
    fprintf('Bitte wählen Sie die Basis B: 1 < B < 10\n');
else    
string_num_original = num2str(x);
string_num = num2str(x,nmax);
%vorzeichen isolieren
sign_num = sign(x);
if sign_num == -1
    string_num = string_num(2:end);
    sign_m = '-';
else 
    sign_m = '+';
end
%aufteilung in ganz- & komma-zahl
num = str2num(string_num);
i_num = fix(num);
f_num = num - i_num;
%loop für ganz-zahl: dezimal -> binär
i_num_conv = '';
d = 1;
i_num_conv_back = [];
while d ~= 0
    d = floor(i_num/B);
    i_num_conv_temp = num2str(mod(i_num,B));
    i_num_conv_back(end+1) = mod(i_num,B);
    i_num_conv = strcat(i_num_conv_temp , i_num_conv);
    i_num = d;
end
%loop für komma-zahl: dezimal -> binär
f_num_conv = '';
p = 0;
f_num_conv_back = [];
f_num_conv_temp_z = 0;
for index = 1:nmax   
    p = round((f_num*B), 10);
    f_num_conv_temp_z = fix(p);
    f_num_conv_temp = strcat(num2str(fix(p)));
    f_num_conv_back(end+1) = fix(p);
    f_num_conv = strcat(f_num_conv, f_num_conv_temp);
    f_num = p - f_num_conv_temp_z;
    if p == (B-1)
        f_num = 0;
    end
end
final_num = strcat(sign_m, i_num_conv, '.', f_num_conv);

%loop für ganz-zahl: binär -> dezimal
i_num_length = length(i_num_conv);
i_num_conv_err = 0;
i_potenz = 0;
zahl = 0;
for index = 1:i_num_length
    zahl = i_num_conv_back(index);
    i_num_conv_err = zahl * B^i_potenz + i_num_conv_err;
    i_potenz = i_potenz+1;
end
%loop für komma-zahl: binär -> dezimal
f_num_length = length(f_num_conv);
f_num_conv_err = 0;
f_potenz = -1;
for index = 1:f_num_length
zahl = f_num_conv_back(index);
    f_num_conv_err = zahl * B^f_potenz + f_num_conv_err;
    f_potenz = f_potenz-1;
end
%absoluter fehler
abs_err = abs((i_num_conv_err + f_num_conv_err) - x);
%relativer fehler
rel_err = abs(((i_num_conv_err + f_num_conv_err) - x)/x);
%werte als exp. darstellung
%value
exp_negativ = 0;
if x > -1 && x < 1
while x > -1 && x < 1
    x = x *10;
    exp_negativ = exp_negativ + 1;
end
exp_negativ_t = exp_negativ;
x = num2str(round(x,4));
exp_negativ = num2str(exp_negativ);
if exp_negativ_t < 10
    exp_negativ = strcat('0', exp_negativ);
end
value = strcat(x, 'e', '-', exp_negativ);
else
a_num_length = length(num2str(fix(num)));
exp = 10^(a_num_length-1);
exp_value = num2str(a_num_length-1);
exp_value_n = a_num_length-1;
if exp_value_n < 10
    exp_value = strcat('0', exp_value);
end
exp_value = strcat('+', exp_value);
rounder = 5 - a_num_length;
o_num = num2str((round(x,rounder))/exp);
value = strcat(o_num, 'e', exp_value);
end

%abs_err
exp_abs = 0;
if abs_err ~= 0
while abs_err > -1 && abs_err < 1  
    abs_err = abs_err *10;
    exp_abs = exp_abs + 1;
end
else
    abs_err = 0;
end
exp_abs_t = exp_abs;
abs_err = num2str(round(abs_err,4));
exp_abs = num2str(exp_abs);
if exp_abs_t < 10
    exp_abs = strcat('0', exp_abs);
end
abs_err = strcat(abs_err, 'e', '-', exp_abs);
%rel_err
exp_rel = 0;
if rel_err ~= 0
while rel_err > -1 && rel_err < 1  
    rel_err = rel_err *10;
    exp_rel = exp_rel + 1;
end
else
    rel_err = 0;
end
exp_rel_t = exp_rel;
rel_err = num2str(round(rel_err,4));
exp_rel = num2str(exp_rel);
if exp_rel_t < 10
    exp_rel = strcat('0', exp_rel);
end
rel_err = strcat(rel_err, 'e', '-', exp_rel);

%print
fprintf('y\t= %s\n', final_num);
fprintf('value\t= %s\n', value);
fprintf('abs_err\t= %s\n', abs_err);
fprintf('rel_err\t= %s\n', rel_err);

end