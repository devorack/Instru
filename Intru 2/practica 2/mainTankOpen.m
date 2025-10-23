close all
clear;
clc;
    p1 = 6.236;
    p2 = 0.03702;

% Load Excel data
archivo = csvread('./Data/TanqueAbierto.csv', 1, 0); 
tiempoTanqueAbierto = archivo(:, 1);
voltajeTanqueAbierto = archivo(:, 2);
figure(1);

plot(tiempoTanqueAbierto,((voltajeTanqueAbierto*p1) + p2)-1.1,'r');
hold on;


global n a qi A 
a = 0.1219; %0.1199;
n =0.2191;
A = 85; %Area transversal del tanque 92.90 85.27 89.99
qiGPM = 5.25;
qi = qiGPM*(3.85); %Flujo de entrada del tanque
h0 = 0;
tspan = [0 6800];

[t,y]= ode23('ec_tanqueOpen',tspan,h0);


figure(1);
plot(t, y,'g');
xlabel('Tiempo');
ylabel('Altura (h)');
title('Altura tanque');