filename = ['Relacion_caudal.xlsx'];
mA = xlsread(filename,1,'A:A');
caudal = xlsread(filename,1,'B:B');

disp(mA);
disp(caudal);

