clear all; close all; clc;

% === Parámetros del tanque ===
A = 0.2;                          % Área [m²]
k = 0.5;                          % Constante de salida
Qin_const = 5.75; % 5.75 gpm en m³/s
h_LL = 0.2;                       % Sensor LL
h_HL = 0.4;                       % Sensor HL
h0 = 0.5;                         % Nivel inicial

% === Simulación paso a paso ===
dt = 100;           % Paso de tiempo
n_steps = 5;     % Pasos totales
t_total = 0;

% Inicialización de vectores
T = [];
H = [];
Qout_vec = [];
valv_state = [];
LL_vec = [];
HL_vec = [];

for i = 1:n_steps
    % === Evaluar sensores ===
    LL = h0 >= h_LL;
    HL = h0 >= h_HL;

    % === Lógica de control de 3 estados ===
    if (LL == 0 && HL == 0)
        valvula_abierta = true;
    elseif (LL == 1 && HL == 0)
        valvula_abierta = true;
    elseif (LL == 1 && HL == 1)
        valvula_abierta = false;
    end

    % === Integrar durante dt ===
    [t, h] = ode45(@(t, h) tanque_controlado(t, h, A, k, Qin_const, valvula_abierta), ...
                   [0 dt], h0);

    % === Acumular resultados ===
    t_shifted = t + t_total;
    T = [T; t_shifted];
    H = [H; h];
    Qout_vec = [Qout_vec; k * sqrt(max(h, 0))];
    valv_state = [valv_state; valvula_abierta * ones(size(h))];
    LL_vec = [LL_vec; (h >= h_LL)];
    HL_vec = [HL_vec; (h >= h_HL)];

    % === Preparar siguiente iteración ===
    h0 = h(end);
    t_total = t_total + dt;
end

% === Graficar resultados ===
figure;

subplot(4,1,1);
plot(T, H, 'b', 'LineWidth', 2);
ylabel('h(t) [m]');
title('Nivel del tanque');
grid on;

subplot(4,1,2);
plot(T, Qout_vec, 'r', 'LineWidth', 2);
ylabel('Q_{out}(t)');
title('Flujo de salida');
grid on;

subplot(4,1,3);
stairs(T, valv_state, 'k', 'LineWidth', 1.5);
ylabel('Válvula');
set(gca, 'YTick', [0 1]);
set(gca, 'YTickLabel', {'Cerrada', 'Abierta'});
title('Estado de la válvula');
grid on;


subplot(4,1,4);
stairs(T, [LL_vec HL_vec], 'LineWidth', 1.5);
ylabel('Sensores');
xlabel('Tiempo [s]');
legend('LL', 'HL');
title('Sensores de nivel');
grid on;
