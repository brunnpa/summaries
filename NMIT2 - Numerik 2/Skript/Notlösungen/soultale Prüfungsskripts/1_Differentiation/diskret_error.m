function [diskret_error] = diskret_error(df, fdiff_analyt, x0, h)
%df: numerische Lösung an x0 mit h0
%fdiff_analyt: analytische Lösung
%x0: 
%h: Schrittweiten

analyt_sol = fdiff_analyt(x0);
diskret_error = abs(df - analyt_sol);

if exist('h', 'var')
    rownames = strings(size(h));
    rownames(:) = "err mit h=";
    rownames = join([rownames;string(h)],'',1);  
end

rownames = ["Diskretisierungsfehler h/x0 für " + inputname(1); rownames'];

diskret_error_table = [string(x0); diskret_error];
diskret_error_table = [rownames, diskret_error_table];
%disp(diskret_error_table);
end

