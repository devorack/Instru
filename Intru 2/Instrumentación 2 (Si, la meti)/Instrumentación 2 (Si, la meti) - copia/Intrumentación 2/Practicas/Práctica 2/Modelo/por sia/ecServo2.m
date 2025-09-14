function dx = ecServo2(~, x) 
   
    global m c1 c2 c3 c4 Fs Fd Ad Kt R V u n a A p1 p2 p3 p4 p5 p6 p7 p8
    

        dx(1) = x(2); %Desplazamiento del vastago
        dx(2) = (1/m)*(-c2*x(2)-c4*(x(1))^3-(c1-c3)*x(1)-Fs-Fd+Ad*x(3)); %Velocidad del desplazamiento del vastago
        dx(3) = ((u-x(3))*Kt)/(R*V); %Dinamica de la presion dentro de la camara de diafragma
    
        dx = dx';


    
end