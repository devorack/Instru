function dVc_dt = ec_differential(t, Vc, R2, Req,Rm, E, C,u)
    % Ecuación diferencial para el circuito
    
    %dIc_dt = -Ic(t)*(R2 + Req)*1/C*1/((R2 + Rm)*Req + R2*Rm); % dVc/dt

    dVc_dt = ( ((-R2 - Req)*Vc) + (R2*E*u*C) ) / ( C* (  ((Rm + Req)*R2 ) + (Req*Rm) ));
end