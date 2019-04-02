
% deklaracja zmiennych 
Ypp = 0.0;
Upp = 0.0;
Zpp = 0.0;

delay = 8;
len = 300;
time = (1:len)';

z = zeros(len, 1)*Zpp;
y = zeros(len, 1)*Ypp;

for uDifferent = 1.0:-0.2:-1.0
    u = zeros(len, 1)*Upp;
    u = u + uDifferent;
    y = zeros(len, 1)*Ypp;
    
    for k = delay:len
        y(k) = symulacja_obiektu8y(u(k-6), u(k-7), z(k-1), z(k-2), y(k-1), y(k-2));
    end
    
    zad2P_x = [time u];
    zad2P_y = [time y];

    dlmwrite("../data/zad2P/zad2P_uy" + num2str(10*uDifferent) + ".txt", zad2P_y, '\t');
end


