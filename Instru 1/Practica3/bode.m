clear all
close all
clc

global L C V Rf Rml Rl Rc R 

L = 2.37e-3;
V = 1.28; %valor pico a pico
Rf = 50;
Rml = 100;
Rl = 0.8;
Rc = 100;
R = 10e3;
C = 0.3*10^(-6); %sobreamortiguado

%PARTE TEORICA

%  w = logspace(1, 7, 1000); % Crear un vector de valores de w en escala logarítmica
w = 1:10:10E5;

IL = tf([0 C*(R+Rc) 1],[(R+Rc)*L*C ((Rc+Rf+Rl+Rml)*R+Rc*(Rf+Rl+Rml))*C+L R+Rf+Rl+Rml]);
VC = tf([0 0 R],[(R+Rc)*L*C ((Rc+Rf+Rl+Rml)*R+Rc*(Rf+Rl+Rml))*C+L R+Rf+Rl+Rml]);

%Valores Inductor
parteRealIL = (-0.004676141482*w.^2 + 10150.8)./(1.030387406*10^8 + 0.4307395586*w.^2 + 5.156819721*10^(-11)*w.^4);
parteImagIL =(63.17738639*w - 4.415716626*10^(-8)*w.^3)./(1.030387406*10^8 + 0.4307395586*w.^2 + 5.156819721*10^(-11)*w.^4);
MagnitudIL = 20*log10(sqrt(parteRealIL.^2 + parteImagIL.^2));

anguloFaseIL = atan(parteImagIL./parteRealIL)*(180/pi());



%%
%Valores Capacitor
parteRealVC =(-0.07181100000*w.^2 + 1.015080000*10^8)./(1.030387406*10^8 + 0.4307395586*w.^2 + 5.156819721*10^(-11)*w.^4);
parteImagVC =7592.940000*w./(1.030387406*10^8 + 0.4307395586*w.^2 + 5.156819721*10^(-11)*w.^4);

MagnitudVC = 20*log10(sqrt(parteRealVC.^2 + parteImagVC.^2));

anguloFaseVC = atan(parteImagVC./parteRealVC)*(180/pi());
omegan = 37597.12603;

% Definir la función phi
phi = 180 * atan(parteImagVC ./ parteRealVC) / pi();

% Inicializar el vector phi1 con ceros
phi1 = zeros(size(w));

% Calcular phi1 por partes
for i = 1:length(w)
    if w(i) < omegan
        phi1(i) = phi(i);
    else
        phi1(i) = phi(i) - 180;
    end
end

%%
% Data Magnitud IL
FRECU_IL=xlsread('DATA_LAB.xlsx','J3:J14');
MAG_IL=xlsread('DATA_LAB.xlsx','P3:P14');

%Datos fase IL
FRECU_IL=xlsread('DATA_LAB.xlsx','J3:J14');
ANG_IL=xlsread('DATA_LAB.xlsx','Q3:Q14');

%%
% Data Magnitud VC
FRECU_VC=xlsread('DATA_LAB.xlsx','A3:A14');
MAG_VC=xlsread('DATA_LAB.xlsx','G3:G14');

%Datos fase VC
FRECU_VC=xlsread('DATA_LAB.xlsx','A3:A14');
ANG_VC=xlsread('DATA_LAB.xlsx','H3:H14');


%%
%%Graficas de Bode y Fases para Inductor

opts = bodeoptions('cstprefs');
opts.FreqUnits = 'Hz';


figure(1); %Magnitud IL
subplot(2,1,1)
plot(FRECU_IL, MAG_IL,'r');
title('Diagrama Bode iL-Magnitud')
xlabel('W')
grid on;
hold on
bodemag(IL,opts);
hold on
%plot((w/(2*pi)), MagnitudIL,'g');
title('Diagrama Bode iL-Magnitud')
xlabel('W')
legend('Experimental','Matlab');
grid on;
hold on

subplot(2,1,2);%Phase IL
k = bodeplot(IL,opts);
setoptions(k,'MagVisible','off');
grid on;
hold on
plot(FRECU_IL, ANG_IL,'r');
%semilogx((w/(2*pi)), anguloFaseIL, 'g');
hold off
title('Diagrama Bode iL-Phase')
xlabel('W')
legend('Matlab','Experimental');

%%
%%Graficas de Bode y Fases para Capacitor

figure(4); %Magnitud VC
subplot(2,1,1);
plot(FRECU_VC,MAG_VC, 'r');
title('Diagrama Bode VC-Magnitud');
xlabel('W');
grid on;
hold on;
%plot((w/(2*pi)),MagnitudVC, 'g');
title('Diagrama Bode VC-Magnitud');
xlabel('W');
grid on;
hold on;
bodemag(VC,opts);
grid on;
hold on;
legend('Experimental', 'Matlab');
title('Diagrama Bode VC-Magnitud');
xlabel('W');

subplot(2,1,2);
k1 = bodeplot(VC,opts);
setoptions(k1,'MagVisible','off');
grid on;
hold on
plot(FRECU_VC, ANG_VC,'r');
%semilogx((w/(2*pi)), phi1, 'g');
hold off
title('Diagrama Bode VC-Phase')
xlabel('W')
legend('Matlab','Experimental');