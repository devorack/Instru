% Load Excel data
archivo = csvread('../excels/sub.csv', 18, 0); % Corrected to 'csvread' and file extension to '.csv'
%archivo = csvread('../excels/cri.csv', 18, 0); % Corrected to 'csvread' and file extension to '.csv'
%archivo = csvread('../excels/sob.csv', 18, 0); % Corrected to 'csvread' and file extension to '.csv'
tiempo = archivo(:, 1);
data = archivo(:, 2);

% Extract Simulink data from table 'x1'
simTime = subSimulink.time;
simData = subSimulink.signals(1).values;
figure;
% % Plot Excel data
%sub amortiguado
plot(tiempo+0.549e-3, data, 'DisplayName', 'Excel Data');
%sobre
%plot(tiempo+0.6e-3, data, 'DisplayName', 'Excel Data');
%critico
%plot(tiempo+0.7e-3, data, 'DisplayName', 'Excel Data');

hold on;

% Plot Simulink data
plot(simTime, simData,'r', 'DisplayName', 'Simulink Data');

% Add labels and legend
xlabel('Time');
ylabel('Values');
legend;
hold off;