Td=2;
y=zeros(1,600);
T1=1;
T2=100;
K=0.2;
alpha1=exp(-1/T1);
alpha2=exp(-1/T2);
a1=-alpha1-alpha2;
a2=alpha1*alpha2;
b1=K/(T1-T2) * (T1*(1-alpha1)-T2*(1-alpha2));
b2=K/(T1-T2) * (alpha1*T1*(1-alpha2)-alpha2*T1*(1-alpha1));

u=ones(1,600);


for k=Td+3:600
    y(k)=b1*u(k-Td-1)+b2*u(k-Td-2)-a1*y(k-1)-a2*y(k-2);
end
