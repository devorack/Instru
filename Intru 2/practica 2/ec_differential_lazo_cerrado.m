function dx = ec_differential_lazo_cerrado(~,x)
    global m c1 c2 c3 c4 Fs Fd Ad Kt R V alpha beta Area a0 a1 a2 a3 Rref KpPI KiPI
    
     % Estados:
    % x(1): Desplazamiento del vástago
    % x(2): Velocidad del vástago
    % x(3): Presión (donde el control actúa)
    % x(4): Nivel del tanque (variable medida)
    % x(5): Estado integrador (integral del error)

    dx = zeros(5, 1);
    % Calcula el error de control sobre el nivel del tanque:
    error = Rref - x(4);
    u_control = KpPI * error + KiPI * x(5);

    % Flujo de entrada polinómico
    Qi = a3*x(1)^3 + a2*x(1)^2 + a1*x(1) + a0;
    %disp(Qi);
  
        
    dx(1) = x(2);
    dx(2) = (1/m)*(-c2*x(2)-c4*(x(1))^3-(c1-c3)*x(1)-Fs-Fd+Ad*x(3));
    dx(3) = ((u_control-x(3))*Kt)/(R*V);
    dx(4) = (((Qi*3.85))/Area - (alpha * x(4)^beta));
    dx(5) = error;
    
end