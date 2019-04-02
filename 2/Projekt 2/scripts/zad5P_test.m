%% Wykorzystanie poprzedniego zadania do inicjalizacji, usuniecie zbednych elementow
zad3P_su;
clearvars -except delay su
%% Inicjalizacja tablic do petli sterowania i trajektorii zadanej
len = 100;
yZad = ones(len,1);

y = zeros(len,1);
u = zeros(len,1);
z = zeros(len,1);
du = zeros(len,1);
%% Inicjalizacja regulatora DMC z maksymalnymi sensownymi parametrami - i lambda = 1
D = 150;
N = 15;
Nu = 5;
lambda = 5;
duPop = zeros(D-1,1)';
DMCStruct = zad4P_dmcGeneration(su,D,Nu,N,lambda);
check = 0;
%% Petla symulacji
for k = delay:len
    y(k) = symulacja_obiektu8y(u(k-6), u(k-7), z(k-1), z(k-2), y(k-1), y(k-2));
    if abs(y(k) - yZad(k)) < 0.001 && check == 0
        z(k:end)  = 1;
        check = 1;
    end
    du(k) = zad4P_dmc(DMCStruct,y(k),yZad(k),duPop);
    u(k)= u(k-1) + du(k);   
    duPop(2:end) = duPop(1:end-1);
    duPop(1) = du(k);
end
times = [1:len]';

zad5P_characteristic = [times y];
zad5P_characteristic_u = [times u];
E = 0;

for i = 1:len
    E = E + ( y(i) - yZad(i) )^2;
end
E
Estr = num2str(E);
Estr = erase(Estr,".");
if ( max(size(Estr)) > 6 )
    Estr = Estr(1:6);
end
plot(y);
nazwa = "../data/zad5P/zad5P_bez_pomiaru.txt";
nazwau = "../data/zad5P/zad5P_bez_pomiaru_u.txt";
dlmwrite(nazwa, zad5P_characteristic, '\t');
dlmwrite(nazwau, zad5P_characteristic_u, '\t');