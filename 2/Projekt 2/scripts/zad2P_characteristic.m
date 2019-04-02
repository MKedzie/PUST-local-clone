
% deklaracja zmiennych 

Upp = 0.0;
Ypp = 0.0;
Zpp = 0.0;

delay = 8;
len = 250;
count = 1;

u = ones(len, 1) * Upp;
y = ones(len, 1) * Ypp;
z = ones(len, 1) * Zpp;

long = 50;

Z = linspace(-100, 100, long);
U = linspace(-100, 100, long);

yKon = zeros(long*long, 1);
uKon = zeros(long*long, 1);
zKon = zeros(long*long, 1);

for iterU = 1 : length(U)
    u = U(iterU) * ones(len, 1);
    for iterZ = 1 : length(Z)
        z = Z(iterZ) * ones(len, 1);
        y = zeros(len, 1);

        for k = delay:len
            y(k) = symulacja_obiektu8y(u(k-6), u(k-7), z(k-1), z(k-2), y(k-1), y(k-2));
        end
        uKon(count) = u(iterU);
        zKon(count) = z(iterZ);
        yKon(count) = y(len);
        count = count + 1;
    end
end

zad2P_character = [uKon zKon yKon];

% zapis do pliku

dlmwrite('../data/zad2P/zad2P_characteristic.txt', zad2P_character, '\t')
