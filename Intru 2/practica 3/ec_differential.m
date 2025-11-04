function dy_dt = ec_differential(t,Y)
    global A A1 rho L DeltaL1 Kp g b0 b1 b2 lB1 h0 p0 p3 A3
    
    %cervo
    h = Y(1); %altura
    Vh = Y(2); %Velocidad altura
    Qi = Y(3); %Caudal
    P = Y(4); %presion
    Qout = Y(5); %Caudal
    
   
    dh_dt = Vh;
    dQi_dt = A1*(b0 + Qi*b1*1/A1*1/rho + Qi^2*b2*1/A1^2*1/rho^2)*1/lB1 - A1*(p0*(L - h0)*1/(L - h) + ...
        rho*g*(h - DeltaL1))*1/lB1 - Kp*Qi^2/((2*lB1)*A1*rho);

    dVh_dt = (2*A3)*((A3 + A)*rho*((A3 + A)/(2*A3) - 1)*dh_dt^2*1/A3 + h*dQi_dt/(2*A3) + ...
        Qi^2/((2*rho)*A3^2) + (1 - (A3 + A)*1/A3)*Qi*dh_dt*1/A3 + rho*g*h + p3 - ...
        p0*(L - h0)*1/(L - h))*1/(A3 + A)*1/rho*1/h;
    
    dP_dt = dh_dt*p0*(L - h0)*1/(L - h)^2;
    
    dQout = (2*A3)*rho*(-p3*1/rho + p0*(L - h0)*1/rho*1/(L - h) - Qout^2/((2*A3^2)*rho^2) + dh_dt^2/2 - ...
        g*h)*1/h + A3*rho*dVh_dt;


    dy_dt = [dh_dt; dQi_dt;dVh_dt;dP_dt;dQout];

end