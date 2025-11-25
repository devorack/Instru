function dy_dt = ec_differential(t,Y)
    global m c1 c2 c3 c4 Fs Fd Ad Kt R V u alpha beta Area a0 a1 a2 a3 a4
    
    %cervo
    Xv1 = Y(1); %Desplazamiento
    Xv2 = Y(2); %Velocidad
    Pd = Y(3); %Presion dentro del vastago
    %e = vref - dy_dt;
    %tanque
    h = max (Y(4),0);

    % Flujo de entrada polinómico
    Qi = a3*Xv1^3 + a2*Xv1^2 + a1*Xv1 + a0;
    disp(Qi);
  

    Qout = alpha * h^beta;
    dh_dt = (((Qi*3.85))/Area - Qout);
        
    dXv1_dt = Xv2;
    dXv2_dt = (1/m)*(-c2*Xv2-c4*(Xv1)^3-(c1-c3)*Xv1-Fs-Fd+Ad*Pd);
    dPd_dt = ((u-Pd)*Kt)/(R*V);
    %de_dt = e;


    dy_dt = [dXv1_dt; dXv2_dt;dPd_dt;dh_dt];

end