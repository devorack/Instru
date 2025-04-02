% Valores fijos
frecuencia = 10500;
periodo = 1/frecuencia;

L = 2.37e-3;
E = 1; % valor pico a pico
Rf = 50;
Rml = 100;
Rl = 0.8;
Rc = 100;
R = 10e3;
f = 13516.89272; % frecuencia de la imagen
T = 1/f;                   

% Valores de C y nombres de casos
C_v = [1.507904963*10^(-7), 0.03*10^(-6), 6.088199105*10^(-7)];  
case_names = {'Critico', 'Subamortiguado', 'Sobreamortiguado'};

% Parámetros de la simulación                
t_cycle = periodo/2;           % Duración de un ciclo (s)
num_cycles = 3;                % Número de ciclos
tspan = linspace(0, num_cycles * t_cycle, 1000);  % Tiempo total de la simulación

% Inicializar estructura para almacenar resultados
results = struct();

% Simulación para cada valor de C
for i = 1:length(C_v)
    C = C_v(i);

    initial_conditions = [0; 0];  % Condiciones iniciales para cada caso
 
    % Inicializar vectores para acumular resultados
    t_total = [];
    Il_total = [];
    Vl_total = [];
    Vc_total = [];
    Ic_total = [];

    % Simular varios ciclos alternando entre V+ y V-
    for cycle = 0:(num_cycles-1)
        % Alternar voltaje
        if mod(cycle, 2) == 0
            V_signal = E;      % Ciclo positivo
        else
            V_signal = -E;     % Ciclo negativo
        end

        % Sistema ODE continuas
        rlc_ode = @(t, y) rlc_system(t, y, R, Rc, Rl, Rml, Rf, L, C, V_signal);
        
        % Solución ODE continuas
        [t, y] = ode45(rlc_ode, [0, t_cycle], initial_conditions);
        
        % Variables
        Il = y(:, 1);          % Corriente en inductor
        Vc = y(:, 2);          % Voltaje en capacitor

        % Calcular derivadas
        dIdt = zeros(size(Il));
        dVcdt = zeros(size(Vc));
        
        for j = 1:length(t)
            dy = rlc_system(t(j), y(j,:)', R, Rc, Rl, Rml, Rf, L, C, V_signal);
            dIdt(j) = dy(1);
            dVcdt(j) = dy(2);
        end

        Vl = L * dIdt;         % Voltaje en inductor
        Ic = C * dVcdt;        % Corriente en capacitor
    
        % Acumular resultados
        t_total = [t_total; t + cycle * t_cycle];
        Il_total = [Il_total; Il];
        Vl_total = [Vl_total; Vl];
        Vc_total = [Vc_total; Vc];
        Ic_total = [Ic_total; Ic];

        initial_conditions = y(end, :);
    end
    
    % Guardar resultados en la estructura
    results(i).t = t_total;
    results(i).Il = Il_total;
    results(i).Vl = Vl_total;
    results(i).Vc = Vc_total;
    results(i).Ic = Ic_total;
    results(i).name = case_names{i};
end

% Graficar los resultados para cada caso
for i = 1:length(C_v)
    % Obtener datos
    t_total = results(i).t;
    Il_total = results(i).Il;
    Vl_total = results(i).Vl;
    Vc_total = results(i).Vc;
    Ic_total = results(i).Ic;

    figure('Name', ['Simulacion RLC - ', results(i).name]); 

    % Graficar las respuestas acumuladas
    subplot(4, 1, 1);
    plot(t_total, Il_total, 'b');
    title(['IL Inductor: ', results(i).name]);
    xlabel('Tiempo (s)');
    ylabel('Corriente (A)');
    grid on;

    subplot(4, 1, 2);
    plot(t_total, Vl_total, 'r');
    title(['VL Inductor: ', results(i).name]);
    xlabel('Tiempo (s)');
    ylabel('Voltaje (V)');
    grid on;

    subplot(4, 1, 3);
    plot(t_total, Vc_total, 'g');
    title(['Vc Capacitor: ', results(i).name]);
    xlabel('Tiempo (s)');
    ylabel('Voltaje (V)');
    grid on;

    subplot(4, 1, 4);
    plot(t_total, Ic_total, 'm');
    title(['Ic Capacitor: ', results(i).name]);
    xlabel('Tiempo (s)');
    ylabel('Corriente (A)');
    grid on;
end