clear all
close all

filename = 'Altura-PSI.xlsx';
Altura = xlsread(filename,1,'A:A');
PSI = xlsread(filename,1,'B:B');

figure(1);
plot(Altura,PSI,'*');
grid on;




