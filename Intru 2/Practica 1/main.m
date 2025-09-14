close all
clear all

global qi A k g n At 

qi=5.75;%13;     %Flujo de entrada
A=79.6833;%83.35;%97.475;      %Area del tanque
At=0.441;    %Area Transversal de la válvula
k= 0.0693;    %
g=388.89; %Gravedad en pulgadas/s^2
n=0.1987;


archivoX1 = csvread('./Data/Relacion.csv', 0, 0);

h = archivoX1(:, 1);
v = archivoX1(:, 2);

