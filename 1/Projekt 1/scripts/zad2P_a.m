
% deklaracja zmiennych 
Ypp = 1.7;
Upp = 1;
delay = 12;
length = 300;
time = (1:length)';


for uDifferent = 1.0:-0.2:-1.0
    u = ones(length)*Upp;
    y = ones(length)*Ypp;
    u = u + uDifferent;
    
    for i = delay:length
        y(i) = symulacja_obiektu8Y(u(i-10),u(i-11),y(i-1),y(i-2));
    end
    
    zad2P_x = [time, x];
    zad2P_y = [time, y];
    
    dlmwrite("data/zad2P_x" + num2str(uDifferent) + ".txt", zad2P_x, '\t');
    dlmwrite("data/zad2P_y" + num2str(uDifferent) + ".txt", zad2P_y, '\t');
end

