function dY_dt = ec_differential(t,Y,E,u)
    global R Rc Rf Rl Rml L C 
    Il_t = Y(1);
    Vc_t = Y(2);
    
    dIl_dt = ((-(R*Rc) - (Rf*R) - (Rl*R) - (Rml*R) - (Rf*Rc) - (Rl*Rc) - (Rml*Rc))*Il_t + (u*E*(R + Rc)) - (Vc_t*R))/(R + Rc)*L;
    dVc_dt = ((Il_t*R) - Vc_t)/(R + Rc)*C;
    
    dY_dt = [dIl_dt; dVc_dt];
end