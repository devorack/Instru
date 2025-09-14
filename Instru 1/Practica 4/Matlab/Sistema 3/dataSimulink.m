% Load Excel data
archivoX1 = csvread('./Data/X1.csv', 0, 0);
archivoX2 = csvread('./Data/X2.csv', 0, 0);
archivoX3 = csvread('./Data/X3.csv', 0, 0);
frecc1 = csvread('./Data/F1.csv', 0, 0);
frecc2 = csvread('./Data/F2.csv', 0, 0);
frecc3 = csvread('./Data/F3.csv', 0, 0);

timeFrecc1 = frecc1(:, 1);
Frecc1 = frecc1(:, 2);
timeFrecc2 = frecc2(:, 1);
Frecc2 = frecc2(:, 2);
timeFrecc3 = frecc3(:, 1);
Frecc3 = frecc3(:, 2);

timeX1 = archivoX1(:, 1);
X1 = archivoX1(:, 2);

timeX2 = archivoX2(:, 1);
X2 = archivoX2(:, 2);

timeX3 = archivoX3(:, 1);
X3 = archivoX3(:, 2);

%C_X1 = comportamientos(:, 1);
%C_X2 = comportamientos(:, 2);
%C_X3 = comportamientos(:, 3);


% Extract Simulink data from table 'x1'
simTime = subSimulink.time;
simDataX1 = subSimulink.signals(1).values;
simDataX2 = subSimulink.signals(2).values;
simDataX3 = subSimulink.signals(3).values;





figure(1);

subplot(4,1,1);
plot(timeX1-0.6, X1-0.9,'g', 'DisplayName', 'Excel Data');
hold on;
%plot(t-16, C_X1*12, 'DisplayName', 'Excel Data');
hold on;
plot(simTime, simDataX1,'r', 'DisplayName', 'Simulink Data');

title('Gráfica X1');
xlabel('Tiempo');
ylabel('Valor');
legend;
hold off;


subplot(4,1,2);
plot(timeX2-2.4, X2+0.7,'g' ,'DisplayName', 'Excel Data');
hold on
%plot(t-16, C_X2, 'DisplayName', 'Excel Data');
hold on;
plot(simTime, simDataX2,'r', 'DisplayName', 'Simulink Data');

title('Gráfica X2');
xlabel('Tiempo');
ylabel('Valor');
legend;
hold off;


subplot(4,1,3);
plot(timeX3+1.4, X3+0.2,'g' ,'DisplayName', 'Excel Data');
hold on
%plot(t-16, C_X3, 'DisplayName', 'Excel Data');
hold on;
plot(simTime, simDataX3,'r', 'DisplayName', 'Simulink Data');

title('Gráfica X3');
xlabel('Tiempo');
ylabel('Valor');
legend;
hold off;

subplot(4,1,4);
plot(timeFrecc1+4, Frecc1,'r' ,'DisplayName', 'Excel Data');
hold on
plot(timeFrecc2+0.1, Frecc2,'g' ,'DisplayName', 'Excel Data');
hold on
plot(timeFrecc3+2, Frecc3,'b' ,'DisplayName', 'Excel Data');

%plot(t-16, C_X3, 'DisplayName', 'Excel Data');

title('Gráfica Entrada');
xlabel('Tiempo');
ylabel('Valor');
legend;
hold off;


%idx = 1:210:length(X1);
%figure(2);
%plot3(C_X1(idx), C_X2(idx), C_X3(idx), 'LineWidth', 1.5);
figure(2);
plot3(X1, X2, X3, 'LineWidth', 1.5);
xlabel('X1');
ylabel('X2');
zlabel('X3');
title('Diagrama de Fase');
grid on;



