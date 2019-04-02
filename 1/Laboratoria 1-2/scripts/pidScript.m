
addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM19 % initialise com port

Ypp = 36.06;
Upp = 33;

simulationTime = 500;
start = 2;

K = 12;
Ti = 15;
Td = 15;
T = 1;

UMin = 0;
UMax = 100;
uMin = UMin-Upp; 
uMax = UMax-Upp; 

dy = 10;
YZad(1:250) = Ypp;  
YZad(251:simulationTime)= Ypp+dy;

yZad = YZad-Ypp;
    
    
Y = ones(simulationTime,1)*Ypp;
y = zeros(simulationTime,1);
U = ones(simulationTime,1)*Upp;
u = zeros(simulationTime,1);
	
    
r0 = K * (1 + T/(2*Ti) + Td/T);
r1 = K * (T/(2*Ti) - 2*Td/T - 1);
r2 = K * Td/T;
    
errorR0 = 0;
errorR1 = 0;
errorR2 = 0;

    
for k = start : 1 : simulationTime
    Y(k) = readMeasurements (1) ; % read measurements T1
    y(k) = Y(k)- Ypp;
    errorR0 = yZad(k) - y(k);
        
	% PID eqation - first solution
	u(k) = u(k-1) + r0 * errorR0 + r1 * errorR1 + r2 * errorR2;
      
    % second solution
    % du = pid(r2, r1, r0, yZad(k), yZad(k-1), yZad(k-2), y(k), y(k-1), y(k-2));
	
    % limitations
    du = u(k)-u(k-1);

    % Prawo regulacji
    u(k) = u(k-1) + du;

    if u(k)> uMax
		u(k) = uMax; 
    end
    if u(k)< uMin
        u(k) = uMin;
    end
    
    
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
    % after calculate u(k) update error
    errorR2 = errorR1;
    errorR1 = errorR0;
    waitForNewIteration (); % wait for new iteration
end

E = sum((yZad-Y).^2);
