function [DMCMacierze] = zad5P_dmcGeneration(s,D,Nu,N,lambda,sz,Dz)
    
    % zwracana jest struktura DMC_macierze z nastepujacymi polami:
    % .M -> macierz M
    % .Mp -> macierz Mp
    % .K -> macierz K
    % .N -> wartosc N dla ktorej byly generowane
    % .Nu -> wartosc Nu dla ktorej byly generowane
    % .D -> wartosc D dla ktorej byly generowane
    M=zeros(N,Nu);
    Mp=zeros(N,D-1);
    
    for i=1:N           
        for j=1:Nu
            if i>=j
                %oblicznie M
                M(i,j)=s(i-j+1);
            end
        end
    end
    
    for i=1:N
        for j=1:D-1
            if i+j<D
                %oblicznie Mp
                Mp(i,j)=s(i+j)-s(j);
            else
                Mp(i,j)=s(D)-s(j);
            end
        end
    end
    
    K = ((M'*M + lambda*eye(Nu))^(-1))*M';
    
    DMCMacierze.Mp = Mp;
    DMCMacierze.K = K;
    DMCMacierze.N = N;
    DMCMacierze.M = M;
    DMCMacierze.Nu = Nu;
    DMCMacierze.D = D;
    
    %% Fragment dodany w celu predykcji wp³ywu zak³ócenia na wyjœcie obiektu
    Mpz=zeros(N,Dz-1);
    for i=1:N
        for j=1:Dz-1
            if i+j<Dz
                %oblicznie Mp
                Mpz(i,j)=sz(i+j)-sz(j);
            else
                Mpz(i,j)=sz(D)-sz(j);
            end
        end
    end
    
    DMCMacierze.Mpz = Mpz;
end

