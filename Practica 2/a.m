% Definir las variables globales
global R Rc Rf Rl Rml E L C

L = 2.37e-3;
Rf = 50;
Rml = 100;
Rl = 0.8;
Rc = 100;
R = 10e3;
E = 5;
C = 0.3e-6; 

frecuencia = 93.5;
periodo = 1/frecuencia;
dt_cerrado = periodo/2; % Duraci�n del circuito con se�al escal�n activa
dt_abierto = periodo/2; % Duraci�n del circuito con se�al escal�n inactiva
period_total = dt_cerrado + dt_abierto; % Periodo total
% Condiciones iniciales
IL0 = E/(R+Rl+Rml+Rf);
Vc0 = (E*R)/(R+Rl+Rml+Rf);
Y0 = [0; 0]; % Ejemplo de condiciones iniciales para Il_t y Vc_t

% Intervalo de tiempo
tspan = [0 100];
% Definir el intervalo de tiempo
    

    % Llamar a ode23
    [t, y] = ode23(@(t, y) ec_differential(t, y, E, 1), tspan, Y0);
    
% Graficar la soluci�n en subgr�ficas
figure;

% Subgr�fica para Il_t
subplot(2, 1, 1);
plot(t, y(:,1));
xlabel('Tiempo');
ylabel('Il_t');
title('Corriente Il_t');

% Subgr�fica para Vc_t
subplot(2, 1, 2);
plot(t, y(:,2));
xlabel('Tiempo');
ylabel('Vc_t');
title('Voltaje Vc_t');


