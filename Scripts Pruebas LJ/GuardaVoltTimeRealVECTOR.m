% Cargar la biblioteca LabJackUD
ljud_LoadDriver; % Carga el controlador de LabJack
ljud_Constants; % Carga las constantes de LabJack

% Abrir el primer dispositivo U3 encontrado
[Error, ljh] = ljud_OpenLabJack(LJ_dtU3, LJ_ctUSB, '1', 1);

% Comprobar si hay errores al abrir el dispositivo
Error_Message(Error)

% Configurar la entrada analógica en el canal 0
channel = 0;
range = 10.0; % Rango de entrada de ±10V

% Configurar el rango de entrada para el canal especificado
Error = ljud_AddRequest(ljh, LJ_ioPUT_AIN_RANGE, channel, range, 0, 0);
Error_Message(Error)

% Leer y guardar una cierta cantidad de voltajes en tiempo real
numReadings = 100; % Número de lecturas a realizar
voltages = zeros(1, numReadings); % Vector para almacenar las lecturas
for i = 1:numReadings
    [Error, voltages(i)] = ljud_eGet(ljh, LJ_ioGET_AIN, channel, 0, 0);
    Error_Message(Error)
    fprintf('El voltaje en el canal %d es: %.3f V\n', channel, voltages(i));
    pause(2); % Pausar por un segundo antes de la siguiente lectura
end

% Guardar las lecturas en un archivo
save('voltages.mat', 'voltages');

% Mostrar las lecturas realizadas en tiempo real
disp(voltages);