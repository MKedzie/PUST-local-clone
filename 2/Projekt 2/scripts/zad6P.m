%% Wykorzystanie poprzedniego zadania do inicjalizacji, usuniecie zbednych elementow
zad3P_su;
zad3P_sz;
clearvars -except delay su sz;
%% Ustawienie, czy pomiar zak³ócenia ma miejsce czy nie. Logika binarna 1 - tak 0 - nie
disruptionMeasure = 1;

%% Inicjalizacja tablic do petli sterowania i trajektorii zadanej
len = 1000;
yZad = ones(len,1);

y = zeros(len,1);
u = zeros(len,1);
z = zeros(len,1);
frequency = 0.01;
size = 1;
for i = 1 : len
    z(i) = size * sin(frequency*i);
end
du = zeros(len,1);
%% Inicjalizacja regulatora DMC z maksymalnymi sensownymi parametrami - i lambda = 1
D = 150;
N = 30;
Nu = 5;
lambda = 5;
Dz = 10;
duPop = zeros(D-1,1)';
dzPop = zeros(Dz-1,1)';
if disruptionMeasure == 1
    DMCStruct = zad5P_dmcGeneration(su,D,Nu,N,lambda,sz,Dz);
else
    DMCStruct = zad4P_dmcGeneration(su,D,Nu,N,lambda);
end
check = 0;
%% Petla symulacji
for k = delay:len
    y(k) = symulacja_obiektu8y(u(k-6), u(k-7), z(k-1), z(k-2), y(k-1), y(k-2));
    if disruptionMeasure == 1
        du(k) = zad5P_dmc(DMCStruct,y(k),yZad(k),duPop,dzPop);
    else
        du(k) = zad4P_dmc(DMCStruct,y(k),yZad(k),duPop);
    end
    u(k)= u(k-1) + du(k);   
    duPop(2:end) = duPop(1:end-1);
    duPop(1) = du(k);
    dz = z(k) - z(k-1);
    dzPop(2:end) = dzPop(1:end-1);
    dzPop(1) = dz;
end
times = [1:len]';

zad6P_characteristic = [times y];
zad6P_characteristic_u = [times u];
zad6P_zadane = [times yZad];
E = 0;

for i = 1:len
    E = E + ( y(i) - yZad(i) )^2;
end
E
plot(y);
nazwa = "../data/zad6P/zad6P_DMC_"+num2str(disruptionMeasure)+"_"+num2str(frequency)+"_"+num2str(size)+".txt";
nazwau = "../data/zad6P/zad6P_DMC_"+num2str(disruptionMeasure)+"_"+num2str(frequency)+"_"+num2str(size)+"_u.txt";
dlmwrite(nazwa, zad6P_characteristic, '\t');
dlmwrite(nazwau, zad6P_characteristic_u, '\t');