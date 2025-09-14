clear all
close all
global A m c1 c2 c3 c4 Fs Fd Ad Kt R V u A1 p g pinicial hinicial  lb1 p3 f1 deltaL l

%Servo-Valvula
m = 0.3;
c1 = 218351.98;
c2 = 60000; 
c3 = 50740; 
c4 = 100;

A = 0.0410;%Area de seccion transversal del tanque
A1 = 1.2668e4;%Area del orificio de entrada del tanque
Ad = 0.026;%Area del diafragma
Fs = 90;%fuerza de precompresibilidad del resorte,
Fd = 420;%friccion dinamica,
Kt = 0.9;%Constante
R = 286.9;%Resistencia del aire entrante
l = 0.9281;%
deltaL = 0;%Creo que es altura del orificio de entrada del tanque
g = 9.81;% Gravedad
p = 1000;%Densidad del liquido
p3 = 81060;%Presion en la salida del tanque
V = 0.00076;%Volumen de la camara
u = 20684.3;
lb1 = 2;% longitud de la tuberia de impulcion
f1 = 39.85154283;%Coeficiente general de perdidas en la tuberia

pinicial = 81060;%
hinicial = 0.07;

h0 = [hinicial 0 0 0 pinicial 0.015 0 0]; 
tspan = [0 30];

%options = odeset('RelTol',1e-6,'AbsTol',1e-6);
options = odeset('RelTol',1e-8,'AbsTol',1e-8);
[t,x] = ode23tb('ecServo',tspan,h0,options);


figure(1);
plot(t,x(:,1),'b');
title('Altura');
grid on

figure(2);
plot(t,x(:,2),'r');
title('Velocidad en el tanque');
grid on

figure(3);
plot(t,x(:,3),'r');
title('Caudal de Entrada');
grid on

figure(4);
plot(t,x(:,4),'r');
title('Caudal de Salida');
grid on
% 
% figure(5);
% plot(t,x(:,5),'r');
% title('Presion');
% grid on
% 
% figure(6);
% plot(t,x(:,6),'b');
% title('Desplazamiento del Vastago');
% grid on
% 
% figure(7);
% plot(t,x(:,7),'r');
% title('Velocidad del Vastago');
% grid on
% 
% figure(8);
% plot(t,x(:,8),'r');
% title('Presion en la camara del diafragma');
% grid on
% 
