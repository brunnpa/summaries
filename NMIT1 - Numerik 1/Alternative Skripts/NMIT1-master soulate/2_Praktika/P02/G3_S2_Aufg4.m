function G3_S2_Aufg4()
format long;
ep2=1;
while 1+ep2/2~=1
  ep2=ep2/2;
end

ep10=1;
while 1+ep10/10~=1
  ep10=ep10/10;
end

disp(sprintf(['Maschinengenauigkeit dual: \t 5', num2str(ep2)]))

disp(sprintf(['Maschinengenauigkeit dezimal: \t 5', num2str(ep10)]))

disp(sprintf(['Maschinengenauigkeit mein PC: \t 5', num2str(eps)]))

end