% Load Excel data
archivoX1 = csvread('./Data/X1.csv', 0, 0);
archivoX2 = csvread('./Data/X2.csv', 0, 0);
archivoX3 = csvread('./Data/X3.csv', 0, 0);
comportamientos = csvread('./Data/Comportamientos.csv', 0, 0);
timeX1 = archivoX1(:, 1);
X1 = archivoX1(:, 2);

timeX2 = archivoX2(:, 1);
X2 = archivoX2(:, 2);

timeX3 = archivoX3(:, 1);
X3 = archivoX3(:, 2);

C_X1 = comportamientos(:, 1);
C_X2 = comportamientos(:, 2);
C_X3 = comportamientos(:, 3);


N = length(C_X3);
t = (0:N-1) /1430;


% Extract Simulink data from table 'x1'
simTime = subSimulink.time;
simDataX1 = subSimulink.signals(1).values;
simDataX2 = subSimulink.signals(2).values;
simDataX3 = subSimulink.signals(3).values;





figure(1);

subplot(3,1,1);
plot(timeX1+3.8, X1,'g', 'DisplayName', 'Excel Data');
hold on;
plot(t-16, C_X1*12, 'DisplayName', 'Excel Data');
hold on;
plot(simTime, simDataX1,'r', 'DisplayName', 'Simulink Data');

title('Gráfica 1');
xlabel('Tiempo');
ylabel('Valor');
legend;
hold off;


subplot(3,1,2);
plot(timeX2+6.54, X2,'g' ,'DisplayName', 'Excel Data');
hold on
plot(t-16, C_X2, 'DisplayName', 'Excel Data');
hold on;
plot(simTime, simDataX2,'r', 'DisplayName', 'Simulink Data');

title('Gráfica 1');
xlabel('Tiempo');
ylabel('Valor');
legend;
hold off;


subplot(3,1,3);
plot((timeX3/1.14)-14.5, X3,'g' ,'DisplayName', 'Excel Data');
hold on
plot(t-16, C_X3, 'DisplayName', 'Excel Data');
hold on;
plot(simTime, simDataX3,'r', 'DisplayName', 'Simulink Data');

title('Gráfica 1');
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



