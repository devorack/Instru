function dVc_dt = ec_differential(t, Vc, R2, Req,Rm, E, C,u)
    % Ecuación diferencial para el circuito
    dVc_dt = ( (R2 * E * u) - ((R2 +Req) * (Vc) )) / (C * ((Rm * Req) + (R2* Req)+ (Rm*R2))); % dVc/dt
end