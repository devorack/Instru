close all
clear;
clc;

% Load Excel data
archivo = csvread('DesplazamientoBastago.csv', 1, 0); 
tiempo = archivo(:, 1);
data = archivo(:, 2);
figure(1);
plot(tiempo-0.4, data/1000,'r', 'DisplayName', 'Simulink Data');
hold on;


global m c1 c2 c3 c4 Fs Fd Ad Kt R V u 

%Servo-Valvula

%Valores a ajustar
c1 = 540000;
c2 = 220000;
c3 = 2800;
c4 = 100; %no mover

%Tesis miguel pag 37
R = 286.9;
V = 0.00076;
Kt = 0.9;
m = 0.3;
Ad = 0.026;
Fs = 90;
Fd = 420;

%Dato medido
u = 20684.3*14; %factor de conversion por PSI medido

%Pd sale de la presion atm en unidades de pascal
Y0 = [0; 0; 81060];
results_t = [];

[t, x] = ode23s(@(t, Y) ec_differential(t,Y), [0, 20], Y0);


plot(t,x(:,1),'g', 'DisplayName', 'Excel Data');
title('Desplazamiento del vastago');
hold on;
grid on