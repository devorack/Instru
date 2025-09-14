%PRIMER ORDEN CIRCUITO

clear all;
close all;

global R1 R2 R3 R4 FREQ PERIODO V V_neg L;

% Frecuencia de conmutación (Hz) y cálculo del periodo
FREQ = 1970; 
PERIODO = 1/FREQ;
dt_plus = PERIODO/2;          % Duración del estado u=1 (50% ciclo de trabajo)
dt_minus = PERIODO/2;          % Duración del estado u=-1 (50% ciclo de trabajo)

R1 = 1050;
R2 = 1000;
R3 = 1000;
R4 = 141;

L = 0.41e-6;
V = 5;
V_neg = -5;


% Condiciones iniciales
initCorrCap = 0;
initVolt = R2*V*1/(R1 + R2);

% Tiempo inicial
totalTime = 0;

% Vectores para almacenar los resultados de todos los ciclos
t_total = [];
Il_total = [];
IL_values_total = [];
VL_values_cycle = [];

t_total_voltaje= [];
Vl_total = [];
VL_values_total = [];

% Simular ciclos
num_cycles = 2;

initCorrCap=0;
inicialTimeNeg = 0;
inicialTimePos = 0;
finalTimePos = 0;
finalTimeNeg = 0;
dt_plus = 0.0040e-6;        
dt_minus = 0.0040e-6; 

for cycle = 1:num_cycles
    
    % Tramo con V positivo de la grafica
    % Deteminamos el rango de tiempo de estudio para ODE
    
    % Actualizar tiempo total y condición inicial para el siguiente tramo
    finalTimePos = inicialTimePos + dt_plus;
    tspan = [inicialTimePos, finalTimePos];
    [t_pos,Il_pos] = ode23(@(t, Il) definicionEcuacionPrimerOrdenCorrientez(t, R1, R2, R3, R4, L, V,Il,1) ,tspan,initCorrCap);
    
    % Para voltaje
    [t_pos_voltaje,Vl_pos] = ode23(@(t, Vl) definicionEcuacionPrimerOrdenCorriente(t, R1, R2, R3, R4, L, V,Vl,1) ,tspan,initVolt);
    
    % Definir la ecuación de Maple como una función anónima
    IL_maple_Vpos = @(t) R2*V*1/...
        (R2*R1 + R1*R4 + R2*R3 + R2*R4) + exp(-(R2*R1 + R1*R4 + R2*R3 + R2*R4)*(t-inicialTimePos)*1/(R1 + R2)*1/L)*...
        (initCorrCap*(R2*R1 + R1*R4 + R2*R3 + R2*R4) - R2*V)*1/(R2*R1 + R1*R4 + R2*R3 + R2*R4);

    % Funcion exponencial del voltaje determinada en maple:
    VL_maple_Vpos = @(t) exp(-(R2*R1 + R1*R4 + R2*R3 + R2*R4)*(t-inicialTimePos)*1/(R1 + R2)*1/L)*initVolt;        

    % Evaluar la función de Maple en el nuevo rango de tiempo
    IL_values_pos = IL_maple_Vpos(t_pos);
    VL_values_pos = VL_maple_Vpos(t_pos_voltaje);

    %{ 
      Condicion inicial nueva para usar en el siguiente tramo, que sera la
      corriente final de la anterior grafica
    %}
    initCorrCap = Il_pos(end);
    initVolt=-R2*V*1/(R1 + R2); % Por ser discontinua su voltaje inicial sera el indiciado, ya que el inductor tiende a cero por ser discontinuo al final de cada grafica
    inicialTimeNeg = finalTimePos;


    finalTimeNeg = inicialTimeNeg + dt_minus;

    % LADO NEGATIVO
    tspan = [inicialTimeNeg, finalTimeNeg];
    [t_neg,Il_neg] = ode23(@(t, Il) definicionEcuacionPrimerOrdenCorriente(t, R1, R2, R3, R4, L, V,Il,-1) ,tspan,initCorrCap);

    % Para voltaje
    [t_neg_voltaje,Vl_neg] = ode23(@(t, Vl) definicionEcuacionPrimerOrdenCorriente(t, R1, R2, R3, R4, L, V,Vl,-1) ,tspan,initVolt);

    % Definir la ecuación de Maple como una función anónima
        % Funcion exponencial de la corriente determinada en maple:
        IL_maple_Vneg = @(t) R2*V_neg/...
            (R2*R1 + R1*R4 + R2*R3 + R2*R4) + exp(-(R2*R1 + R1*R4 + R2*R3 + R2*R4)*(t-inicialTimeNeg)*1/(R1 + R2)*1/L)*...
            (initCorrCap*(R2*R1 + R1*R4 + R2*R3 + R2*R4) - R2*V_neg)/(R2*R1 + R1*R4 + R2*R3 + R2*R4);
        % Funcion exponencial del voltaje determinada en maple:
        VL_maple_Vneg = @(t) exp(-(R2*R1 + R1*R4 + R2*R3 + R2*R4)*(t-inicialTimeNeg)*1/(R1 + R2)*1/L)*initVolt;         
        % Evaluar la función de Maple en el nuevo rango de tiempo
        IL_values_neg = IL_maple_Vneg(t_neg);
        VL_values_neg = VL_maple_Vneg(t_neg_voltaje);

    % Actualizar tiempo total y condición inicial para el siguiente ciclo
    initCorrCap = Il_neg(end);
    initVolt = R2*V*1/(R1 + R2);
    inicialTimePos = finalTimeNeg;
    
    % Concatenar los resultados del ciclo actual
    t_cycle = [t_pos; t_neg]; % guardamos y concatenamos los tramo de tiempos del ciclo tanto del lado con Vpos como Vneg
    Il_cycle = [Il_pos; Il_neg]; % Guardamos las soluciones de ODE para el ciclo actual
    IL_values_cycle = [IL_values_pos; IL_values_neg];  % Guardamos las soluciones de MAPLE para el ciclo actual
    
    % Agregar los resultados del ciclo al total
    t_total = [t_total; t_cycle];  % concatenamos los tiempos totales para graficar todos los ciclos de la corriente
    Il_total = [Il_total; Il_cycle]; % guardamos las soluciones de ODE totales de todos los ciclos
    IL_values_total = [IL_values_total; IL_values_cycle]; % Guardamos las soluciones de MAPLE totales de todos los ciclos

    %Concatecar valores para el voltaje
    t_cycle_voltaje = [t_pos_voltaje; t_neg_voltaje]; % guardamos y concatenamos los tramo de tiempos del ciclo tanto del lado con Vpos como Vneg
    Vl_cycle = [Vl_pos; Vl_neg]; % guardamos las soluciones de ODE para el ciclo actual
    VL_values_cycle = [VL_values_pos; VL_values_neg];  % guardamos las soluciones de MAPLE para el ciclo actual

    % Agregar los resultados del ciclo al total para el voltaje
    t_total_voltaje = [t_total_voltaje; t_cycle_voltaje]; % concatenamos los tiempos totales para graficar todos los ciclos del voltaje
    Vl_total = [Vl_total; Vl_cycle]; % guardamos las soluciones de ODE totales de todos los ciclos
    VL_values_total = [VL_values_total; VL_values_cycle]; % guardamos las soluciones de MAPLE totales de todos los ciclos

end

% Cargar el archivo CSV
data = readmatrix('corriente.CSV');

% Separar los datos en vectores de tiempo y corriente
tiempo_excel = data(:, 4)-0.00205; % Primera columna: tiempo - correccion para alinearlos
corriente_excel = data(:, 5)/R4; % Segunda columna: corriente = voltaje/resistencia , recordemos que estos valores fueron medidos con voltaje, entonces la corriente sera el voltaje/R4 = Corriente

% Graficar
figure;
plot(t_total, Il_total, 'b', 'LineWidth', 1.5); % Solución numérica (ODE)
hold on;
plot(t_total, IL_values_total, 'r--', 'LineWidth', 1.5); % Solución analítica (Maple)
hold on;
%plot(tiempo_excel, corriente_excel, 'g--', 'LineWidth', 1.5); % Osciloscopio
title('Corriente en el Inductor (Il(t))');
xlabel('Tiempo (s)');
ylabel('Il(t) (A)');
legend('Solución ODE', 'Solución Maple','Resultado Osciloscopio');
grid on;

% Graficar
figure;
plot(t_total_voltaje, Vl_total, 'b', 'LineWidth', 1.5); % Solución numérica (ODE)
hold on;
plot(t_total_voltaje, VL_values_total, 'r--', 'LineWidth', 1.5); % Solución analítica (Maple)
hold on;
%plot(tiempo_excel, corriente_excel, 'g--', 'LineWidth', 1.5); % Osciloscopio
title('Corriente en el Inductor (Il(t))');
xlabel('Tiempo (s)');
ylabel('Il(t) (A)');
legend('Solución ODE', 'Solución Maple','Resultado Osciloscopio');
grid on;


