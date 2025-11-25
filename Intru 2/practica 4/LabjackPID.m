% ============================================================
% Control PI para nivel de agua usando LabJack U3 en MATLAB
% ============================================================

% Cargar librería .NET para LabJack
lj = NET.addAssembly('LJUDDotNet');
ljudObj = LabJack.LabJackUD.LJUD;

% Abrir conexión con el U3 (USB)
[ljError, ljHandle] = ljudObj.OpenLabJackS('LJ_dtU3', 'LJ_ctUSB', '1', true, 0);

% Habilita el canal AIN2 como entrada analÃ³gica
ljudObj.ePutS(ljHandle, 'LJ_ioPUT_ANALOG_ENABLE_BIT', 2, 1, 0);

% Configura el DAC0 para salida analÃ³gica (opcional)
ljudObj.ePutS(ljHandle, 'LJ_ioPUT_DAC', 0, 0, 0);

% Parámetros del PI
SPPulgadas = 8;

     p1 =      0.1588;
     p2 =    -0.02095;
     
conversion =  p1 * SPPulgadas + p2

SP =  conversion;       % Setpoint en voltios (nivel deseado)
%Kp = 575.629989243001 /100;     % Ganancia proporcional
%Ki = 1.90164344047166 /100;     % Ganancia integral
Kp = 5.7563
Ki = 0.0590
Ts = 0.1;     % Tiempo de muestreo (segundos)

% Límites de salida (para DAC ? I/P ? válvula)
u_min = 0;    % Voltaje mínimo
u_max = 5;    % Voltaje máximo (corresponde a 4-20 mA en el I/P)

% Variables del controlador
integral = 0;
u = 0;
error_prev = 0;

% Inicializa vectores para almacenar las lecturas de voltaje
voltages = [];
time = [];

tic; % Inicia un temporizador
figure1 = figure;

% Bucle de control
while true
    % Leer nivel actual (AIN0)
    [ljError, level] = ljudObj.eGetS(ljHandle, 'LJ_ioGET_AIN', 2, 0, 0);
    % Almacena la lectura y el tiempo
    voltages(end+1) = level;
    time(end+1) = toc;

    % Calcular error
    error = SP - level;
    
    % Integral con método del trapecio
    integral = integral + ((error + error_prev) / 2) * Ts;
    
    % Calcular salida
    u = Kp * error + Ki * integral;
    
    
    % Limitar salida y aplicar anti-windup
    if u > u_max
        u = u_max;
        integral = integral - ((error + error_prev) / 2) * Ts; % Anti-windup
    elseif u < u_min
        u = u_min;
        integral = integral - ((error + error_prev) / 2) * Ts; % Anti-windup
    end

    
    % Enviar señal al DAC0
    ljudObj.ePutS(ljHandle, 'LJ_ioPUT_DAC', 0, u, 0);
    
    % Grafica la seÃ±al
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
     writetable(data, 'DataUDCControl.xlsx');
     
    pause(Ts);
end

% ============================================================
% Fin del control PI
% ============================================================