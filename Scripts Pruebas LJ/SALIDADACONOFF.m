% Cargar la librería
ljud_LoadDriver; 
ljud_Constants;

% Abrir la primera tarjeta LabJack U3 encontrada.
[Error, ljh] = ljud_OpenLabJack(LJ_dtU3, LJ_ctUSB, '1', 1);

% Comprobar si hay errores
Error_Message(Error)

% Establecer DAC0 a 5V
Error = ljud_ePut(ljh, LJ_ioPUT_DAC, 0, 5, 0);
Error_Message(Error)
disp(['DAC0 = PRENDIDO'])

% Esperar un segundo
pause(10)

disp(['DAC0 = APAGADO'])
% Establecer DAC0 a 0V
Error = ljud_ePut(ljh, LJ_ioPUT_DAC, 0, 0, 0);
Error_Message(Error)



