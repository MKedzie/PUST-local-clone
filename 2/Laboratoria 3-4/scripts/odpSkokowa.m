addpath ('F:\SerialCommunication');
initSerialControl COM19;
Upp=33;

step=30;
lenWaiting = 200;

sendControlsToG1AndDisturbance(Upp, 0) ;
sendControls ([1, 5], [50, Upp]) ;
for k=1:1:lenWaiting  
    yWait(k) = readMeasurements (1) ;
    plot(1:k, yWait(1:k),'LineWidth', 1.1);
    title('Sygnal wyjsciowy');
    xlabel('Numer probki (k)');
    grid on;
    drawnow
    waitForNewIteration();
end

len = 500;

for k=1:1:len
    y(k) = readMeasurements (1) ;
    if(k<30)
         sendControlsToG1AndDisturbance(Upp, 0) ;
    else
         sendControlsToG1AndDisturbance(Upp, step) ;
    end

    plot(1:k, y(1:k),'LineWidth', 1.1);
    title('Sygnal wyjsciowy');
    xlabel('Numer probki (k)');
    grid on;
    drawnow
    
    waitForNewIteration ();
 end
 Ypp=y(1);
 save(['data/odpskokZZUpp', num2str(Upp), 'Ypp', num2str(Ypp), 'skok', num2str(step),'.mat']);
 sendControlsToG1AndDisturbance(Upp, 0) ;