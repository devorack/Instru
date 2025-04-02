clear all;
close all;


L = 2.37e-3;
E = 2.5; %valor pico a pico
Rf = 50;
Rml = 100;
Rl = 0.8;
Rc = 100;
R = 10e3;
C = 3.626576500*10^(-8);% numero a variar sub
f = 13516.89272; % frecuencia de la imagen
T = 1/f; %1/f periodo
E = 0.86; % Voltaje en voltios
Vc0 = 0; % Condición inicial para Vc(0)
Ic0 = 0;

EP =@(R2, Req, Rm, C, Vc0)(R2*E - Vc0*(R2+Req))/( (R2*Req)+(Rm*Req)+ (Rm*R2));
%EP_VC = @(R2, Req, Rm, C, Ic0)(Ic0*(R2*Req + Rm*R2 + Rm*Req) - R2*E)*1/(-R2 - Req);
Ic0_init = EP(R2, Req, Rm, C, Vc0);
%Vc0 = EP(R2, Req, Rm, C, Vc0);
f_Ic_t = @(R2, Req, Rm, t, C, Ic0) exp(-(R2 + Req) * t / (((R2 * Req + R2 * Rm + Req * Rm) * C)) * Ic0);

% Parámetros de la simulación
frecuencia = f;
periodo = 1/frecuencia;
dt_cerrado = periodo/2; % Duración del circuito con señal escalón activa
dt_abierto = periodo/2; % Duración del circuito con señal escalón inactiva
period_total = dt_cerrado + dt_abierto; % Periodo total

% Tiempo total de simulación
n_intervals = 4; % Número total de intervalos

results = [];
results_ic = [];

results_to_mape = [];
results_ic_to_mape = [];

for i = 1:n_intervals
    % Determinar el tiempo de inicio y fin del intervalo
    t_start = (i - 1) * period_total;
    t_end_cerrado = t_start + dt_cerrado; % Fin del intervalo cerrado
    t_end_abierto = t_start + period_total; % Fin del intervalo abierto
    
    % Resolver el sistema para el intervalo cerrado
    [t_cerrado, Vc_cerrado] = ode23(@(t, Vc) ec_diff(t, Vc, R2, Req, Rm, E, C, 1), [t_start, t_end_cerrado], Vc0);

    if i == 1
        results_to_mape = [results; [t_cerrado, Vc_cerrado]];
        results_ic_to_mape = [results_ic; [t_cerrado_ic, Ic_cerrado]];
    end
    % Almacenar resultados
    results = [results; [t_cerrado, Vc_cerrado; t_abierto, Vc_abierto]];
      
    % Actualizar el estado inicial para el próximo ciclo
    Vc0 = Vc_abierto(end); % La última solución se convierte en el nuevo estado inicial
    Ic0 = Ic_abierto(end);
end

% Datos tomados:

% Leer el archivo voltaje.csv
data_voltaje = readtable('voltaje.csv');
disp(data_voltaje.Properties.VariableNames);

% Acceder a las columnas de datos en voltaje.csv
x_voltaje = data_voltaje.x_0_00075;
y_voltaje = data_voltaje.x_0_02;

% Leer el archivo corriente.csv
data_corriente = readtable('corriente.csv');
disp(data_corriente.Properties.VariableNames);

% Acceder a las columnas de datos en corriente.csv
x_corriente = data_corriente.x_0_00075; % Asegúrate de que el nombre de la columna sea correcto
y_corriente = data_corriente.x_0_44; % Asegúrate de que el nombre de la columna sea correcto

% Graficar la solución
figure;
plot(results(:, 1), results(:, 2), 'r');
title('Voltaje en el Condensador Vc(t)');
xlabel('Tiempo (s)');
ylabel('Voltaje Vc(t) [V]');
hold on;
grid on;
plot(x_voltaje, (y_voltaje)+0.22, 'b', 'DisplayName', 'Voltaje');
grid on;

figure;
plot(results_ic(:, 1), results_ic(:, 2), 'b');
title('Corriente en el Condensador Ic(t)');
xlabel('Tiempo (s)');
ylabel('Corriente Ic(t) [V]');
hold on;
grid on;
plot(x_corriente, ((y_corriente +0.02)/1000), 'r', 'DisplayName', 'Corriente');
grid on;

% Cálculos de MAE y MAPE:
time = data_voltaje.x_0_00075;
% Encuentra los índices en 'time' que corresponden a 'start_time' y 'end_time'
results_time = results_to_mape(:, 1); % Columna de tiempo
results_values = results_to_mape(:, 2); % Columna de valores

start_time = 0; % Tiempo inicial de 'results'
end_time =  dt_cerrado; % Tiempo final de 'results'

start_index = find(time >= start_time, 1, 'first');
end_index = find(time <= end_time, 1, 'last');

% Acota 'data_voltaje' al rango de tiempo de 'results'
data_voltaje_acotado = data_voltaje{start_index:end_index, :}; % Usa llaves para acceder a los datos de la tabla

%figure;
%plot(results_to_mape(:, 1), results_to_mape(:, 2), 'b');

%figure;
%plot(data_voltaje_acotado(:, 1), data_voltaje_acotado(:, 2), 'b');

% Calcula el MAPE
mape = mean(abs((data_voltaje_acotado - results_to_mape) ./ data_voltaje_acotado)) * 100;
disp(['MAPE: ', num2str(mape), '%']);