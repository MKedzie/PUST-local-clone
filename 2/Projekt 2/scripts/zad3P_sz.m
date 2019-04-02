% deklaracja zmiennych 
dz = 1;
delay = 8;
len = 300;
time = (1:len)';

u = zeros(len+delay-1, 1);
z = zeros(len+delay-1, 1);
y = zeros(len+delay-1, 1);
z(delay-6:end) = dz;

for k = delay:len+delay
        y(k) = symulacja_obiektu8y(u(k-6), u(k-7), z(k-1), z(k-2), y(k-1), y(k-2));
end
y = y(delay:end-1);
sz = (y)/du;
zad3P = [time sz];
% plot(y);
dlmwrite("../data/zad3P/zad3P_sz.txt", zad3P, '\t');