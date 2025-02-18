clear all;
close all;

% Par�metros del circuito
Req = 1000; % Resistencia en ohmios
Rm = 1000;
R2 = 1000;
C = 1e-6; % Capacitancia en faradios
E = 1; % Voltaje en voltios
Vc0 = 0;
Ic0 = (R2*E - Vc0*(R2+Req))/( (R2*Req)+(Rm*Req)+ (Rm*R2));% Condici�n inicial para Vc(0)

% Par�metros de la simulaci�n
frecuencia = 20;
periodo = 1/frecuencia;
dt_cerrado = periodo/2; % Duraci�n del circuito con se�al escal�n activa
dt_abierto = periodo/2; % Duraci�n del circuito con se�al escal�n inactiva
period_total = dt_cerrado + dt_abierto; % Periodo total

% Tiempo total de simulaci�n
n_intervals = 4; % N�mero total de intervalos

results = [];

for i = 1:n_intervals
    % Determinar el tiempo de inicio y fin del intervalo
    t_start = (i - 1) * period_total;
    t_end_cerrado = t_start + dt_cerrado; % Fin del intervalo cerrado
    t_end_abierto = t_start + period_total; % Fin del intervalo abierto
    
    % Resolver el sistema para el intervalo cerrado
    [t_cerrado, Vc_cerrado] = ode23(@(t, Vc) ec_diff(t, Vc, R2, Req, Rm, E, C, 1), [t_start, t_end_cerrado], Vc0+Ic0);

    % Resolver el sistema para el intervalo abierto
    [t_abierto, Vc_abierto] = ode23(@(t, Vc) ec_diff(t, Vc, R2, Req, Rm, E, C, -1), [t_end_cerrado, t_end_abierto], Vc_cerrado(end)- Ic0 );

    % Almacenar resultados
    results = [results; [t_cerrado, Vc_cerrado; t_abierto, Vc_abierto]];
        
    % Actualizar el estado inicial para el pr�ximo ciclo
    Vc0 = Vc_abierto(end); % La �ltima soluci�n se convierte en el nuevo estado inicial
end

% Graficar la soluci�n
figure;
plot(results(:, 1), results(:, 2), 'b');
title('Voltaje en el Condensador Vc(t)');
xlabel('Tiempo (s)');
ylabel('Voltaje Vc(t) [V]');
grid on;