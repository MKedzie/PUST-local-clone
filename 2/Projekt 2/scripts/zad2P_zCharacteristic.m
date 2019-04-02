Ypp = 0.0;
Upp = 0.0;
Zpp = 0.0;

delay = 8;
len = 250;
time = (1:len)';

z = ones(len, 1) * Zpp;
y = ones(len, 1) * Ypp;
u = ones(len, 1) * Upp;

samples = 0.0:0.02:1.5;
samples = samples';
zad2P_zCharacter = zeros(length(samples), 1);

for iter = 1 : length(samples)

    y = zeros(len, 1);
    z = samples(iter) * ones(len, 1);
    
    for k = delay:len
        y(k) = symulacja_obiektu8y(u(k-6), u(k-7), z(k-1), z(k-2), y(k-1), y(k-2));
    end
    
    zad2P_zCharacter(iter) = y(len);
    
end


plot(samples, zad2P_zCharacter);
zad2P_characteristic = [samples zad2P_zCharacter];
dlmwrite("../data/zad2P/zad2P_zCharacteristic.txt", zad2P_characteristic, '\t');