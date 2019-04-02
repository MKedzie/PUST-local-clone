function [du] = zad4P_dmc(dmcMacierze,yAktualne,yZadane, duPop)
    % obliczenie zmiany sterowania du w danej chwili. Metoda nieoptymalna,
    % zwraca tylko du(k|k)
    Mp = dmcMacierze.Mp;
    N = dmcMacierze.N;
    K = dmcMacierze.K;
    yk = ones(N,1) * yAktualne;
    y0 = yk + Mp * duPop';
    du = K * ( yZadane - y0);
    du = du(1,1);
end
