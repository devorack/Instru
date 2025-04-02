% ----- Ecuaciones continuas del sistema RLC -----
function dydt = rlc_system(t, y, R, Rc, Rl,Rml,Rf, L, C, E)
    Il = y(1);
    Vc = y(2);
    
    dIdt= ((-R*Rc - R*Rf - R*Rl - R*Rml - Rc*Rf - Rc*Rl - Rc*Rml)/ ((R+Rc)*L))* Il - (R/((R+Rc)*L))*Vc+ E/L ;

    dVcdt = (R / (R+Rc)*C )* Il - Vc / ((R+Rc)*C);
    
    dydt = [dIdt; dVcdt];
end