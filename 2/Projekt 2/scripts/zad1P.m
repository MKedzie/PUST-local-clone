

% czas trwania symulacji
len = 250;

Ypp = 0.0;
Upp = 0.0;
Zpp = 0.0;


% wyjscie obiektu
y = zeros(len, 1);
% wejscie obiektu
u = ones(len, 1) * Upp;
% zaklocenie obiektu
z = ones(len, 1) * Zpp;

time = (1 : len)';

delay = 8;

for k = delay : len
    y(k) = symulacja_obiektu8y(u(k-6), u(k-7), z(k-1), z(k-2), y(k-1), y(k-2));
end

plot(time, u)
plot(time, y)
plot(time, z)

% zapis w notacji: czas, wyj?cie

zad1P_y = [time y];
zad1P_x = [time u];
zad1P_z = [time z];

% zapisujemy dane do pliku

dlmwrite('../data/zad1P/zad1P_x.txt', zad1P_x, '\t')
dlmwrite('../data/zad1P/zad1P_y.txt', zad1P_y, '\t')
dlmwrite('../data/zad1P/zad1P_z.txt', zad1P_z, '\t')
