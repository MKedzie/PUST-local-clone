%% Wykorzystanie poprzedniego zadania do inicjalizacji, usuniecie zbednych elementow
zad3P;
close all;
clearvars -except delay s Upp Ypp;
%% Wybor regulatora
Regulator = 'PID';
% Regulator = 'DMC';
%% Inicjalizacja tablic do petli sterowania i trajektorii zadanej
lenght = 10000;
yZad = ones(lenght,1)*0.2;
yZad(1:lenght/4) = -0.5;
yZad(lenght/4:lenght*2/4) = 0;
yZad(lenght*2/4:lenght*3/4) = 0.25;
yZad(lenght*3/4:end) = 0.5;
y = zeros(lenght,1);
u = zeros(lenght,1);
u(1:20) = 0.2;
du = zeros(lenght,1);
duMax = 0.1;
uMax = 0.5;
uMin = -0.5;
%% Inicjalizacja regulatora DMC z maksymalnymi sensownymi parametrami - i lambda = 1 lub wpisanie parametrów regulatora PID
if strcmp(Regulator,'DMC')
    D = 150;
    N = 150;
    Nu =150;
    lambda = 1;
    duPop = zeros(D-1,1)';
    DMCStruct = zad4P_dmcGeneration(s,D,Nu,N,lambda);
end
if strcmp(Regulator,'PID')
    KKryt = 3.0125;
    TDrgan=26 ;
    % Wykomentowane s¹ Zieglera Nicholsa, zosta³y te które wyznaczy³em
    % eksperymentalnie
    K = KKryt * 1;
    Ti = TDrgan*0.3*Inf;
    Td = TDrgan*0.15*0;
    T = 0.5;
    r0 = K*(1 + T/(2*Ti) + Td/T);
    r1 = K*(T/(2*Ti) - 2*Td/T - 1);
    r2 = K*Td/T;
end
%% Petla symulacji
for i = delay:lenght
    y(i) = symulacja_obiektu8Y(u(i-10)+Upp,u(i-11)+Upp,y(i-1)+Ypp,y(i-2)+Ypp)-Ypp;
    if strcmp(Regulator,'DMC')
        du(i) = zad4P_dmc(DMCStruct,y(i),yZad(i),duPop);
        duPop = zad4P_duNew(duPop,du(i));        
    end
    
    if strcmp(Regulator,'PID')
        du(i) = zad4P_pid(r2,r1,r0,yZad(i),yZad(i-1),yZad(i-2),y(i),y(i-1),y(i-2));
    end
    if du(i) > duMax
        du(i) = duMax;
    end
    if du(i) < -duMax
        du(i) = -duMax;
    end
    u(i) = u(i-1) + du(i);
    if u(i) > uMax 
        u(i) = uMax;
    end
    if u(i) < uMin
        u(i) = uMin;
    end
end
y = y + Ypp;
u = u + Upp;
yZad = yZad + Ypp;
times = [1:lenght];
E = 0;
for i = 1:lenght
    E = E + ( y(i) - yZad(i) )^2;
end

figure;
subplot(2,1,1);
plot(times,y,times,yZad);
title("Wyjscie");
subplot(2,1,2);
plot(u);
title("Sterowanie");
