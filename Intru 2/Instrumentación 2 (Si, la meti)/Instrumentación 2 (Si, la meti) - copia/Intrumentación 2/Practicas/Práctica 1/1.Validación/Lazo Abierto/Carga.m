global n a qi A 

a =  0.1287; %0.13679 0.138 
n = 0.2399; % 0.23199 0.22899
A = 85.274; %Area transversal del tanque 92.90 85.27 89.99
qiGPM = 5.75;
qi = qiGPM*(3.85); %Flujo de entrada del tanque
h0 = 0;
tspan = [0 1500];

[t,y]= ode23('tanqueCar',tspan,h0);
    
filename = importdata('F0000CH2.CSV',',',0);
filename2 = importdata('F0001CH2.CSV',',',0);
filename3 = importdata('F0002CH2.CSV',',',0);


relacion = 'relacion.xlsx';
Voltaje = xlsread(relacion,1,'A:A');
Altura = xlsread(relacion,1,'B:B');



vt = filename(136:2370,4);
vv = filename(136:2370,5);
v1 = filename2(141:2375,4);
v2 = filename2(141:2375,5);
v3 = filename3(1:2235,4);
v4 = filename3(1:2235,5);




for i = 1:length(v1)
  v1(i) = v1(i) + (445.64);
end

for i = 1:length(v3)
  v3(i) = v3(i) + (920.44);
end



DataTime = [vt v1 v3];
DataVolt = [vv v2 v4];


[t,y]=ode23('tanqueCar',tspan,h0);

figure(1);
plot(DataTime(1:6618),(6.17*DataVolt(1:6618)+1.072),t,y);
%plot(DataTime(1:6618),DataVolt(1:6618));
title('Simulacion del Modelo para tanque Abierto');
xlabel('Tiempo');
ylabel('Altura');
grid on


