% Definición de matrices

A = [[0 1 0 0]; 
     [-510000.170721727 -300000.0000 0.08666666666 0];
     [0 0 -4.127607272 0];
     [6.76824447984018 0 0 -0.00321811850512744]];

B = [0; 0;4.127607272;0];
C = [0 0 0 1];
D = 0;

% Conversión a función de transferencia
[num, den] = ss2tf(A, B, C, D);
G = tf(num, den)
