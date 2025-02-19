clear all;
close all;

% Par�metros del circuito
Req = 1000; % Resistencia en ohmios
Rm = 1000;
R2 = 1000;
C = 1e-6; % Capacitancia en faradios
E = 1; % Voltaje en voltios
Vc0 = 0; % Condici�n inicial para Vc(0)
Ic0 = 0;
Ic0_init = (R2*E - Vc0*(R2+Req))/( (R2*Req)+(Rm*Req)+ (Rm*R2));

% Par�metros de la simulaci�n
frecuencia = 66.66;
periodo = 1/frecuencia;
dt_cerrado = periodo/2; % Duraci�n del circuito con se�al escal�n activa
dt_abierto = periodo/2; % Duraci�n del circuito con se�al escal�n inactiva
period_total = dt_cerrado + dt_abierto; % Periodo total

% Tiempo total de simulaci�n
n_intervals = 4; % N�mero total de intervalos

results = [];
results_ic = [];

for i = 1:n_intervals
    % Determinar el tiempo de inicio y fin del intervalo
    t_start = (i - 1) * period_total;
    t_end_cerrado = t_start + dt_cerrado; % Fin del intervalo cerrado
    t_end_abierto = t_start + period_total; % Fin del intervalo abierto
    
    % Resolver el sistema para el intervalo cerrado
    [t_cerrado, Vc_cerrado] = ode23(@(t, Vc) ec_diff(t, Vc, R2, Req, Rm, E, C, 1), [t_start, t_end_cerrado], Vc0);

    % Resolver el sistema para el intervalo abierto
    [t_abierto, Vc_abierto] = ode23(@(t, Vc) ec_diff(t, Vc, R2, Req, Rm, E, C, -1), [t_end_cerrado, t_end_abierto], Vc_cerrado(end));

    % Resolver el sistema para el intervalo cerrado
    [t_cerrado_ic, Ic_cerrado] = ode23(@(t, Ic) ec_diff_IL(t, Ic, R2, Req, Rm, E, C, 1), [t_start, t_end_cerrado], Ic0+Ic0_init);

    % Resolver el sistema para el intervalo abierto
    [t_abierto_ic, Ic_abierto] = ode23(@(t, Ic) ec_diff_IL(t, Ic, R2, Req, Rm, E, C, -1), [t_end_cerrado, t_end_abierto], Ic_cerrado(end)- Ic0_init );

    % Almacenar resultados
    results = [results; [t_cerrado, Vc_cerrado; t_abierto, Vc_abierto]];
    results_ic = [results_ic; [t_cerrado_ic, Ic_cerrado; t_abierto_ic, Ic_abierto]];
        
    % Actualizar el estado inicial para el pr�ximo ciclo
    Vc0 = Vc_abierto(end); % La �ltima soluci�n se convierte en el nuevo estado inicial
    Ic0 = Ic_abierto(end);
end

% Graficar la soluci�n
figure;
plot(results(:, 1), results(:, 2), 'b');
title('Voltaje en el Condensador Vc(t)');
xlabel('Tiempo (s)');
ylabel('Voltaje Vc(t) [V]');
grid on;

figure;
plot(results_ic(:, 1), results_ic(:, 2), 'b');
title('Corriente en el Condensador Ic(t)');
xlabel('Tiempo (s)');
ylabel('Corriente Ic(t) [V]');
grid on;