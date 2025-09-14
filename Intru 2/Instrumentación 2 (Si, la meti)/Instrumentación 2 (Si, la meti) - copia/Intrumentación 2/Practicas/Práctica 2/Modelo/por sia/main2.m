clear all
close all
global m c1 c2 c3 c4 Fs Fd Ad Kt R V u n a A pa 

%Servo-Valvula
m = 0.3;
c1 = 208000;%208100; %218351.98 215350  215350
c2 = 120000;  %140000; %60000 160000  165000 170000 178000
c3 = 62800;%62800; %50740 70300  70300
c4 = 100; 
Fs = 90;
Fd = 420;
Ad = 0.026;
Kt = 0.9;
R = 286.9;
V = 0.00076;
pa = 81060;
u = 20684.3*5; %15psi =  3psi = 20684.3

%Tanque
a =  0.1287; %0.13679 0.138 
n = 0.2399;
A = 85.274;

% 
% Coefficients (with 95% confidence bounds):
%  p1 =   -2.37e+19  (-1.138e+20, 6.645e+19)
%        p2 =     1.4e+17  (-3.213e+17, 6.014e+17)
%        p3 =   -3.38e+14  (-1.233e+15, 5.571e+14)
%        p4 =   4.062e+11  (-4.09e+11, 1.221e+12)
%        p5 =  -2.344e+08  (-5.804e+08, 1.117e+08)
%        p6 =   7.157e+04  (1.456e+04, 1.286e+05)
%        p7 =      0.1861  (-2.454, 2.826)


%GPM Polinomio Grado 6
p1 =  -2.37e+19;
p2 = 1.4e+17;
p3 = -3.38e+14;
p4 = 4.062e+11;
p5 = -2.344e+08;
p6 = 7.157e+04;
p7 = 0.1861;

filename = ['Data3.xlsx'];
desplazamiento = xlsread(filename,1,'A:A');
tiempo = xlsread(filename,1,'B:B');

h0 = [0.000102 0 pa 0.1]; 
tspan = [0 100];

options = odeset('RelTol',1e-6,'AbsTol',1e-6);
[t,x] = ode23tb('ecServo2',tspan,h0,options);
% 
figure(1);
plot(t,x(:,1),'b',tiempo,desplazamiento/1000,'.');
title('Desplazamiento del vastago');
grid on

figure(2);
plot(t,x(:,2),'r');
title('Velocidad del desplazamiento del vastago');
grid on

figure(3);
plot(t,x(:,3),'r');
title('Dinamica de la presion dentro de la camara de diafragma');
grid on

fa = ((p1*x(:,1).^6 + p2*x(:,1).^5 + p3*x(:,1).^4 +...
    p4*x(:,1).^3 + p5*x(:,1).^2 + p6*x(:,1) + p7));
disp('Polinomio');
disp(fa);
figure(4);
plot(x(:,1),fa,'r'); 
title('Caudal contra desplazamiento');
grid on

figure(5);
plot(t,fa,'r');
title('Caudal contra el tiempo');
grid on

figure(6);
plot(t,x(:,4),'r');
title('Tiempo contra Nivel');
grid on


