function dx = ecServo(~, x); 

    global m c1 c2 c3 c4 Fs Fd Ad Kt R V u a1 A3 A1 p g pinicial hinicial l lb1 p3 f1 poly dQi deltaL A dX2

    poly = (1/(A1^2)*(p^2))*(-2830)*x(3)^2 + (1/A1*p)*(-6674.9)*x(3) + 301692;
    dQi = ((A1/lb1)*poly - (A1/lb1)*( pinicial*((l - hinicial)/(l - x(1))) + p*g*(x(1) - deltaL) ) - (f1/(2*lb1*A1*p))*x(3)^2);
    A3 = -24.35*x(4)^3 + 0.607*x(4)^2 - 0.007675*x(4) + 0.0000379;
    a1 = 1/2*((A + A3)/A3);
    dX2 = (1/(a1*p*x(1))) * ( (2*a1*p*(a1 - 1))*x(2)^2 + (1/2*A3*x(1)*dQi + (1/2*p*A3^2)*x(3)^2) )*0 + ... 
            (1/(a1*p*x(1))) * ( ((1 - 2*a1)/A3)*0*x(3)*x(2) + p*g*x(1) + p3 - ( pinicial*((l - hinicial)/(l - x(1)))) ) ;  
    
    %Altura
    dx(1) = x(2);
    %Velocidad del agua en el tanque    
    dx(2) = (1/(a1*p*x(1))) * ( (2*a1*p*(a1 - 1))*x(2)^2 + (1/2*A3*x(1)*dQi + (1/2*p*A3^2)*x(3)^2) )*0 + ... 
            (1/(a1*p*x(1))) * ( ((1 - 2*a1)/A3)*0*x(3)*x(2) + p*g*x(1) + p3 - ( pinicial*((l - hinicial)/(l - x(1)))) ) ;        
    %Entrada del Fluido
    dx(3) = ((A1/lb1)*poly - (A1/lb1)*( pinicial*((l - hinicial)/(l - x(1))) + p*g*(x(1) - deltaL) ) - (f1/(2*lb1*A1*p))*x(3)^2);    
    %Salida del Fluido
    dx(4) = (2*A3*p/x(1)) * ( (-p3/p) + ((pinicial*(l - hinicial))/(p*(l-x(1)))) - 1/2*(x(4)/A3*p)^2 + (1/2)*x(2)^2 - g*x(1)) +...
            A3*p*dX2;
    %Presion
    dx(5) = (x(2)*pinicial*(l - hinicial))/(l - x(1))^2;
    %Desplazamiento del vastago
    dx(6) = x(7); 
    %Velocidad del desplazamiento del vastago
    dx(7) = (1/m)*(-c2*x(7)-c4*(x(6)).^3-(c1-c3)*x(6)-Fs-Fd+Ad*x(8)); 
    %Dinamica de la presion dentro de la camara de diafragma
    dx(8) = ((u-x(8))*Kt)/(R*V); 
    
    dx = dx';
end