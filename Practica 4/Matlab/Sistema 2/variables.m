E=5;
L = 2.37e-3;
Rf = 50;
Rml = 100;
Rl = 0.8;
Rc = 100;
R = 10e3;
C = 0.6e-6;
frecuencia = 935.9;
periodo = 1/frecuencia;


gain1 = (R*Rc)+(R*Rf)+(R*Rl)+(R*Rml)+(Rc*Rf)+(Rc*Rl)+(Rc*Rml);
gain2 = R+Rc;
gain3 = (R+Rc)*L;
gain4 = (R+Rc)*C;

fprintf('El valor (R*Rc)+(R*Rf)+(R*Rl)+(R*Rml)+(Rc*Rf)+(Rc*Rl)+(Rc*Rml): %d\n', gain1);
fprintf('El valor R+Rc: %d\n', gain2);
fprintf('El valor(R+Rc)*L %d\n', gain3);
fprintf('El valor (R+Rc)*C %d\n', gain4);