function [DMCMacierze] = zad4P_dmcGeneration(s,D,Nu,N,lambda)
    
    % zwracana jest struktura DMC_macierze z nastepujacymi polami:
    % .M -> macierz M
    % .Mp -> macierz Mp
    % .K -> macierz K
    % .N -> wartosc N dla ktorej byly generowane
    % .Nu -> wartosc Nu dla ktorej byly generowane
    % .D -> wartosc D dla ktorej byly generowane
    sLen = max(length(s));
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
            if i+j<sLen
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
end

