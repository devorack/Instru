clear all
close all
global m c1 c2 c3 c4 Fs Fd Ad Kt R V u n a A pa fa p1 p2 p3 p4 p5 p6 p7

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
u = 20684.3*4; %15psi =  3psi = 20684.3

%Tanque
a = 0.1287; 
n = 0.2399; 
A = 85.274;



%GPM Polinomio Grado 4
p1 =  -6.759e08;
p2 = 2.177e07;
p3 = -2.151e05;
p4 = 1201;
p5 = 0.173;


% %GPM Polinomio Grado 5
% p1 =  5.06e+10;
% p2 = -2.81e+09;
% p3 =  5.317e+07;
% p4 = -4.026e+05;
% p5 = 1583;
% p6 = 0.08266;

filename = ['Data3.xlsx'];
desplazamiento = xlsread(filename,1,'A:A');
tiempo = xlsread(filename,1,'B:B');

h0 = [0.000102 0 pa 0.1]; 
tspan = [0 4000];

options = odeset('RelTol',1e-6,'AbsTol',1e-6);
[t,x] = ode23tb('ecServo2',tspan,h0,options);

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

figure(4);
plot(t,x(:,4),'r');
title('Nivel');
grid on

%fa de polinomio de grado 4
fa = ((p1*x(:,1).^4 + p2*x(:,1).^3 + p3*x(:,1).^2 + p4*x(:,1) + p5));


% %fa de polinomio de grado 5
% fa = ((p1*x(:,1).^5 + p2*x(:,1).^4 + p3*x(:,1).^3 + p4*x(:,1).^2 + p5*x(:,1) + p6));
% 


% figure(5);
% plot(x(:,1),fa,'r'); 
% title('Caudal contra desplazamiento');
% grid on

% figure(6);
% plot(t,fa,'r');
% title('Caudal contra el tiempo');
% grid on


