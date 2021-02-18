%Calculate Easter
for i = 1900 : 2099
    Y = i;
    B = 225-11*(mod(Y, 19));
    D = mod((B-21), 30) + 21;
    if D > 48
       D = D-1; 
    end
    E = mod((Y + floor((Y/4)) + D + 1),7);
    Q = D + 7 - E;
    if Q < 32
       day = floor(Q);
       month = "March";
    else
       day = floor(Q - 31);
       month = "April";
    end
    fprintf('Easter-Date for %i : %i %s\n', Y, day, month);
end
