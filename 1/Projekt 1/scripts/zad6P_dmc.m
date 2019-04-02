function [E,y,var,u] = zad6P_dmc(variables)
    var = variables;
    D = 100;
    Nu = variables(1);
    N = variables(2);
    lambda = variables(3);
    %% Wykorzystanie poprzedniego zadania do inicjalizacji, usuniecie zbednych elementow
    run('zad3P.m');
    close all;
    clearvars -except var delay s Upp var Ypp D Nu N lambda;
    %% Wybor regulatora
    Regulator = 'DMC';
    %% Inicjalizacja tablic do petli sterowania i trajektorii zadanej
    lenght = 1000;
    Ypp = 1.7;
    Upp = 1;
    yZad = zeros(lenght,1);
    yZad(1:lenght/4) = -0.5;
    yZad(lenght/4:lenght*2/4) = 0;
    yZad(lenght*2/4:lenght*3/4) = 0.25;
    yZad(lenght*3/4:end) = 0.5;
    y = zeros(lenght,1);
    u = zeros(lenght,1);
    du = zeros(lenght,1);
    duMax = 0.1;
    uMax = 0.5;
    uMin = -0.5;
    %% Inicjalizacja regulatora DMC z maksymalnymi sensownymi parametrami - i lambda = 1 lub wpisanie parametrów regulatora PID
    if strcmp(Regulator,'DMC')
        duPop = zeros(D-1,1)';
        DMCStruct = zad4P_dmcGeneration(s,D,Nu,N,lambda);
    end
    %% Petla symulacji
    for i = delay:lenght
        y(i) = symulacja_obiektu8Y(u(i-10)+Upp,u(i-11)+Upp,y(i-1)+Ypp,y(i-2)+Ypp)-Ypp;
        if strcmp(Regulator,'DMC')
            du(i) = zad4P_dmc(DMCStruct,y(i),yZad(i),duPop);
            duPop = zad4P_duNew(duPop,du(i));        
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
    E = 0;
    yZad = yZad + Ypp;
    y = y + Ypp;
    u = u + Upp;
    for i = 1:lenght
        E = E + (yZad(i)-y(i))^2;
    end
    plot(y);
end

