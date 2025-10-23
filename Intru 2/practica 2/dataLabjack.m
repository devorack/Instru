% Crea un objeto para el dispositivo LabJack U3
lj = NET.addAssembly('LJUDDotNet');
ljudObj = LabJack.LabJackUD.LJUD;

% Abre la primera conexión U3 encontrada
[ljError, ljHandle] = ljudObj.OpenLabJackS('LJ_dtU3', 'LJ_ctUSB', '1', true, 0);

% Habilita el canal AIN2 como entrada analógica
ljudObj.ePutS(ljHandle, 'LJ_ioPUT_ANALOG_ENABLE_BIT', 2, 1, 0);

% Configura el DAC0 para salida analógica (opcional)
dac0Voltage = 0.18; % Define el voltaje de salida deseado para DAC0
ljudObj.ePutS(ljHandle, 'LJ_ioPUT_DAC', 0, dac0Voltage, 0);

% Define el tiempo de muestreo en segundos
samplingTime = 0.1;

% Inicializa vectores para almacenar las lecturas de voltaje
voltages = [];
time = [];

tic; % Inicia un temporizador
figure1 = figure;

while true
    % Lee el valor de voltaje en el pin AIN2
    [ljError, voltage] = ljudObj.eGetS(ljHandle, 'LJ_ioGET_AIN', 2, 0, 0);
    
    % Almacena la lectura y el tiempo
    voltages(end+1) = voltage;
    time(end+1) = toc;

    % Grafica la señal
    figure(figure1);
    plot(time, voltages);
    xlabel('Tiempo (s)');
    ylabel('Voltaje AIN2 (V)');
    title('Lectura en tiempo real desde AIN2');
    grid on;
    legend('Voltaje AIN2');
    drawnow;

    % Guarda los datos en un archivo Excel (sobrescribe cada vez)
    data = table(time', voltages', 'VariableNames', {'Time', 'Voltages'});
     writetable(data, 'TanqueAbierto.xlsx');

    % Espera el tiempo de muestreo
    pause(samplingTime);
end
