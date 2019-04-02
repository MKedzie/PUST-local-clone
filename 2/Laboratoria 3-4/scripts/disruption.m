% Algorytm DMC dla stanowiska grzejaco-chlodzacego
addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM19 % initialise com port
Upp=33; %punkt pracy do zmiany
Ypp =35.81;
sendControls ([ 1, 5], [ 50, Upp]) ;

Tp = 1;

N=200;
Nu=200;
lambda=10;

Umin =0; Umax = 100;
umin = Umin-Upp; umax = Umax-Upp;

% Przygotowanie do testow
currentY = readMeasurements (1) ;
Yzad(1:600) = Ypp;
Yzad(250:end)=Ypp+10;

yzad = Yzad-Ypp;
EOS = length(Yzad);
z=zeros(EOS, 1);
z(100:end)=30;

Y=zeros(EOS, 1);
U=zeros(EOS, 1);
y=zeros(EOS, 1);
u=zeros(EOS, 1);

Y(1)=currentY;
Y(2)=Y(1);
U(1)=Upp;

load('s.mat');
load('sz.mat');

dmcMacierze = dmcDisruptionGeneracja(s,D,Nu,N,lambda,sz,Dz);
duPop = zeros(D-1,1)';
dzPop = zeros(Dz-1,1)';

 for k=2:1:EOS
   % obtaining measurements
    Y(k) = readMeasurements (1) ; % read measurements T1
    y(k) = Y(k) - Ypp;
    
   % Algorytm DMC
    % Aktualny przyrost sterowania
    du = dmcDisruption(dmcMacierze,y(k),yzad(k),duPop,dzPop); 
    
    % Prawo regulacji
    u(k) = u(k-1) + du;
    
    % Ograniczenia sygnalu sterujacego
    % u(k)+0.13*z(k)<100
    if u(k)>=100-0.13*z(k)
       u(k)=100-0.13*z(k); 
    end
    % Aktualizacja przyrostu
    du = u(k) - u(k-1);
    dz = z(k) - z(k-1);  
    % Zapis przeszlych przyrostow sterowania
    duPop = [du;duPop(1:end-1)];
    dzPop = [dz;dzPop(1:end-1)];
    % Dodanie wartosci punktu pracy
    U(k) = u(k) + Upp;
    
    % Sending new values of control signals
    
    sendControlsToG1AndDisturbance(U(k), z(k)) ;

    figure(1);
    subplot(2,1,1)
    plot(1:k, Y(1:k),'LineWidth', 1.1); % Wyjscie obiektu
    hold on
    plot(1:k, Yzad(1:k),'LineWidth', 1.1); % zadana
    hold off
    title('Sygnal wyjsciowy');
    xlabel('Numer probki (k)');
    grid on;
    subplot(2,1,2)
    plot(1:k, U(1:k),'LineWidth', 1.1); % sterowanie
    title('Sygnal sterujacy');
    xlabel('Numer probki (k)');
    grid on;
    drawnow
    
    waitForNewIteration (); % wait for new iteration
 end
