close all
clear;
clc;
    p1 = 6.236;
    p2 = 0.03702;

% Load Excel data
%%archivo = csvread('./Data/TanqueAbierto.csv', 1, 0); 
%%tiempoTanqueAbierto = archivo(:, 1);
%%voltajeTanqueAbierto = archivo(:, 2);
%%figure(2);

%%plot(tiempoTanqueAbierto,((voltajeTanqueAbierto*p1) + p2)-1.1,'r');
%%hold on;

archivo = csvread('./Data/DesplazamientoBastago.csv', 1, 0); 
tiempo = archivo(:, 1);
data = archivo(:, 2);

figure(1);
subplot(4, 1, 1);
plot(tiempo-0.4, data/1000);
xlabel('Tiempo');
ylabel('Desplazamiento X');
title('Desplazamiento vastago');
hold on;

flujoDesaplazamiento = csvread('./Data/FlujoDesaplazamiento.csv', 1, 0); 
Q = flujoDesaplazamiento(:, 1);
X_F = flujoDesaplazamiento(:, 2);
%figure(2);
%plot(X_F, Q,'r');
%hold on;

global m c1 c2 c3 c4 Fs Fd Ad Kt R V u alpha beta Area a0 a1 a2 a3 a4

%tanque 
Area = 85;   
alpha = 0.140099;%0.1219;
beta = 0.22449;%0.2191;

 % Coeficientes del polinomio de flujo (ajustados)
    a3 = -1.8631e+06;    
    a2 = 4.3737e+04; 
    a1 = 302.6482; 
    a0 = 0.3841;

%Servo-Valvula

    %Valores a ajustar
    c1 = 159500;
    c2 = 90000;
    c3 = 6500;
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
    u = 14*6894.75729;%96526.6;%20684.3*14; %factor de conversion por PSI medido

%Pd sale de la presion atm en unidades de pascal
Y0 = [0; 0; 81060;0.1];
results_t = [];

[t, x] = ode23s(@(t, Y) ec_differential(t,Y), [0, 2500], Y0);


figure(1);
% Subgráfica para Il_t
subplot(4, 1, 1);
plot(t, x(:,1));
xlabel('Tiempo');
ylabel('Desplazamiento X');
title('Desplazamiento vastago');

subplot(4, 1, 2);
plot(t, x(:,2));
xlabel('Tiempo');
ylabel('Velocidad');
title('Velocidad vastago');

subplot(4, 1, 3);
plot(t, x(:,3));
xlabel('Tiempo');
ylabel('Presion');
title('Presion vastago');

subplot(4, 1, 4);
plot(t, x(:,4),'g');
xlabel('Tiempo');
ylabel('Altura (h)');
title('Altura tanque');