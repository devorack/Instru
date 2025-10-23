% Cargar la librería
ljud_LoadDriver; 
ljud_Constants;

% Abrir la primera tarjeta LabJack U3 encontrada.
[Error, ljh] = ljud_OpenLabJack(LJ_dtU3, LJ_ctUSB, '1', 1);

% Comprobar si hay errores
Error_Message(Error)

% Configurar FIO4 como salida digital
Error = ljud_ePut(ljh, LJ_ioPUT_DIGITAL_BIT, 4, 0, 0);
Error_Message(Error)

disp('PRENDIDO')
% Establecer FIO4 a 5V (alto)
Error = ljud_ePut(ljh, LJ_ioPUT_DIGITAL_BIT, 4, 1, 0);
Error_Message(Error)

% Esperar 
pause(5)

disp('APAGADO')
% Establecer FIO4 a 0V (bajo)
Error = ljud_ePut(ljh, LJ_ioPUT_DIGITAL_BIT, 4, 0, 0);
Error_Message(Error)
