close all
clear;
clc;

global A A1 rho L DeltaL1 Kp g b0 b1 b2 lB1 h0 p0  p3 A3

% Parametros de la bomba
b0 = 301692;
b1 = -6674.9;
b2 = -2830;

% Parametros del tanque cerrado de la tesis
DeltaL1 = 0;
rho = 1000;
Kp = 39.8;
A = 0.0410;
lB1 = 2;
A1 = 0.00012668;
g = 9.8;
L = 0.9281;
p3 = 81060;
p0 = 81060;
h0 = 0;
A3 = 0.00012668;

Y0 = [0.07 0 0 p0 0];
results_t = [];

options = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,x] = ode23('ec_differential',[0, 500],Y0,options);
%[t, x] = ode23s(@(t, Y) ec_differential(t,Y), [0, 500], Y0);


figure(1);

subplot(5, 1, 1);
plot(t, x(:,1));
xlabel('Tiempo');
ylabel('Altura (h)');
title('Altura tanqu');

subplot(5, 1, 2);
plot(t, x(:,2));
xlabel('Tiempo');
ylabel('Velocidad');
title('Velocidad llenado tanque');

subplot(5, 1, 3);
plot(t, x(:,3));
xlabel('Tiempo');
ylabel('Caudal Qi');
title('Caudal Qi');

subplot(5, 1, 4);
plot(t, x(:,4),'g');
xlabel('Tiempo');
ylabel('Presion (P)');
title('Presion dentro del tanque');

subplot(5, 1, 5);
plot(t, x(:,5),'g');
xlabel('Tiempo');
ylabel('Caudal Salida (Qout)');
title('Caudal Salida (Qout)');