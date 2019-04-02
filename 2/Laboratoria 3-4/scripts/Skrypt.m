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
    if abs(y(k) - yZad(k)) < 0.001 && check == 0
        z(k:end)  = 1;
        check = 1;
    end
    du(k) = zad5P_dmc(DMCStruct,y(k),yZad(k),duPop,dzPop);
    u(k)= u(k-1) + du(k);   
    duPop(2:end) = duPop(1:end-1);
    duPop(1) = du(k);
    dz = z(k) - z(k-1);
    dzPop(2:end) = dzPop(1:end-1);
    dzPop(1) = dz;
end
times = [1:len]';

zad5P_characteristic = [times y];
zad5P_characteristic_u = [times u];
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
nazwa = "../data/zad5P/zad5P_DMC_"+num2str(Dz)+"_"+Estr+".txt";
nazwau = "../data/zad5P/zad5P_DMC_"+num2str(Dz)+"_"+Estr+"_u.txt";
dlmwrite(nazwa, zad5P_characteristic, '\t');
dlmwrite(nazwau, zad5P_characteristic_u, '\t');