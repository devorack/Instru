clear all;
close all;

% Par�metros del circuito
global R1 R2 E L C1 C2

E=100;
L = 0.25;
C1 = 1e-6;
C2 = 500e-6;
R1 = 200000;
R2 = 10;

frecuencia = 2;
periodo = 1/frecuencia;
dt_cerrado = periodo/2; % Duraci�n del circuito con se�al escal�n activa
dt_abierto = periodo/2; % Duraci�n del circuito con se�al escal�n inactiva
period_total = dt_cerrado + dt_abierto; % Periodo total

% Tiempo total de simulaci�n
n_intervals = 100; % N�mero total de intervalos


results_t = [];
results_IL = [];
results_Vc1 = [];
results_Vc2 = [];

Y0 = [0;0;0];

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
    [t_abierto, Y_abierto] = ode23(@(t, Y) ec_differential(t,Y,E,0), [t_end_cerrado, t_end_abierto], [Vc1_t_final,Vc2_t_final,IL_t_final]);

    % Almacenar resultados
    results_t = [results_t; t_cerrado; t_abierto];
    
    results_Vc1 = [results_Vc1; [t_cerrado, Y_cerrado(:, 1); t_abierto, Y_abierto(:, 1)]];
    results_Vc2 = [results_Vc2; [t_cerrado, Y_cerrado(:, 2); t_abierto, Y_abierto(:, 2)]];
    results_IL = [results_IL; [t_cerrado, Y_cerrado(:, 3); t_abierto, Y_abierto(:, 3)]];
    % Actualizar el estado inicial para el pr�ximo ciclo
    Y0 = Y_abierto(end, :); % La �ltima soluci�n se convierte en el nuevo estado inicial
end
% Graficar la soluci�n en subgr�ficas
figure;

% Subgr�fica para Il_t
subplot(3,1,1);
plot(results_t(:,1), results_Vc1(:,2));
xlabel('Tiempo');
ylabel('VC1');
title('Voltaje VC1');

% Subgr�fica para Vc_t
subplot(3,1,2);
plot(results_t(:,1), results_Vc1(:,2));
xlabel('Tiempo');
ylabel('VC2');
title('Voltaje VC2');

% Subgr�fica para Vc_t
subplot(3,1,3);
plot(results_t(:,1), results_IL(:,2));
xlabel('Tiempo');
ylabel('IL');
title('Corriente IL');
