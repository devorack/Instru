filename = ['Relacion_psi_ma.xlsx'];
psi = xlsread(filename,1,'A:A');
ma = xlsread(filename,1,'B:B');

disp(psi);
disp(ma);
