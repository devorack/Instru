clc  % Clear the MATLAB command window
clear  % Clear the MATLAB variables

% Make the UD .NET assembly visible in MATLAB.
ljasm = NET.addAssembly('LJUDDotNet');
ljudObj = LabJack.LabJackUD.LJUD;

% Read and display the UD version.
disp(['UD Driver Version = ' num2str(ljudObj.GetDriverVersion())])

% Abrir el primer dispositivo U3 encontrado
[Error, ljh] = ljudObj.OpenLabJackS('LJ_dtU3', 'LJ_ctUSB', '0', true, 0);
LJ_ioPUT_AIN_RANGE = ljudObj.StringToConstant('LJ_ioPUT_AIN_RANGE');
LJ_ioANALOG_INPUT = ljudObj.StringToConstant('LJ_ioANALOG_INPUT');
LJ_ioGET_AIN = ljudObj.StringToConstant('LJ_ioGET_AIN');

% Comprobar si hay errores al abrir el dispositivo
disp(Error)

% Configurar la entrada analógica en el canal 0
channel = 0;
range = 10.0; % Rango de entrada de ±10V

% Configurar el rango de entrada para el canal especificado
%Error = ljudObj.AddRequest(ljh,LJ_ioPUT_AIN_RANGE, channel, range, 0, 0);
%disp(Error)

% Leer el voltaje en el canal especificado
%[Error, voltage] = ljudObj.eGet(ljh, LJ_ioANALOG_INPUT, channel, 0, 0);
Error = ljudObj.AddRequest(ljh, LJ_ioGET_AIN, channel, 0, 0, 0);

% Comprobar si hay errores al leer el voltaje
disp(Error)
voltage = 3;
% Mostrar el voltaje leído
fprintf('El voltaje en el canal %d es: %.3f V\n', channel, voltage);