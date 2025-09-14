global n a 

a = 0.1402; %  0.12899 0.13245 0.13299 NO BORRAR POR FAVORRRRR att kei0.13599 .138
n = 0.21; %  0.23199 0.22199 0.22199
h0 = 18.47;
tspan = [0 83];

filename = importdata('F0003CH2.CSV',',',0);
tiempo = filename(1:397,4);
voltaje = filename(1:397,5);

[t,y]=ode23('tanqueDes',tspan,h0);
figure(1);
plot(tiempo,(6.17*voltaje + 1.072),'r',t,y,'g');
grid on


