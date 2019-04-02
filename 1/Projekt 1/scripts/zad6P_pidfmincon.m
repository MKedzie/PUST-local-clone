x0  = [rand*rand*10 rand*rand*10 rand*rand*10];
fun = @(variables) zad6P_pidOptimalization(variables);
A = [1 0 0; 0 -1 0;0 0 -1];
b = [10 ; 0.001 ; 0 ];
x = fmincon(fun,x0,A,b);
[E,y,var,u] = zad6P_pid(x);