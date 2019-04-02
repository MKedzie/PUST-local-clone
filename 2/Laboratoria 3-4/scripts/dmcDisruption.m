function [du] = dmcDisruption(dmcMacierze,yAktualne,yZadane, duPop, dzPop)
    % obliczenie zmiany sterowania du w danej chwili. Metoda nieoptymalna,
    % zwraca tylko du(k|k)
    Mp = dmcMacierze.Mp;
    Mpz =dmcMacierze.Mpz;
    N = dmcMacierze.N;
    K = dmcMacierze.K;
    yk = ones(N,1) * yAktualne;
    y0 = yk + Mp * duPop' + Mpz * dzPop';
    du = K * ( yZadane - y0);
    du = du(1,1);
end
