filename = ['Relacion_PSI_H_mA.xlsx'];
PSI = xlsread(filename,1,'A:A');
altura = xlsread(filename,1,'B:B');
mA = xlsread(filename,1,'C:C');

disp(PSI);
disp(altura);
disp(mA);
