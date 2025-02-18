clear all;
close all;

% Parámetros del circuito
Req = 1000; % Resistencia en ohmios
Rm = 1000;
R2 = 1000;
C = 1e-6; % Capacitancia en faradios
E = 1; % Voltaje en voltios
Vc0 = 0; % Condición inicial para Vc(0)

% Parámetros de la simulación
frecuencia = 20;
periodo = 1/frecuencia;
dt_cerrado = periodo/2; % Duración del circuito con señal escalón activa
dt_abierto = periodo/2; % Duración del circuito con señal escalón inactiva
period_total = dt_cerrado + dt_abierto; % Periodo total

% Tiempo total de simulación
n_intervals = 4; % Número total de intervalos

results = [];

for i = 1:n_intervals
    % Determinar el tiempo de inicio y fin del intervalo
    t_start = (i - 1) * period_total;
    t_end_cerrado = t_start + dt_cerrado; % Fin del intervalo cerrado
    t_end_abierto = t_start + period_total; % Fin del intervalo abierto
    
    % Resolver el sistema para el intervalo cerrado
    [t_cerrado, Vc_cerrado] = ode23(@(t, Vc) ec_diff(t, Vc, R2, Req, Rm, E, C, 1), [t_start, t_end_cerrado], Vc0);

    % Resolver el sistema para el intervalo abierto
    [t_abierto, Vc_abierto] = ode23(@(t, Vc) ec_diff(t, Vc, R2, Req, Rm, E, C, -1), [t_end_cerrado, t_end_abierto], Vc_cerrado(end));

    % Almacenar resultados
    results = [results; [t_cerrado, Vc_cerrado; t_abierto, Vc_abierto]];
        
    % Actualizar el estado inicial para el próximo ciclo
    Vc0 = Vc_abierto(end); % La última solución se convierte en el nuevo estado inicial
end

% Graficar la solución
figure;
plot(results(:, 1), results(:, 2), 'b');
title('Voltaje en el Condensador Vc(t)');
xlabel('Tiempo (s)');
ylabel('Voltaje Vc(t) [V]');
grid on;