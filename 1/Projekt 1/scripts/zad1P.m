
% czas trwania symulacji
length = 250;

Ypp = 1.7;
Upp = 1.0;

% wyjscie obiektu
y = zeros(length, 1);
% wejscie obiektu
u = ones(length, 1) * Upp;

time = (1 : length)';

delay = 12;

for k = delay : length
    y(k) = symulacja_obiektu8Y(u(k-10), u(k-11), y(k-1), y(k-2));
end


%time = (delay:length)';
%u = u';
%y = y';

%plot(time, u)
%plot(time, y)

% zapis w notacji: czas, wyj?cie

zad1P_y = [time y];
zad1P_x = [time u];

% zapisujemy dane do pliku

dlmwrite('data/zad1P_x.txt', zad1P_x, '\t')
dlmwrite('data/zad1P_y.txt', zad1P_y, '\t')


