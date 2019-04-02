
addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM19 % initialise com port
load('s.mat');
Ypp=36.06;
Upp = 33;
%% Tworzenie macierzy do DMC
D = 200;
Nu = 100;
N = 100;
lambda = 0.1;
dmcMacierze = dmcGeneration(s,D,Nu,N,lambda);
duPop = zeros(D-1,1)';

simulationTime = 500;
start = 2;

UMin = 0;
UMax = 100;
uMin = UMin-Upp; 
uMax = UMax-Upp; 

dy = 10;
YZad(1:250) = Ypp;  
YZad(251:simulationTime)= Ypp + dy;

yZad = YZad-Ypp;
    
    
Y = ones(simulationTime,1)*Ypp;
y = zeros(simulationTime,1);
U = ones(simulationTime,1)*Upp;
u = zeros(simulationTime,1);
	

    
for k = start : 1 : simulationTime
    Y(k) = readMeasurements (1) ; % read measurements T1
    y(k) = Y(k)- Ypp;
    
	du = dmc(dmcMacierze,y(k),yZad(k),duPop);
    
    
% 	du = U(k)-U(k-1);
% 	if du>= dumax
% 		du=dumax;
% 	end
%     if du<=-dumax
%         du=-dumax;
%     end
        
    % Prawo regulacji
    u(k) = u(k-1) + du;

    if u(k)> uMax
		u(k) = uMax; 
    end
    if u(k)< uMin
        u(k) = uMin;
    end
    dureal = u(k) - u(k-1);
    duPop = duNew(duPop,dureal);
    
    U(k)=u(k)+Upp;
    subplot(2,1,1)
    plot(1:k, Y(1:k),'LineWidth', 1.1); % Wyjscie obiektu
    hold on
    plot(1:k, YZad(1:k),'LineWidth', 1.1); % zadana
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
    
        
    sendControls ([ 1, 5], [ 50, U(k)]) ;
    waitForNewIteration (); % wait for new iteration
end

E = sum((yZad-Y).^2);
