
% deklaracja zmiennych 

Ypp = 1.7;
Upp = 1;
delay = 12;
len = 250;
time = (1:len)';

samples = 0.5:0.02:1.5;
samples = samples';
zad2P_yCharacteristic = zeros(length(samples), 1);

for iter = 1 : length(samples)

    y = zeros(len, 1);
    u = samples(iter) * ones(len, 1);
    
    for i = delay:len
        y(i) = symulacja_obiektu8Y(u(i-10),u(i-11),y(i-1),y(i-2));
    end
    
    zad2P_yCharacteristic(iter) = y(len);
    
end


plot(samples, zad2P_yCharacteristic);
zad2P_characteristic = [samples zad2P_yCharacteristic];
dlmwrite("data/zad2P_characteristic.txt", zad2P_characteristic, '\t');