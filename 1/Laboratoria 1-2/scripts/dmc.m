function [du] = dmc(dmcMacierze,yAktualne,yZadane, duPop)
	Mp = dmcMacierze.Mp;
	N = dmcMacierze.N;
	K = dmcMacierze.K;
	D = dmcMacierze.D;
	yk = ones(N,1) * yAktualne;
	y0 = yk + Mp * duPop';
	du = K * ( yZadane - y0);
	du = du(1,1);
end
