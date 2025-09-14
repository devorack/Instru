function dVc_dt = ec_differential(t, Vc, R2, Req,Rm, E, C,u)
    % Ecuación diferencial para el circuito
    
    %dIc_dt = -Ic(t)*(R2 + Req)*1/C*1/((R2 + Rm)*Req + R2*Rm); % dVc/dt
    %dVc_dt = ( (R2 * E * u) - ((R2 +Req) * (Vc) )) / (C * ((Rm * Req) + (R2* Req)+ (Rm*R2))); % dVc/dt
    dVc_dt = ( -Vc * (R2 + Req) ) / ( C* (  ((Rm + R2)*Req ) + (R2*Rm) ));
end