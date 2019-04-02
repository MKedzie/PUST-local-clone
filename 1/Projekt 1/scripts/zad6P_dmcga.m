x0  = [2 2 0.01];
fun = @(variables) zad6P_dmcOptimalization(variables);
A = [1 0 0;0 1 0;0 0 1];
b = [100 ; 100 ; 10000];
x = ga(fun,3,A,b,[],[],[ 2 2 0.1 ], [ 150 150 1000],[],[1 2 3]);
[E,y,var,u] = zad6P_dmc(x);