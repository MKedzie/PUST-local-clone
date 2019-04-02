%% Wykorzystanie poprzedniego zadania do inicjalizacji, usuniecie zbednych elementow
zad3P_su;
zad3P_sz;
clearvars -except delay su sz;
%% Inicjalizacja tablic do petli sterowania i trajektorii zadanej
len = 1000;
yZad = ones(len,1);

y = zeros(len,1);
u = zeros(len,1);
z = zeros(len,1);
for i = 1 : len
    z(i) = 1 * sin(0.05*i);
end
zMeasureError = load('error.mat','error');
zMeasureError = zMeasureError.error;
zMeasureErrorMultiplier = 2;
zMeasureError = zMeasureError * zMeasureErrorMultiplier;
du = zeros(len,1);
%% Inicjalizacja regulatora DMC z maksymalnymi sensownymi parametrami - i lambda = 1
D = 150;
N = 15;
Nu = 7;
lambda = 4;
Dz = 9;
duPop = zeros(D-1,1)';
dzPop = zeros(Dz-1,1)';
DMCStruct = zad5P_dmcGeneration(su,D,Nu,N,lambda,sz,Dz);
check = 0;
%% Petla symulacji
for k = delay:len
    y(k) = symulacja_obiektu8y(u(k-6), u(k-7), z(k-1), z(k-2), y(k-1), y(k-2));
    du(k) = zad5P_dmc(DMCStruct,y(k),yZad(k),duPop,dzPop);
    u(k)= u(k-1) + du(k);   
    duPop(2:end) = duPop(1:end-1);
    duPop(1) = du(k);
    dz =z(k)-z(k-1)+zMeasureError(k)-zMeasureError(k-1);
    dzPop(2:end) = dzPop(1:end-1);
    dzPop(1) = dz;
end
times = [1:len]';

zad7P_characteristic = [times y];
zad7P_characteristic_u = [times u];
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
zMeasureErrorMultiplierstr = num2str(zMeasureErrorMultiplier);
zMeasureErrorMultiplierstr = erase(zMeasureErrorMultiplierstr,'.');
nazwa = "../data/zad7P/zad7P_DMC_"+zMeasureErrorMultiplierstr+".txt";
nazwau = "../data/zad7P/zad7P_DMC_"+zMeasureErrorMultiplierstr+"_u.txt";
dlmwrite(nazwa, zad7P_characteristic, '\t');
dlmwrite(nazwau, zad7P_characteristic_u, '\t');