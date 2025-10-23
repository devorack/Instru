% Cargar la librería
ljud_LoadDriver; 
ljud_Constants;

% Abrir la primera tarjeta LabJack U3 encontrada.
[Error, ljh] = ljud_OpenLabJack(LJ_dtU3, LJ_ctUSB, '1', 1);

% Comprobar si hay errores
Error_Message(Error)

% Configurar FIO0 como entrada analógica
Error = ljud_ePut(ljh, LJ_ioPUT_ANALOG_ENABLE_PORT, 0, 1, 0);
Error_Message(Error)

% Leer el voltaje en FIO0
[Error, voltaje] = ljud_eGet(ljh, LJ_ioGET_AIN, 0, 0, 0);
Error_Message(Error)

% Mostrar el voltaje leído
disp(['Voltaje leído: ' num2str(voltaje) ' V'])
