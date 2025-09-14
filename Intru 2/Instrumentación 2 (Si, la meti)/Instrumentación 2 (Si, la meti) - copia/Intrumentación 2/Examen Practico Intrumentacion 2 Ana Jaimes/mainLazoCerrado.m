clear all
close all
global valor_deseado kp ki m c1 c2 c3 c4 Fs Fd Ad Kt R V n a A p1 p2 p3 p4 p5 p11 p22 p33 p44 p55 p66

%Parametros de la Servo-Valvula
m = 0.3;
c1 = 215555;% 208000
c2 = 100000;  % 120000
c3 = 99999; % 62800
c4 = 100; % 100
Fs = 90;
Fd = 420;
Ad = 0.026;
Kt = 0.9;
R = 286.9;
V = 0.00076;
pAtm = 81060;

%Parametros del controlador
kp = 3.6;%1006;% 3.6  400
ki = 0.8;%4.8;% 0.8 1
valor_deseado = 7.22;

%GPM Polinomio Grado 4
p1 =  -6.759e08;
p2 = 2.177e07;
p3 = -2.151e05;
p4 = 1201;
p5 = 0.173;

p11 = 0.1981;
p22 = -10.56;
p33 = 218.9;
p44 =  -2252;
p55 = 1.285e+04;
p66 = 3.309e+04;

%Parametros Tanque
a = 0.1209; % 0.1287 1209
n = 0.4128; % 0.2399 3992
A = 85.274;

Data = importdata('F0000CH1.CSV',',',0);


h0 = [0.000102 0 pAtm 0.1 0]; 
tspan = [0 600];

options = odeset('RelTol',1e-6,'AbsTol',1e-6);
[t,x] = ode23tb('ecServoC',tspan,h0,options);


figure(1);
plot(t, x(:,4),'b',Data(:,4)-3,(((Data(:,5)*6.17)+1.072)-1.75),'g')
title('Nivel en el tanque');
grid on


