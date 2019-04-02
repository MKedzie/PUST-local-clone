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
Nu = 7;
lambda = 4;
duPop = zeros(D-1,1)';
DMCStruct = zad4P_dmcGeneration(su,D,Nu,N,lambda);
%% Petla symulacji
for k = delay:len
    y(k) = symulacja_obiektu8y(u(k-6), u(k-7), z(k-1), z(k-2), y(k-1), y(k-2));    
    du(k) = zad4P_dmc(DMCStruct,y(k),yZad(k),duPop);
    u(k)= u(k-1) + du(k);   
    duPop(2:end) = duPop(1:end-1);
    duPop(1) = du(k);
end
times = [1:len]';

zad4P_characteristic = [times y];
zad4P_characteristic_u = [times u];
zad4P_zadane = [times yZad];
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
nazwa = "../data/zad4P/zad4P_DMC_"+num2str(D)+"_"+num2str(N)+"_"+num2str(Nu)+"_"+num2str(lambda) + "_"+Estr+".txt";
nazwau = "../data/zad4P/zad4P_DMC_"+num2str(D)+"_"+num2str(N)+"_"+num2str(Nu)+"_"+num2str(lambda) + "_"+Estr+"_u.txt";
% nazwa = "../data/zad4P/zad4P_DMC_l_"+num2str(lambda)+".txt";
% nazwau = "../data/zad4P/zad4P_DMC_l"+"_"+num2str(lambda)+"_u.txt";
dlmwrite(nazwa, zad4P_characteristic, '\t');
dlmwrite(nazwau, zad4P_characteristic_u, '\t');