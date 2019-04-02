% deklaracja zmiennych

Ypp = 36.06;
Upp = 33;

delay = 12;
len = 300;
time = (1:len)';
u = ones(len,1)*Upp;
y = ones(len,1)*Ypp;
du = 0.5;

for i = delay:len
    u(i) = u(i)+du;
    y(i) = symulacja_obiektu8Y(u(i-10),u(i-11),y(i-1),y(i-2));
end


% normalizujemy odpowiedz skokowa
y = (y - Ypp)/du;

% zapis znormalizowanej odpowiedzi skokowej

zad3P_stepResponse = [time y];
dlmwrite("data/zad3L_stepResponse.txt", zad3P_stepResponse, '\t');

s = y(delay:end);
s = s - y(delay-1);

% na okolo 150 wartosci praktycznie si? nie zmieniaja
s = s(1:150);

zad3P_coeff = [(1:150)' s];

dlmwrite("data/zad3L_coeff.txt", zad3P_coeff, '\t');