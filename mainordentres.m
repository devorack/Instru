clc
clear all
close all
global Rc1 Rc2 R2 C1 C2 L E U

E = 50;
L = 2;
Rc1 = 0.8;
Rc2 = 0.8;
R2 = 1000;
C1 = 5e-6;
C2 = 5e-6;
f = 28;
T = 1 / f;

tt = 0;
xx = [0 0 0];

U = 0; % Inicializar U

t0 = 0;
tf = T / 2;
tspan = [t0 tf];
h0 = [0 0 0];

for i = 1:3
    options = odeset('RelTol', 1e-03, 'AbsTol', [1e-03 1e-03 1e-03]);
    [t, x] = ode45(@ordentresecus, tspan, h0, options);

    tt = [tt; t];
    xx = [xx; x];

    U = 1; % Activar switch
    h0 = [x(end,1), x(end,2), x(end,3)]; % Usar end en lugar de length(x)
    t0 = tf;
    tf = i * T;
    tspan = [t0 tf];

    [t, x] = ode45(@ordentresecus, tspan, h0, options);
    tt = [tt; t];
    xx = [xx; x];

    U = 0; % Desactivar switch
    h0 = [x(end,1), x(end,2), x(end,3)];
    t0 = tf;
    tf = t0 + T / 2;
    tspan = [t0 tf];
end

% Gráficos
subplot(3,1,1)
plot(tt, xx(:,1), 'b', 'LineWidth', 1.5)
grid on
title('Corriente en el Inductor I_L(t)')
ylabel('Corriente (I)')
legend('I_L(t)')

subplot(3,1,2)
plot(tt, xx(:,2), 'r', 'LineWidth', 1.5)
grid on
title('Voltaje en el Circuito V_L1(t)')
ylabel('Voltaje (V)')
xlabel('Tiempo (s)')
legend('V_L(t)')

subplot(3,1,3)
plot(tt, xx(:,3), 'g', 'LineWidth', 1.5)
grid on
title('Voltaje en el Capacitor V_{C2}(t)')
ylabel('Voltaje (V)')
xlabel('Tiempo (s)')
legend('V_{C2}(t)')

figure(3);%Grafica de los diagramas de fases
plot(xx(:,1),xx(:,2));
title('Diagrama de fases ');

figure
plot3(xx(:,1), xx(:,2), xx(:,3), 'LineWidth', 1.5)
grid on
xlabel('I_L(t)')
ylabel('V_{C1}(t)')
zlabel('V_{C2}(t)')
title('Diagrama de fases 3D del sistema de tercer orden')
