% Definición de matrices

A = [[0 1 0 0]; 
     [-510000.091196214 -300000.0000 0.08666666666 0];
     [0 0 -4.127607272 0];
     [36.2006922702773 0 0 -0.002003179976]];

B = [0; 0;4.127607272;0];
C = [0 0 0 1];
D = 0;

% Conversión a función de transferencia
[num, den] = ss2tf(A, B, C, D);
G = tf(num, den)
