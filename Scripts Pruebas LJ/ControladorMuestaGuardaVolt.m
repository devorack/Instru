% Cargar la biblioteca LabJackUD
ljud_LoadDriver; % Carga el controlador de LabJack
ljud_Constants; % Carga las constantes de LabJack

% Abrir el primer dispositivo U3 encontrado
[Error, ljh] = ljud_OpenLabJack(LJ_dtU3, LJ_ctUSB, '1', 1);

% Comprobar si hay errores al abrir el dispositivo
Error_Message(Error)

% Configurar la entrada analógica en el canal 0 (potenciómetro)
channel = 0;
range = 5.0; % Rango de entrada de ±10V

% Configurar el rango de entrada para el canal especificado
Error = ljud_AddRequest(ljh, LJ_ioPUT_AIN_RANGE, channel, range, 0, 0);
Error_Message(Error)

% Configurar la salida digital en el pin FIO4
outputChannel = 4;
outputState = 0; % Estado inicial del pin FIO4 (bajo)

% Establecer el estado inicial del pin FIO4
Error = ljud_ePut(ljh, LJ_ioPUT_DIGITAL_BIT, outputChannel, outputState, 0);
Error_Message(Error)

% Umbral para activar/desactivar el pin FIO4
threshold = 3.0;

% Crear un vector para almacenar los valores de voltaje leídos
voltages = [];

% Controlar el pin FIO4 en función del voltaje del potenciómetro
while true
    % Leer el voltaje del potenciómetro
    [Error, voltage] = ljud_eGet(ljh, LJ_ioGET_AIN, channel, 0, 0);
    Error_Message(Error)
    
    % Almacenar el valor de voltaje leído en el vector
    voltages(end+1) = voltage;
    
    % Mostrar el voltaje leído en la consola
    fprintf('Voltaje del potenciómetro: %.3f V\n', voltage);
    
    % Activar o desactivar el pin FIO4 en función del voltaje leído
    if voltage >= threshold
        outputState = 3; % Activar el pin FIO4 (alto)
    else
        outputState = 0; % Desactivar el pin FIO4 (bajo)
    end
    
    % Establecer el estado del pin FIO4
    Error = ljud_ePut(ljh, LJ_ioPUT_DIGITAL_BIT, outputChannel, outputState, 0);
    Error_Message(Error)
    
    pause(1); % Pausar por un segundo antes de la siguiente lectura
end