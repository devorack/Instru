clear all
close all

filename = 'GalonesDesplazamiento.xlsx';
Galones = xlsread(filename,1,'A:A');
Desplazamiento = xlsread(filename,1,'B:B');

figure(1);
plot(Desplazamiento,Galones,'*');
grid on




