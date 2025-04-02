% Load Excel data
archivo = csvread('sub.csv', 18, 0); % Corrected to 'csvread' and file extension to '.csv'
%archivo = csvread('critico.csv', 18, 0); % Corrected to 'csvread' and file extension to '.csv'
%archivo = csvread('sobre.csv', 18, 0); % Corrected to 'csvread' and file extension to '.csv'
tiempo = archivo(:, 1);
data = archivo(:, 2);

% Extract Simulink data from table 'x1'
simTime = x1.Time;
simData = x1.Data;

% % Plot Excel data
%sub amortiguado
plot(tiempo+12.5, data, 'DisplayName', 'Excel Data');
%sobre
%plot(tiempo+16.5, data, 'DisplayName', 'Excel Data');
%critico
%plot(tiempo+13.5, data, 'DisplayName', 'Excel Data');

hold on;

% Plot Simulink data
plot(simTime, simData, 'DisplayName', 'Simulink Data');

% Add labels and legend
xlabel('Time');
ylabel('Values');
legend;
hold off;