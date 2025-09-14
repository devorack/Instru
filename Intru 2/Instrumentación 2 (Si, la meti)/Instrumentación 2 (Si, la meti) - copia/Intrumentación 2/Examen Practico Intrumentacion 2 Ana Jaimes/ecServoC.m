function dx = ecServoC(~, x) 
   
    global valor_deseado kp ki m c1 c2 c3 c4 Fs Fd Ad Kt R V n a A p1 p2 p3 p4 p5 p11 p22 p33 p44 p55 p66
        
        ubar = ((p11*(valor_deseado)^5) +(p22*(valor_deseado)^4) + (p33*(valor_deseado)^3) + (p44*(valor_deseado)^2) ...
            + p55*valor_deseado + p66);  % Hallando el valor de ubar correcto
        
        e = valor_deseado - x(4);   %Error
        u = (ubar + (kp*e + ki*x(5)));    % Senal de Control no lineal

        dx(1) = x(2); %Desplazamiento del vastago
        dx(2) = (1/m)*(-c2*x(2)-c4*(x(1)).^3-(c1-c3)*x(1)-Fs-Fd+Ad*x(3)); %Velocidad del desplazamiento del vastago
        dx(5) = x(4) - valor_deseado;
        dx(3) = ((u - x(3))*Kt)/(R*V);
        f = ((p1*x(1).^4 + p2*x(1).^3 + p3*x(1).^2 + p4*x(1) + p5));
        dx(4) = ((f*3.85)/A)-(a*x(4).^n);
        dx(5) = valor_deseado - x(4);
        disp(x(4))
    dx = dx'; 
end