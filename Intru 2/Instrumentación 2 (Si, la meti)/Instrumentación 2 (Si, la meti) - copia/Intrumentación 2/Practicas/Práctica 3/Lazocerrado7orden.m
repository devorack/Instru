% Definición de la función que contiene las Ecuaciones Diferenciales
% que representa al sistema de Tercer Orden.

function xdot = Lazoabierto(t,x);

% Declaraciones de variables globales R1 Rc R2 Rf C VS 

global A1 A3 rho g A lB1 dx2
global b0 b1 b2
global p0 L DeltaL1 p3 h0
global f1 Vref
global kp Ti U banda
global m kt Av c1 c2 c3 c4 R V Fs Fd
global spam banda_L banda_H Rango_VP
global tt yy yy2 qq ii pp xx xx2
        %%%%%LITERAL%%%%%%
%%
er=Vref-x(1);




A3=-13*x(6)^3+.5006*x(6)^2-0.7353e-2*x(6)+0.431e-4;

dx2 = -A3*x(2)^2/((A3+A)*x(1))+x(2)^2*A^2/((A3+A)*A3*x(1))+...
     A1*b0/((A3+A)*rho*lB1)+x(3)*b1/((A3+A)*rho^2*lB1)+...
     x(3)^2*b2/((A3+A)*rho^3*A1*lB1)-A1*p0*L/((A3+A)*rho*lB1*(L-x(1)))+...
     A1*p0*h0/((A3+A)*rho*lB1*(L-x(1)))-x(1)*A1*g/((A3+A)*lB1)+...
     A1*g*DeltaL1/((A3+A)*lB1)-(1/2)*f1*x(3)^2/((A3+A)*rho^2*lB1*A1)+...
     x(3)^2/((A3+A)*A3*rho^2*x(1))-2*A*x(3)*x(2)/((A3+A)*A3*rho*x(1))+...
     2*A3*g/(A3+A)+2*A3*p3/((A3+A)*rho*x(1))-2*A3*p0*L/((A3+A)*rho*x(1)*(L-x(1)))+...
     2*A3*p0*h0/((A3+A)*rho*x(1)*(L-x(1)));

 u=((kp*(spam/Rango_VP))*er+((kp*(spam/Rango_VP))/Ti)*x(4))+U;

    xdot(1)= x(2);

    xdot(2)= -A3*x(2)^2/((A3+A)*x(1))+x(2)^2*A^2/((A3+A)*A3*x(1))+...
     A1*b0/((A3+A)*rho*lB1)+x(3)*b1/((A3+A)*rho^2*lB1)+...
     x(3)^2*b2/((A3+A)*rho^3*A1*lB1)-A1*p0*L/((A3+A)*rho*lB1*(L-x(1)))+...
     A1*p0*h0/((A3+A)*rho*lB1*(L-x(1)))-x(1)*A1*g/((A3+A)*lB1)+...
     A1*g*DeltaL1/((A3+A)*lB1)-(1/2)*f1*x(3)^2/((A3+A)*rho^2*lB1*A1)+...
     x(3)^2/((A3+A)*A3*rho^2*x(1))-2*A*x(3)*x(2)/((A3+A)*A3*rho*x(1))+...
     2*A3*g/(A3+A)+2*A3*p3/((A3+A)*rho*x(1))-2*A3*p0*L/((A3+A)*rho*x(1)*(L-x(1)))+...
     2*A3*p0*h0/((A3+A)*rho*x(1)*(L-x(1)));
 
 xdot(3)=A1*(b0+x(3)*b1/(A1*rho)+...
        x(3)^2*b2/(A1^2*rho^2))/lB1-A1*(p0*(L-h0)/(L-x(1))+...
        rho*g*(x(1)-DeltaL1))/lB1-(1/2)*f1*x(3)^2/(lB1*A1*rho);
    

 xdot(4)=Vref-x(1);
 
 xdot(5)=(u-x(5))*kt/(R*V);
 
 xdot(6)=x(7);
 
 xdot(7)=(Av*x(5)-c1*x(6)-c2*x(7)+c3*x(6)+c4*x(6)^3-Fs-Fd)/m;
    %Presion
 xdot(8) = (x(2)*p0*(L - h0))/(L - x(1))^2;

 xdot(9) = ((2*A3*rho)/x(1)) * ( (-p3/rho) + ((p0*(L - h0))/(rho*(L-x(1)))) - 1/2*(x(9)/A3*rho)^2 + (1/2)*x(2)^2 - g*x(1)) +...
            A3*rho*dx2;
 

xdot = xdot';