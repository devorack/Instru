clear all
close all
clc

global L C E Rf Rml Rl Rc R 

L = 2.37e-3;
E = 2.5; %valor pico a pico
Rf = 50;
Rml = 100;
Rl = 0.8;
Rc = 100;
R = 10e3;
C = 3.626576500*10^(-8);% numero a variar sub
f = 13516.89272; % frecuencia de la imagen
T = 1/f; %1/f periodo

tt=0;
xx=[0 0 0 0];
t0=0;
tf=T/2;

tspan=[t0 tf];
h0=[0 0 0 0]';

for i=1:4

options = odeset('RelTol',1e-03,'AbsTol',[1e-03,1e-3,1e-3,1e-3]);
[t,x]=ode45('ecuaciones',tspan,h0,options);
tt=[tt;t];
xx=[xx;x];

h0=[x(length(x),1) x(length(x),2) x(length(x),3) x(length(x),4)]';

t0=tf;
%tf=i*T;
tf=tf+T/2;

tspan=[t0 tf];

options = odeset('RelTol',1e-03,'AbsTol',[1e-03,1e-3,1e-3,1e-3]);
[t,x]=ode23('ecuaciones',tspan,h0);
tt=[tt;t];
xx=[xx;x];

h0=[x(length(x),1) x(length(x),2) x(length(x),3) x(length(x),4)]';

t0=tf;
tf=t0+T/2;

tspan=[t0 tf];
end

%     [tiempo_ode, valores_ode] = ode45(@ecuaciones, tspan, condiciones_iniciales, options);
     
figure(1)
plot(tt,xx)
grid
subplot(2,1,1) % Primera gráfica (Corriente)
plot(tt, xx(:,1), 'b') % Corriente en azul
grid on
title('Corriente en el Inductor I_L(t)')
ylabel('Corriente (I)')
legend('I_L(t)')

subplot(2,1,2) % Segunda gráfica (Voltaje)
plot(tt, xx(:,2), 'r') % Voltaje en rojo
grid on
title('Voltaje en el capacitor V_c(t)')
ylabel('Voltaje (V)')
xlabel('Tiempo (s)')
legend('V_c(t)')

figure(3);%Grafica de los diagramas de fases
plot(xx(:,1),xx(:,2));
title('Diagrama de fases ');