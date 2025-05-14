function dy_dt = ec_differential(t,Y,E,u)
    global R Rc Rf Rl Rml L C 
    Vc = Y(1);
    Il = Y(2);
    Ic = Y(3);
    Vl = Y(4);
        
    dVc_dt = (Il*R - Vc)/((R + Rc)*C);
    dIl_dt = ( (E*u *(R + Rc)) - (Vc * R)-((R*Rc + Rf*R + Rl*R + Rml*R + Rf*Rc + Rl*Rc + Rml*Rc)*(Il)) ) / ((R + Rc) * L);

    %discontinuas 
    dIc_dt = (Vl*R/L - Ic/C)/(R + Rc);
    
    dVl_dt =  (-((Rc + Rf + Rl + Rml)*R + Rc*(Rf + Rl + Rml))*C*Vl - Ic*R*L)/((R + Rc)*L*C);

    dy_dt = [dVc_dt; dIl_dt;dIc_dt;dVl_dt];

end