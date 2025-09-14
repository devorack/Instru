clear all
close all

filename = 'PsiDesplazamiento.xlsx';
PSI = xlsread(filename,1,'A:A');
Desplazamiento = xlsread(filename,1,'B:B');

figure(1);
plot(Desplazamiento,PSI,'*');
grid on
