clear all;
close all;

% Par�metros del circuito
global R Rc Rf Rl Rml E L C

% Definir los valores de las constantes
E = 5;
L = 2.37e-3;
Rf = 50;
Rml = 100;
Rl = 0.8;
Rc = 100;
R = 10e3;
C = 0.3e-6;

frecuencia = 935.5;
periodo = 1/frecuencia;
dt_cerrado = periodo/2; % Duraci�n del circuito con se�al escal�n activa
dt_abierto = periodo/2; % Duraci�n del circuito con se�al escal�n inactiva
period_total = dt_cerrado + dt_abierto; % Periodo total

% Valores iniciales
Y0 = [0; 0]; % Suponiendo que las condiciones iniciales son cero
u = 1; % Valor de u

% Intervalo de tiempo
tspan = [0 period_total]; % Ajusta el intervalo de tiempo seg�n sea necesario
% Resolver la ecuaci�n diferencial
[t, Y] = ode45(@(t, Y) ec_differential(t, Y, E, u), tspan, Y0);

% Graficar los resultados
figure;
subplot(2, 1, 1);
plot(t, Y(:, 1), 'r');
xlabel('Tiempo (s)');
ylabel('Vc(t)');
title('Capacitor ');

subplot(2, 1, 2);
plot(t, Y(:, 2), 'b');
xlabel('Tiempo (s)');
ylabel('Il(t)');
title('Inductor');

% Mostrar la gr�fica
sgtitle('Soluci�n de la ecuaci�n diferencial');
