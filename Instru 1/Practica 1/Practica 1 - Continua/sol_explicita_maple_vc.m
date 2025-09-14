function dVc_dt = sol_explicita_maple_vc(t, Vc, R2, Req,Rm, E, C)
    % Ecuación diferencial para el circuito
    
    %dIc_dt = -Ic(t)*(R2 + Req)*1/C*1/((R2 + Rm)*Req + R2*Rm); % dVc/dt
    %dVc_dt = ( (R2 * E * u) - ((R2 +Req) * (Vc) )) / (C * ((Rm * Req) + (R2* Req)+ (Rm*R2))); % dVc/dt
    dVc_dt =((-R2*E + Vc*(R2 + Req))*exp(-(R2 + Req)*t*1/((R2 + Rm)*Req + R2*Rm)*1/C) + R2*E)*1/(R2 + Req);
end