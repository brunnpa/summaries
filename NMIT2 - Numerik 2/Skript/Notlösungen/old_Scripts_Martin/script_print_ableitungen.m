% Clear Command Window
clc

f = log(x^2);             % TODO: Funktion setzen
fDiff = diff(f);          % 1. Ableitung
fDiff2 = diff(fDiff);     % 2. Ableitung
fDiff3 = diff(fDiff2);    % 3. Ableitung
fDiff4 = diff(fDiff3);    % 4. Ableitung
fDiff5 = diff(fDiff4);    % 5. Ableitung
fDiff6 = diff(fDiff5);    % 6. Ableitung
fDiff7 = diff(fDiff6);    % 7. Ableitung

fprintf('***************************************************\n');
fprintf('Ableitungen 1-7:\n');
fprintf('***************************************************\n');
fprintf('f(x): %s\n\n', f);
fprintf('***************************************************\n');
fprintf('fDiff1(x): %s\n\n', fDiff);
fprintf('***************************************************\n');
fprintf('fDiff2(x): %s\n\n', fDiff2);
fprintf('***************************************************\n');
fprintf('fDiff3(x): %s\n\n', fDiff3);
fprintf('***************************************************\n');
fprintf('fDiff4(x): %s\n\n', fDiff4);
fprintf('***************************************************\n');
fprintf('fDiff5(x): %s\n\n', fDiff5);
fprintf('***************************************************\n');
fprintf('fDiff6(x): %s\n\n', fDiff6);
fprintf('***************************************************\n');
fprintf('fDiff7(x): %s\n\n', fDiff7);
fprintf('***************************************************\n');