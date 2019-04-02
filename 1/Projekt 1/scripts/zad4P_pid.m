function [du] = zad4P_pid(r2,r1,r0,y_zadane,y_zadanemniej1,y_zadanemniej2,y_k,y_kmniej1,y_kmniej2)
    e = y_zadane-y_k;
    e_mniej1 = y_zadanemniej1-y_kmniej1;
    e_mniej2 = y_zadanemniej2-y_kmniej2;
    u2 = r2*e_mniej2;
    u1 = r1*e_mniej1;
    u0 = r0*e;
    du=(u2)+(u1)+(u0);
end

