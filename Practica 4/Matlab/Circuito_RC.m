clear all;
close all;

% Par�metros del circuito
global R Rc Rf Rl Rml E L C

E=4.8;
L = 2.37e-3;
Rf = 50;
Rml = 100;
Rl = 0.8;
Rc = 100;
R = 10e3;
C = 0.03e-6;

% Condiciones iniciales
IL0 = E/(R+Rl+Rml+Rf);
Vc0 = (E*R)/(R+Rl+Rml+Rf);
Y0 = [0; 0;0;E];

% Par�metros de la simulaci�n
frecuencia = 480.8;
periodo = 1/frecuencia;
dt_cerrado = periodo/2; % Duraci�n del circuito con se�al escal�n activa
dt_abierto = periodo/2; % Duraci�n del circuito con se�al escal�n inactiva
period_total = dt_cerrado + dt_abierto; % Periodo total

% Tiempo total de simulaci�n
n_intervals = 4; % N�mero total de intervalos

results_t = [];
results_Il = [];
results_Vc = [];
results_Vl = [];
results_Ic = [];

for i = 1:n_intervals
    % Determinar el tiempo de inicio y fin del intervalo
    t_start = (i - 1) * period_total;
    t_end_cerrado = t_start + dt_cerrado; % Fin del intervalo cerrado
    t_end_abierto = t_start + period_total; % Fin del intervalo abierto
    

    % Resolver el sistema para el intervalo cerrado
    [t_cerrado, Y_cerrado] = ode23(@(t, Y) ec_differential(t,Y,E,1), [t_start, t_end_cerrado], Y0);

    % Obtener los valores de Il_t y Vc_t al final del intervalo cerrado
    Vc_t_final = Y_cerrado(end, 1);
    Il_t_final = Y_cerrado(end, 2);
    Ic_t_final = Y_cerrado(end, 3);
    Vl_t_final = Y_cerrado(end, 4);
    

    % Imprimir los valores
    fprintf('Intervalo %d - Valor final de Il_t: %.4f\n', i, Il_t_final);
    fprintf('Intervalo %d - Valor final de Vc_t: %.4f\n', i, Vc_t_final);

    % Resolver el sistema para el intervalo abierto
    [t_abierto, Y_abierto] = ode23(@(t, Y) ec_differential(t,Y,E,-1), [t_end_cerrado, t_end_abierto], [Vc_t_final,Il_t_final,-Ic_t_final,-Vl_t_final]);

    % Almacenar resultados
    results_t = [results_t; t_cerrado; t_abierto];
    results_Il = [results_Il; [t_cerrado, Y_cerrado(:, 2); t_abierto, Y_abierto(:, 2)]];
    results_Vc = [results_Vc; [t_cerrado, Y_cerrado(:, 1); t_abierto, Y_abierto(:, 1)]];
    
    results_Vl = [results_Vl; [t_cerrado, Y_cerrado(:, 4); t_abierto, Y_abierto(:, 4)]];
    results_Ic = [results_Ic; [t_cerrado, Y_cerrado(:, 3); t_abierto, Y_abierto(:, 3)]];
    % Actualizar el estado inicial para el pr�ximo ciclo
    Y0 = Y_abierto(end, :); % La �ltima soluci�n se convierte en el nuevo estado inicial
end
% Graficar la soluci�n en subgr�ficas
figure;

% Subgr�fica para Il_t
subplot(2, 1, 1);
plot(results_t(:,1), results_Il(:,2));
xlabel('Tiempo');
ylabel('Il_t');
title('Corriente Il_t');

hold on;
% Load Excel data
archivo = csvread('../excels/sub-dis.csv', 18, 0); % Corrected to 'csvread' and file extension to '.csv'
%archivo = csvread('../excels/cri-dis.csv', 18, 0); % Corrected to 'csvread' and file extension to '.csv'
%archivo = csvread('../excels/sob-dis.csv', 18, 0); % Corrected to 'csvread' and file extension to '.csv'
tiempo = archivo(:, 1);
data = archivo(:, 2);
hold on;
%sub
plot(tiempo, data/107,'g', 'DisplayName', 'Excel Data');
%critico
%plot(tiempo+1e-3, data/100,'g', 'DisplayName', 'Excel Data');



% Subgr�fica para Vc_t
subplot(2, 1, 2);
plot(results_t(:,1), results_Vc(:,2));
xlabel('Tiempo');
ylabel('Vc_t');
title('Voltaje Vc_t');

hold on;
% Load Excel data
archivo = csvread('../excels/sub.csv', 18, 0); % Corrected to 'csvread' and file extension to '.csv'
%archivo = csvread('../excels/cri.csv', 18, 0); % Corrected to 'csvread' and file extension to '.csv'
%archivo = csvread('../excels/sob.csv', 18, 0); % Corrected to 'csvread' and file extension to '.csv'
tiempo = archivo(:, 1);
data = archivo(:, 2);

%sub
plot(tiempo, data,'g', 'DisplayName', 'Excel Data');
%sobre
%plot(tiempo+1.15e-3, data,'g', 'DisplayName', 'Excel Data');
%critico
%plot(tiempo+0.1e-3, data,'g', 'DisplayName', 'Excel Data');



figure;

plot(results_Il(:,2), results_Vc(:,2),'g', 'DisplayName', 'Diagrama de faces');
