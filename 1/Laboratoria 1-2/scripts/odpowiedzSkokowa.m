addpath('F:\SerialCommunication ') ; % add a path
initSerialControl COM19 % initialise com port 
skok = 30;
Upp=25+8; %punkt pracy do zmiany

%     while (1)
%         %% obtaining measurements
%         measurements = readMeasurements (1:7) ; % read measurements         
%         %% processing of the measurements
%         disp ( measurements(1,1) ) ; % process measurements
%         W1 = 50;
%         G1 = Upp;
%         
%         sendControls ([ 1, 5], [ W1, G1]) ;
% 
% 
%         %% synchronising with the control process
%         waitForNewIteration () ; % wait for new iteration
%     end

for k=1:1:600
   % obtaining measurements
    y(k) = readMeasurements (1) ; % read measurements T1

        sendControls ([ 1, 5],[ 50, Upp + skok]) ;

        plot(1:k, y(1:k),'LineWidth', 1.1); % Wyjscie obiektu
        title('Sygnal wyjsciowy');
        xlabel('Numer probki (k)');
        grid on;
        drawnow

        waitForNewIteration (); % wait for new iteration
end
    
save(y, srtcat(num2str(skok),'.mat'));
