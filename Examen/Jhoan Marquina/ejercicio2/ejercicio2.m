clear all;
close all;

% Parámetros del circuito
global R1 R2 E L C1 C2

E=1000;
L = 0.5;
C1 = 2e-6;
C2 = 1e-6;
R1 = 20;
R2 = 5;

frecuencia = 0.5;
periodo = 1/frecuencia;
dt_cerrado = periodo/2; % Duración del circuito con señal escalón activa
dt_abierto = periodo/2; % Duración del circuito con señal escalón inactiva
period_total = dt_cerrado + dt_abierto; % Periodo total

% Tiempo total de simulación
n_intervals = 4; % Número total de intervalos


results_t = [];
results_IL = [];
results_Vc1 = [];
results_Vc2 = [];

Y0 = [E;0;0];

for i = 1:n_intervals
    % Determinar el tiempo de inicio y fin del intervalo
    t_start = (i - 1) * period_total;
    t_end_cerrado = t_start + dt_cerrado; % Fin del intervalo cerrado
    t_end_abierto = t_start + period_total; % Fin del intervalo abierto
    

    % Resolver el sistema para el intervalo cerrado
    [t_cerrado, Y_cerrado] = ode23(@(t, Y) ec_differential(t,Y,E,1), [t_start, t_end_cerrado], Y0);

    % Obtener los valores de Il_t y Vc_t al final del intervalo cerrado
    Vc1_t_final = Y_cerrado(end, 1);
    Vc2_t_final = Y_cerrado(end, 2);
    IL_t_final = Y_cerrado(end, 3);
    

    % Resolver el sistema para el intervalo abierto
    [t_abierto, Y_abierto] = ode23(@(t, Y) ec_differential(t,Y,0,0), [t_end_cerrado, t_end_abierto], [Vc1_t_final,Vc2_t_final,IL_t_final]);

    % Almacenar resultados
    results_t = [results_t; t_cerrado; t_abierto];
    
    results_Vc1 = [results_Vc1; [t_cerrado, Y_cerrado(:, 1); t_abierto, Y_abierto(:, 1)]];
    results_Vc2 = [results_Vc2; [t_cerrado, Y_cerrado(:, 2); t_abierto, Y_abierto(:, 2)]];
    results_IL = [results_IL; [t_cerrado, Y_cerrado(:, 3); t_abierto, Y_abierto(:, 3)]];
    % Actualizar el estado inicial para el próximo ciclo
    Y0 = Y_abierto(end, :); % La última solución se convierte en el nuevo estado inicial
end
% Graficar la solución en subgráficas
figure;

% Subgráfica para Il_t
subplot(3,1,1);
plot(results_t(:,1), results_Vc1(:,2));
xlabel('Tiempo');
ylabel('VC1');
title('Voltaje VC1');

% Subgráfica para Vc_t
subplot(3,1,2);
plot(results_t(:,1), results_Vc1(:,2));
xlabel('Tiempo');
ylabel('VC2');
title('Voltaje VC2');

% Subgráfica para Vc_t
subplot(3,1,3);
plot(results_t(:,1), results_IL(:,2));
xlabel('Tiempo');
ylabel('IL');
title('Corriente IL');
