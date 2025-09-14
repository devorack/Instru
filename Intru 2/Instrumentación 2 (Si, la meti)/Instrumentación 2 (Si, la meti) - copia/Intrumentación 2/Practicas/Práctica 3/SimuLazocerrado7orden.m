clear all  % Limpia todas las variables del espacio de trabajo.
close all  % Cierra todas las ventanas.
clc        % Clear console

global A1 A3 rho g A lB1
global b0 b1 b2
global p0 L DeltaL1 p3 h0
global f1 Vref
global kp Ti U banda
global m kt Av c1 c2 c3 c4 R V Fs Fd
global spam banda_H banda_L Rango_VP
global tt yy yy2 qq ii pp xx xx2
global p11 p22 p33 p44 p55 pp1 pp2 pp3 pp4 pp5

%------------------------------------------------------%

A1 = 0.12668e-3; A3 = 0.1079765841e-4;  rho = 1000; g = 9.81; A = 0.410e-1; lB1 = 2;
b0 = 301692; b1 = -6574.9; b2 = -2830;

p0 = 81060;  L = .9281;  DeltaL1= 0; p3 = 81060; h0 = 0;

m = 0.3; kt = 6.9; Av = 0.260e-1; 
c1 = 0.196e6; c2=0.800e5; c3 = 0.5074e5; c4 = 1.0e2; 
R =286.9; V = 7.60e-4; Fs = 90; Fd = 420; 

f1 = 43.83802477;  Vref=0.4035;
T=0;

spam = 93079.26; %Spam del actuador es pascales (15-3)psi

U = 6.3205*6894.76;
Rango_VP = (25.5625-11.125)*.0254; % Rango de la variable de proceso (tabla de mediciones para relacion de mA con pulgadas)
kp = 0.98; Ti = (0.35*60);

Data2 = importdata('tanque.CSV',',',0);
Data = importdata('data2.CSV',',',0);






p11 =   0.0003;
p22 =    -0.0162;
p33 =       0.3110;
p44 =     -1.6700;
p55 =     8.0199;


  pp1 =    0.000242;
  pp2 =   -0.006939;
  pp3 =    -0.02493;
  pp4 =        2.95;
  pp5 =      -10.21;




tt=[0];
yy=[0];

    options = odeset('RelTol',1e-8,'AbsTol',1e-8);
    y0 = [0.1 0 0.25 0 20684.28 0.00 0 28958 0];% Condiciones iniciales para cuando 
                                              % llegue a el rango de PB
                                              % se necesita tomar h, qi y
                                              % X1v
    tspan=[tt 700];
    [t1,x1] = ode23t('Lazocerrado7orden', tspan, y0,options);
    
    

figure(1)
plot(t1,(x1(:,1))*39.3701,'r-',Data(74:1346,4)-18.2,pp1*((Data(74:1346,5)/283)*1000).^4+pp2*((Data(74:1346,5)/283)*1000).^3 + pp3*((Data(74:1346,5)/283)*1000).^2 + pp4*((Data(74:1346,5)/283)*1000)+pp5,'b');
grid;
title('Altura en Tanque Presurizado');
xlabel('Tiempo: seg');
ylabel('h(t): m');

% figure(2)
% plot(t1,x1(:,2),'b-');
% grid;
% title('Velocidad del Tanque');
% legend('ODE');
% xlabel('Tiempo seg');
% ylabel('x2(t)');
% 
% figure(3)
% plot(t1,x1(:,3),'b-');
% grid;
% title('Flujo de Entrada');
% xlabel('Tiempo seg');
% ylabel('Qi(t) Kg/seg');
% 
% 
% figure(5)
% plot(t1,x1(:,5),'b-');
% grid;
% title('Presion en la camara de la valvula');
% legend('ODE');
% xlabel('Tiempo seg');
% ylabel('p2(t) pas');
% 
% figure(6)
% plot(t1,x1(:,6),'b-');
% grid;
% title('Desplazamiento actuador');
% xlabel('Tiempo seg');
% ylabel('Xv(t) m');

figure(11)
plot(t1,x1(:,8)*0.000145038,'r',Data(154:1346,4)-18.2,p11*((Data(154:1346,5)/283)*1000).^4+p22*((Data(154:1346,5)/283)*1000).^3 + p33*((Data(154:1346,5)/283)*1000).^2 + p44*((Data(154:1346,5)/283)*1000)+p55,'b');
grid;
title('Presion del tanque');

% figure(12)
% plot(t1,x1(:,9));
% grid;
% title('CAUDAL DE SALIDA');
